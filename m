From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Tue, 10 Feb 2009 10:28:08 +0000
Subject: Re: INTC issue
Message-Id: <499156B8.5070903@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <498AD5E4.8050809@renesas.com>
In-Reply-To: <498AD5E4.8050809@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus-san,

Thank you very much for your comment!

Magnus Damm wrote:
> Hi Shimoda-san,
> 
> Thanks for bringing up this issue and thanks for the patch!
> 
- snip -
> 
> Hm, counter may work half-ok, but I think we end up with broken logic
> anyhow. Counters would result in that enabling and disabling of
> interrupts sometimes result in enable/disable depending on the count
> value. For interrupt sources belonging to a single driver we can
> probably live with that, but it may become very strange if we share
> enable bit between multiple drivers. A driver most likely expects that
> interrupt disable really disables interrupts. =)
> 
> I would prefer to map all vectors that share a enable/disable bit to a
> single interrupt number instead. This is somewhat similar to interrupt
> sharing. The common irq code handles interrupt count for us. Look at
> desc->depth inside linux/kernel/irq/*.
> 
> As an example, right now in the sh7785 dma case you have 14 vectors
> divided into 7 DMAC0 sources and 7 DMAC1 sources. A total of 14 dma
> interrupts in linux. I would prefer to map them to 2 linux interrupts
> instead, one for DMAC0 and one for DMAC1. So all DMAC0 vectors map to
> the DMAC0 linux interrupt and same for DMAC1. Each linux interrupt can
> be enabled and disabled as a regular interrupt source.
> 
> Would that work for you? I hope you can determine interrupt source by
> checking status bits in the dma hardware block. Or maybe you can't and
> need separate interrupt handlers?

I sent the patch.
http://marc.info/?l=linux-sh&m3417952130537&w=2
But, I did not write down the explanation of this patch...
I implemented the "maps" to this patch. The "enabled_bit" is it.
Would you check this patch?

Thanks,
Yoshihiro Shimoda

