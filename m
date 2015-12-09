From: Simon Horman <horms@verge.net.au>
Date: Wed, 09 Dec 2015 06:42:04 +0000
Subject: Re: [PATCH 1/2] usb: renesas_usbhs: add fallback compatibility string
Message-Id: <20151209064158.GA9037@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1449553911-21412-1-git-send-email-horms+renesas@verge.net.au>
 <1449553911-21412-2-git-send-email-horms+renesas@verge.net.au>
 <87egex5vfl.wl%kuninori.morimoto.gx@renesas.com>
 <20151208074932.GA5663@verge.net.au>
 <87a8pl5oms.wl%kuninori.morimoto.gx@renesas.com>
 <20151209023714.GD17706@verge.net.au>
 <87si3crzzm.wl%kuninori.morimoto.gx@renesas.com>
 <20151209052957.GA20831@verge.net.au>
 <87io48rvce.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87io48rvce.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, Dec 09, 2015 at 06:29:07AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > > (As Sergei noted elsewhere, "renesas,rcar-usbhs" is consistent
> > > >  with what I documented elsewhere in the patch)
> > > 
> > > "renesas,rcar-usbhs" is better,
> > > but I guess you want to have "renesas,rcar-gen2-usbhs" ?
> > > 
> > > My understanding is these
> > > 
> > >  * renesas,usbhs-r8a77xx	# SoC specific
> > >  * renesas,rcar-usbhs		# R-Car common
> > >  * renesas,rcar-gen2-usbhs	# R-Car Gen2 common
> > >  * renesas,rcar-gen3-usbhs	# R-Car Gen3 common
> > >  * renesas,usbhs		# Renesas USBHS common
> > > 
> > 
> > I was intentionally including gen3 as well. So I think we have two options:
> > 
> > 1. renesas,rcar-usbhs
> > 2. renesas,rcar-gen2-usbhs and renesas,rcar-gen3-usbhs
> 
> Renesas USB always have pick feature/settings.
> Thus, generic name (= "renesas,rcar-usbhs") is very risky IMO.
> I think 2 is more safety.

Sure, better safe than sorry.
