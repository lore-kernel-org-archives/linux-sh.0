From: Simon Horman <horms@verge.net.au>
Date: Wed, 09 Dec 2015 02:37:20 +0000
Subject: Re: [PATCH 1/2] usb: renesas_usbhs: add fallback compatibility string
Message-Id: <20151209023714.GD17706@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1449553911-21412-1-git-send-email-horms+renesas@verge.net.au>
 <1449553911-21412-2-git-send-email-horms+renesas@verge.net.au>
 <87egex5vfl.wl%kuninori.morimoto.gx@renesas.com>
 <20151208074932.GA5663@verge.net.au>
 <87a8pl5oms.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a8pl5oms.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Tue, Dec 08, 2015 at 08:32:49AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > > Add fallback compatibility string.
> > > > This is in keeping with the fallback scheme being adopted wherever
> > > > appropriate for drivers for Renesas SoCs.
> > > > 
> > > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > > ---
> > > (snip)
> > > > +	{
> > > > +		.compatible = "renesas,usbhs",
> > > > +		.data = (void *)USBHS_TYPE_RCAR_GEN2,
> > > > +	},
> > > >  	{ },
> > > >  };
> > > 
> > > I think this is too much. This driver is used not only from R-Car Gen2.
> > > It will work as normal mode if .data was 0.
> > > see usbhs_parse_dt()
> > 
> > Are you suggesting that we remove USBHS_TYPE_RCAR_GEN2 from the driver?
> 
> I mean this
> 
> +	{
> +		.compatible = "renesas,usbhs",
> +	},

(As Sergei noted elsewhere, "renesas,rcar-usbhs" is consistent
 with what I documented elsewhere in the patch)

My understanding is that will cause the driver to operate in a different manner
to if USBHS_TYPE_RCAR_GEN2 was set. And thus meaning
of the generic and SoC-specifc compatibility strings will cause
the driver to operate differently.

Currently the only compat strings present are as follows:

* renesas,usbhs-r8a7790
* renesas,usbhs-r8a7791
* renesas,usbhs-r8a7794
* renesas,usbhs-r8a7795

And they all set USBHS_TYPE_RCAR_GEN2 (even though r8a7795 is a Gen3 SoC).

What I am aiming is either:
* A compatibility string for R-Car or;
* Two compatibility strings, one for R-Car Gen2 and one for R-Car Gen3

And for this new compatibility string or strings to operate the same
way as the current compatibility strings.


Looking over the driver its not clear to me why the
non-USBHS_TYPE_RCAR_GEN2 case is handled by the code as
there are no compatibility strings present that trigger that mode of
operation. I feel that I must be missing something.

