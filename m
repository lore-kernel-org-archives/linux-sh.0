From: Simon Horman <horms@verge.net.au>
Date: Tue, 13 May 2014 21:39:40 +0000
Subject: Re: [PATCH] ASoC: rsnd: Fix warnings due to improper printk formats
Message-Id: <20140513213935.GA6784@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1399936220-17123-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <871tvysge5.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871tvysge5.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, alsa-devel@alsa-project.org

On Mon, May 12, 2014 at 04:53:44PM -0700, Kuninori Morimoto wrote:
> 
> Hi
> 
> Thank you for your help
> 
> > Use the %pap printk specifier to print resource_size_t variables. This
> > fixes warnings on platforms where resource_size_t has a different size
> > than int.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> 
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Morimoto-san, should Mark Brown need to be CCed on a re-post
in order for him to see this?

> >  sound/soc/sh/rcar/gen.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > Would it be possible to get this patch in v3.16 ?
> > 
> > diff --git a/sound/soc/sh/rcar/gen.c b/sound/soc/sh/rcar/gen.c
> > index 50a1ef3..1d5c025 100644
> > --- a/sound/soc/sh/rcar/gen.c
> > +++ b/sound/soc/sh/rcar/gen.c
> > @@ -252,13 +252,13 @@ static int rsnd_gen2_probe(struct platform_device *pdev,
> >  		return ret;
> >  
> >  	dev_dbg(dev, "Gen2 device probed\n");
> > -	dev_dbg(dev, "SCU  : %08x => %p\n", scu_res->start,
> > +	dev_dbg(dev, "SCU  : %pap => %p\n", &scu_res->start,
> >  		gen->base[RSND_GEN2_SCU]);
> > -	dev_dbg(dev, "ADG  : %08x => %p\n", adg_res->start,
> > +	dev_dbg(dev, "ADG  : %pap => %p\n", &adg_res->start,
> >  		gen->base[RSND_GEN2_ADG]);
> > -	dev_dbg(dev, "SSIU : %08x => %p\n", ssiu_res->start,
> > +	dev_dbg(dev, "SSIU : %pap => %p\n", &ssiu_res->start,
> >  		gen->base[RSND_GEN2_SSIU]);
> > -	dev_dbg(dev, "SSI  : %08x => %p\n", ssi_res->start,
> > +	dev_dbg(dev, "SSI  : %pap => %p\n", &ssi_res->start,
> >  		gen->base[RSND_GEN2_SSI]);
> >  
> >  	return 0;
> > @@ -345,11 +345,11 @@ static int rsnd_gen1_probe(struct platform_device *pdev,
> >  		return ret;
> >  
> >  	dev_dbg(dev, "Gen1 device probed\n");
> > -	dev_dbg(dev, "SRU : %08x => %p\n",	sru_res->start,
> > +	dev_dbg(dev, "SRU : %pap => %p\n",	&sru_res->start,
> >  						gen->base[RSND_GEN1_SRU]);
> > -	dev_dbg(dev, "ADG : %08x => %p\n",	adg_res->start,
> > +	dev_dbg(dev, "ADG : %pap => %p\n",	&adg_res->start,
> >  						gen->base[RSND_GEN1_ADG]);
> > -	dev_dbg(dev, "SSI : %08x => %p\n",	ssi_res->start,
> > +	dev_dbg(dev, "SSI : %pap => %p\n",	&ssi_res->start,
> >  						gen->base[RSND_GEN1_SSI]);
> >  
> >  	return 0;
> > -- 
> > Regards,
> > 
> > Laurent Pinchart
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
