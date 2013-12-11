From: Simon Horman <horms@verge.net.au>
Date: Wed, 11 Dec 2013 03:43:08 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7778: add SSIx DMAEngine support
Message-Id: <20131211034306.GQ19992@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87r49ubr9m.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r49ubr9m.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 10, 2013 at 07:21:28PM -0800, Kuninori Morimoto wrote:
> Hi Simon
> 
> Unfortunately, _id with () can't solve this checkpatch issue.
> And, I guess this message wants me 
> something like do {} while(0) in this macro.
> But, it is not good match on this patch.
> 
> I'm not sure how to solve this checkpatch issue.
> But, checkpatch's warning/error sometimes requests
> impossible solution...

Thanks, I understand. I'll take the patch as-is.

> 
> > Unfortunately checkpatch seems unhappy about this.
> > I think it wants you to surround _id with () inside the macro.
> > Could you fix it up?
> > 
> > ERROR: Macros with complex values should be enclosed in parenthesis
> > #99: FILE: arch/arm/mach-shmobile/setup-r8a7778.c:322:
> > +#define HPBDMA_SSI(_id)				\
> > +{						\
> > +	.id	= HPBDMA_SLAVE_SSI## _id ##_TX,	\
> > +	.addr	= 0xffd91008 + (_id * 0x40),	\
> > +	.dcr	= HPB_DMAE_DCR_CT |		\
> > +		  HPB_DMAE_DCR_DIP |		\
> > +		  HPB_DMAE_DCR_SPDS_32BIT |	\
> > +		  HPB_DMAE_DCR_DMDL |		\
> > +		  HPB_DMAE_DCR_DPDS_32BIT,	\
> > +	.port   = _id + (_id << 8),		\
> > +	.dma_ch = (28 + _id),			\
> > +}, {						\
> > +	.id	= HPBDMA_SLAVE_SSI## _id ##_RX,	\
> > +	.addr	= 0xffd9100c + (_id * 0x40),	\
> > +	.dcr	= HPB_DMAE_DCR_CT |		\
> > +		  HPB_DMAE_DCR_DIP |		\
> > +		  HPB_DMAE_DCR_SMDL |		\
> > +		  HPB_DMAE_DCR_SPDS_32BIT |	\
> > +		  HPB_DMAE_DCR_DPDS_32BIT,	\
> > +	.port   = _id + (_id << 8),		\
> > +	.dma_ch = (28 + _id),			\
> > +}
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
