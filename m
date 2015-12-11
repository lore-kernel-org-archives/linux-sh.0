From: Simon Horman <horms@verge.net.au>
Date: Fri, 11 Dec 2015 01:09:15 +0000
Subject: Re: [PATCH v2 1/2] usb: renesas_usbhs: add fallback compatibility strings
Message-Id: <20151211010911.GC9927@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1449726033-17117-1-git-send-email-horms+renesas@verge.net.au>
 <1449726033-17117-2-git-send-email-horms+renesas@verge.net.au>
 <877fkmbw9p.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <877fkmbw9p.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

On Thu, Dec 10, 2015 at 07:28:06AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> Thank you for your patch
> 
> > Add fallback compatibility strings for R-Car Gen2 and Gen3.
> > This is in keeping with the fallback scheme being adopted wherever
> > appropriate for drivers for Renesas SoCs.
> > 
> > Also add SoC names.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> (snip)
> >  Required properties:
> >    - compatible: Must contain one of the following:
> > -	- "renesas,usbhs-r8a7790"
> > -	- "renesas,usbhs-r8a7791"
> > -	- "renesas,usbhs-r8a7794"
> > -	- "renesas,usbhs-r8a7795"
> > +
> > +	- "renesas,usbhs-r8a7790" for r8a7790 (R-Car H2) compatible device
> > +	- "renesas,usbhs-r8a7791" for r8a7791 (R-Car M2-W) compatible device
> > +	- "renesas,usbhs-r8a7794" for r8a7794 (R-Car E2) compatible device
> > +	- "renesas,usbhs-r8a7795" for r8a7795 (R-Car H3) compatible device
> > +	- "renesas,rcar-gen2-usbhs" for R-Car Gen2 compatibile device
> > +	- "renesas,rcar-gen3-usbhs" for R-Car Gen3 compatibile device
> > +
> > +	When compatible with the generic version, nodes must list the
> > +	SoC-specific version corresponding to the platform first followed
> > +	by the generic version.
> 
> I think these can be separated ?
> 
>  1. document update for "renesas,usbhs-r8a77xx"
>  2. add new "rcar-genX" (this patch)

Sure, will do.

> >  Example:
> >  	usbhs: usb@e6590000 {
> > -		compatible = "renesas,usbhs-r8a7790";
> > +		compatible = "renesas,usbhs-r8a7790", "renesas,rcar-usbhs";
> 
> I think you want
> 
>  -		compatible = "renesas,usbhs-r8a7790", "renesas,rcar-usbhs";
>  +		compatible = "renesas,usbhs-r8a7790", "renesas,rcar-gen2-usbhs";

Thanks, I will fix that.
