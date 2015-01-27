From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 27 Jan 2015 19:01:18 +0000
Subject: Re: [PATCH 2/6] dmaengine: rcar-dmac: Fix spinlock issues in interrupt
Message-Id: <54C7E07E.5000004@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1422379516-1633-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1422379516-1633-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/27/2015 09:55 PM, Laurent Pinchart wrote:

>> On 01/27/2015 08:25 PM, Laurent Pinchart wrote:

>> [...]

>>> Furthermore, as the driver can be used on SMP systems, the IRQ handlers
>>> must use spin_lock_irqsave() instead of spin_lock().

>> Hmm, care to explain why? It's the first time I'm hearing that...
>> This looks especially strange in the context of the current genirq code
>> calling IRQ handlers with interrupts always disabled.

> I should have been more precise here.

> The DMAC has several interrupt sources than can occur simultaneously. While
> genirq should guarantee that an interrupt will not be preempted by another
> interrupt (including itself) on the same CPU, does it offer that guarantee
> across CPUs in an SMP system ?

    No. But spin_lock_irqsave() wouldn't help with that -- it only disables 
interrupts on the local CPU...

>>> Signed-off-by: Laurent Pinchart
>>> <laurent.pinchart+renesas@ideasonboard.com>

WBR, Sergei

