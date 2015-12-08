From: Simon Horman <horms@verge.net.au>
Date: Tue, 08 Dec 2015 07:49:40 +0000
Subject: Re: [PATCH 1/2] usb: renesas_usbhs: add fallback compatibility string
Message-Id: <20151208074932.GA5663@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1449553911-21412-1-git-send-email-horms+renesas@verge.net.au>
 <1449553911-21412-2-git-send-email-horms+renesas@verge.net.au>
 <87egex5vfl.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87egex5vfl.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, Dec 08, 2015 at 06:05:51AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > Add fallback compatibility string.
> > This is in keeping with the fallback scheme being adopted wherever
> > appropriate for drivers for Renesas SoCs.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> (snip)
> > +	{
> > +		.compatible = "renesas,usbhs",
> > +		.data = (void *)USBHS_TYPE_RCAR_GEN2,
> > +	},
> >  	{ },
> >  };
> 
> I think this is too much. This driver is used not only from R-Car Gen2.
> It will work as normal mode if .data was 0.
> see usbhs_parse_dt()

Are you suggesting that we remove USBHS_TYPE_RCAR_GEN2 from the driver?
