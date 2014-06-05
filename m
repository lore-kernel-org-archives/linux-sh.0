From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 05 Jun 2014 10:09:46 +0000
Subject: Re: [PATCH 5/8] shdmac: fdt: wire r8a7790 for device tree usage.
Message-Id: <87bnu7is5y.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1401898455-31064-6-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1401898455-31064-6-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Ben

> >>  static const struct of_device_id sh_dmae_of_match[] = {
> >> -	{.compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid,},
> >> +	{ .compatible = "renesas,shdma-r8a73a4", .data = r8a73a4_shdma_devid },
> >> +	{ .compatible = "renesas,dma-r8a7790", .data = &shdma_arm_info },
> >>  	{}
> >>  };
> > 
> > renesas,shdma-r8a7790 ?
> > renesas,dma-r8a7790 ?
> > 
> > Is this typo ? or on  purpose ?
> 
> Thanks for the feedback.
> 
> I thought dma was a pretty good description. Do we need to call this
> shdma-r8a7790?

I'm not sure, but historically we called it as "shdma".
Renesas SoC has many DMACs, not only SYS-DMAC.
Maybe, this is natural ?
       SYS-DMAC -> shdma
       USB-DMAC -> usbdma
       SU-DMAC  -> sudma
       ...
