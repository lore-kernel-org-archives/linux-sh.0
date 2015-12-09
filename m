From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 09 Dec 2015 06:29:07 +0000
Subject: Re: [PATCH 1/2] usb: renesas_usbhs: add fallback compatibility string
Message-Id: <87io48rvce.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449553911-21412-1-git-send-email-horms+renesas@verge.net.au>
	<1449553911-21412-2-git-send-email-horms+renesas@verge.net.au>
	<87egex5vfl.wl%kuninori.morimoto.gx@renesas.com>
	<20151208074932.GA5663@verge.net.au>
	<87a8pl5oms.wl%kuninori.morimoto.gx@renesas.com>
	<20151209023714.GD17706@verge.net.au>
	<87si3crzzm.wl%kuninori.morimoto.gx@renesas.com>
	<20151209052957.GA20831@verge.net.au>
In-Reply-To: <20151209052957.GA20831-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org


Hi Simon

> > > (As Sergei noted elsewhere, "renesas,rcar-usbhs" is consistent
> > >  with what I documented elsewhere in the patch)
> > 
> > "renesas,rcar-usbhs" is better,
> > but I guess you want to have "renesas,rcar-gen2-usbhs" ?
> > 
> > My understanding is these
> > 
> >  * renesas,usbhs-r8a77xx	# SoC specific
> >  * renesas,rcar-usbhs		# R-Car common
> >  * renesas,rcar-gen2-usbhs	# R-Car Gen2 common
> >  * renesas,rcar-gen3-usbhs	# R-Car Gen3 common
> >  * renesas,usbhs		# Renesas USBHS common
> > 
> 
> I was intentionally including gen3 as well. So I think we have two options:
> 
> 1. renesas,rcar-usbhs
> 2. renesas,rcar-gen2-usbhs and renesas,rcar-gen3-usbhs

Renesas USB always have pick feature/settings.
Thus, generic name (= "renesas,rcar-usbhs") is very risky IMO.
I think 2 is more safety.

