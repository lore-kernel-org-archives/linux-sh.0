From: Simon Horman <horms@verge.net.au>
Date: Fri, 17 Jun 2011 05:15:41 +0000
Subject: Re: [RFC][PATCH 4/6] dmaengine: shdma: add is_usbdmac flag
Message-Id: <20110617051540.GF22265@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <w3ppqmdp1m8.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3ppqmdp1m8.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jun 17, 2011 at 02:00:39PM +0900, Kuninori Morimoto wrote:
> 
> Dear Simon
> 
> Thank you for checking patch
> 
> > > +	/* USB-DMAC needs TEND settings */
> > > +	if (shdev->pdata->is_usbdmac)
> > > +		sh_dmae_writel(sh_chan, 0xFFFFFFFF, TEND);
> > 
> > Perhaps instead of is_usbdmac, which is knowledge of a driver,
> > needs_tend_set, which is feature knowledge, would be better.
> 
> Thanks. good idea
> 
> > > +	/* USB-DMAC doesn't need DMARS settings */
> > > +	if (pdata->is_usbdmac)
> > > +		return 0;
> > 
> > Likewise, perhaps needs_dmars_set?
> 
> I don't want to change existing DMA settins.
> How about "no_dmars" ?
> 
> if (no_dmars)
>     return 0;

Sure, pdata->no_dmars makes sense.

> 
> Best regards
> --
> Kuninori Morimoto
>  
> 
