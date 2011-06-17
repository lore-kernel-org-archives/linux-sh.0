From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 17 Jun 2011 07:10:28 +0000
Subject: Re: [RFC][PATCH 1/6] dmaengine: shdma: add chcr_write/read function
Message-Id: <w3pd3idorvf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3ptybpp1n8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3ptybpp1n8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Guennadi

Thank you for checking patch

> > > diff --git a/drivers/dma/shdma.h b/drivers/dma/shdma.h
> > > index 6c73b65..1305b67 100644
> > > --- a/drivers/dma/shdma.h
> > > +++ b/drivers/dma/shdma.h
> > > @@ -47,6 +47,7 @@ struct sh_dmae_device {
> > >  	struct list_head node;
> > >  	u32 __iomem *chan_reg;
> > >  	u16 __iomem *dmars;
> > > +	u32 chcr_offset;
> 
> Actually, I think, it would be better to remove this. We already have a 
> few fields, providing various register address and internal structure 
> differences, they all are stored in struct sh_dmae_pdata, which you can 
> always easily accessed as shdev->pdata. It would make the driver look more 
> consistent, if we did the same with this field.

Hmm...
But this mean I should modify all of existing DMA settings, correct ?

If you agree below code, it is easy.

static int __init sh_dmae_probe(xxx)
{
        ...

	if (!shdev->pdata->chcr_offset)
        	shdev->pdata->chcr_offset = CHCR;

        ...
}

Best regards
--
Kuninori Morimoto
 
