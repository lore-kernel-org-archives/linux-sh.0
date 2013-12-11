From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 11 Dec 2013 03:21:28 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7778: add SSIx DMAEngine support
Message-Id: <87k3fcnkcs.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r49ubr9m.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r49ubr9m.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon

Unfortunately, _id with () can't solve this checkpatch issue.
And, I guess this message wants me 
something like do {} while(0) in this macro.
But, it is not good match on this patch.

I'm not sure how to solve this checkpatch issue.
But, checkpatch's warning/error sometimes requests
impossible solution...

> Unfortunately checkpatch seems unhappy about this.
> I think it wants you to surround _id with () inside the macro.
> Could you fix it up?
> 
> ERROR: Macros with complex values should be enclosed in parenthesis
> #99: FILE: arch/arm/mach-shmobile/setup-r8a7778.c:322:
> +#define HPBDMA_SSI(_id)				\
> +{						\
> +	.id	= HPBDMA_SLAVE_SSI## _id ##_TX,	\
> +	.addr	= 0xffd91008 + (_id * 0x40),	\
> +	.dcr	= HPB_DMAE_DCR_CT |		\
> +		  HPB_DMAE_DCR_DIP |		\
> +		  HPB_DMAE_DCR_SPDS_32BIT |	\
> +		  HPB_DMAE_DCR_DMDL |		\
> +		  HPB_DMAE_DCR_DPDS_32BIT,	\
> +	.port   = _id + (_id << 8),		\
> +	.dma_ch = (28 + _id),			\
> +}, {						\
> +	.id	= HPBDMA_SLAVE_SSI## _id ##_RX,	\
> +	.addr	= 0xffd9100c + (_id * 0x40),	\
> +	.dcr	= HPB_DMAE_DCR_CT |		\
> +		  HPB_DMAE_DCR_DIP |		\
> +		  HPB_DMAE_DCR_SMDL |		\
> +		  HPB_DMAE_DCR_SPDS_32BIT |	\
> +		  HPB_DMAE_DCR_DPDS_32BIT,	\
> +	.port   = _id + (_id << 8),		\
> +	.dma_ch = (28 + _id),			\
> +}
