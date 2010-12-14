From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 14 Dec 2010 09:48:16 +0000
Subject: Re: sh: sh7723/7724 nmi: nmi stops DMA transfers
Message-Id: <20101214094816.GD14606@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <95F51F4B902CAC40AF459205F6322F0187A9C8F819@BMK019S01.emtrion.local>
In-Reply-To: <95F51F4B902CAC40AF459205F6322F0187A9C8F819@BMK019S01.emtrion.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 14, 2010 at 10:15:05AM +0100, Szafranek, Michael wrote:
> Yes, I saw this notifier chain but I didn't think that it was so
> simple.  So, I reworked my patch, it's a little simpler than yours. But
> it works fine. I'm not sure which is the preferable.
> 
Now that I think about it, we probably don't really want the NOTIFY_STOP
semantics that mine adds, as we still want nmi_debug to be able to get a
handle on it without the dmaengine chomping it. I also forgot about the
old dma-sh stuff, so I'll fix that up too.

Most of the complexity from my patch comes from dealing with NMI
broadcasting on SMP, in addition to having to support both ARM and SH at
the same time. With NOTIFY_STOP dropped we probably could get away with a
per-device notifier block, but it's preferable to keep the die chains as
short as possible under NMI context, particularly as we want to avoid
contending on any write-side locks.

The in_nmi() check itself is pretty much a blatant hack. We really should
be looking at the die chain value itself, which we can in the dma-sh
case, but not in the ARM case which conveniently doesn't propagate a die
chain based NMI. It will still need a bit of a rethink later on if we
start using a reserved interrupt priority level for pseudo-NMI for the
SMP NMI watchdog, but the DMAC isn't able to latch that in hardware
either.

In any event, I'll rework the patch I have now for a NOTIFY_DONE/OK
fallback and add in the dma-sh bits. I'll do them as two separate commits
so that they're easily backported in to .37 for anyone that wants this
behaviour, though they'll both be intended for the .38 merge window.
