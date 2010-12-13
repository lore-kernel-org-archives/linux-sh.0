From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 13 Dec 2010 10:28:41 +0000
Subject: Re: sh: sh7723/7724 nmi: nmi stops DMA transfers
Message-Id: <20101213102841.GG3750@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <95F51F4B902CAC40AF459205F6322F0187A9C8F819@BMK019S01.emtrion.local>
In-Reply-To: <95F51F4B902CAC40AF459205F6322F0187A9C8F819@BMK019S01.emtrion.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 13, 2010 at 10:19:54AM +0100, Szafranek, Michael wrote:
> I've got a patch that fixes a problem when a NMI occurs which stops DMA
> transfers. The code in the patch resumes the DMA transfers. But it does
> not look like the proper place to solve this problem. If you could give
> me a hint were to move the code.
> 
> diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
> index 0830c2a..67f24bc 100644
> --- a/arch/sh/kernel/traps.c
> +++ b/arch/sh/kernel/traps.c
>         switch (notify_die(DIE_NMI, "NMI", regs, 0, vec & 0xff, SIGINT)) {
>         case NOTIFY_OK:
...

You surely must have noticed the notifier chain literally right above
where you decided to add your hack?

> @@ -111,6 +115,22 @@ BUILD_TRAP_HANDLER(nmi)
>                 printk(KERN_ALERT "Got NMI, but nobody cared. Ignoring...\n");
>                 break;
>         }
> -
> +
> +/* every NMI usually stops all active DMA transfers. These lines simply reanimate the */
> +/* DMA channels so that the transfers are resumed                                     */
> +#if defined(CONFIG_SH_HICO7723) || defined(CONFIG_SH_HICO7724)
> +       dmaor = __raw_readw(SH_DMAC_BASE0 + DMAOR);
> +       dmaor &= ~(DMAOR_NMIF | DMAOR_AE); // resetting NMI flag and address error flag
> +       __raw_writew( dmaor, SH_DMAC_BASE0 + DMAOR );
> +       dmaor |= DMAOR_INIT;               // restarting DMA
> +       __raw_writew( dmaor, SH_DMAC_BASE0 + DMAOR );
> +
> +       dmaor = __raw_readw(SH_DMAC_BASE1 + DMAOR);
> +       dmaor &= ~(DMAOR_NMIF | DMAOR_AE); // resetting NMI flag and address error flag
> +       __raw_writew( dmaor, SH_DMAC_BASE1 + DMAOR );
> +       dmaor |= DMAOR_INIT;               // restarting DMA
> +       __raw_writew( dmaor, SH_DMAC_BASE1 + DMAOR );
> +#endif
> +
>         nmi_exit();
> }
> 
Simply register a die notifier in the DMA driver and take care of this
there.
