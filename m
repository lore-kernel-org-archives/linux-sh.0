From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Tue, 17 Feb 2009 06:21:51 +0000
Subject: Re: INTC issue
Message-Id: <499A577F.8070401@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <498AD5E4.8050809@renesas.com>
In-Reply-To: <498AD5E4.8050809@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus-san!

I am very sorry for late reply.

Magnus Damm wrote:
- snip -
> How about the attached patch? It should fix the issue on sh7785 with
> only a few lines of added code.

Thank you for your comment and patch.

> Note that with this patch you now should use only one linux interrupt
> for the special hardware blocks that come with multiple vectors but
> only a single masking method. Look at the DMAC0/DMAC1/SCIF0/SCIF1 intc
> table changes for more information. The interrupt calculated from the
> first INTC_VECT in vectors[] is used to for all vectors with the same
> enum_id.
> 
> Please let me know if the patch solves your issue. I'll break out the
> patch and fix up other processors and post a proper patch set in a
> little while if this change solves your problem.

When I used this patch and change DMAC driver, my issue was solved!
But I think that I might as well change DMAC only. For example, when SCIF
driver get same interrupt number, SCIF driver use sci_mpxed_interrupt().
Because this function check interrupt flag, overheads increase just a little.

The DMAC driver changes:
 - fix register maps for SH7785. :)
 - change DMAC irq number.
 - add IRQF_SHARED flag of request_irq().
 - add dummy args of request_irq() in sh_dmac_init().

Thanks,
Yoshihiro Shimoda

