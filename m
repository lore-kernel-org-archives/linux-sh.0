From: Simon Horman <horms@verge.net.au>
Date: Wed, 10 Apr 2013 00:40:41 +0000
Subject: Re: [PATCH] sh-pfc: r8a7779: use RCAR_GP_PIN() on _GP_GPIO() macro
Message-Id: <20130410004041.GB2462@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <878v4sb8y1.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878v4sb8y1.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Apr 09, 2013 at 07:07:40PM +0200, Laurent Pinchart wrote:
> Hi Morimoto-san,
> 
> On Monday 08 April 2013 21:54:18 Kuninori Morimoto wrote:
> > Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > ---
> > 
> > >> Laurent
> > 
> > I guess this patch is correct on your macro idea ?
> 
> Yes it is.
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks. I'll apply this on top of your series if
it gets a positive review from Magnus.

If you end up reposting the series then it would be a tremendous
help to me if you could include this patch in the series.

> 
> >  drivers/pinctrl/sh-pfc/pfc-r8a7779.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> > b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c index 7ba1f21..53cf679 100644
> > --- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> > @@ -80,7 +80,7 @@
> >  #define _GP_PORT_ALL(bank, pin, name, sfx)	name##_##sfx
> > 
> >  #define _GP_GPIO(bank, pin, _name, sfx)					\
> > -	[(bank * 32) + pin] = {						\
> > +	[RCAR_GP_PIN(bank, pin)] = {					\
> >  		.name = __stringify(_name),				\
> >  		.enum_id = _name##_DATA,				\
> >  	}
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
