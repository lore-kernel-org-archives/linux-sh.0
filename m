From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 07 Feb 2013 01:42:27 +0000
Subject: Re: [PATCH] net: sh_eth: Add support of device tree probe
Message-Id: <87wqukzyps.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1360116019-8870-1-git-send-email-horms+renesas@verge.net.au>
	<87pq0dg7ot.wl%kuninori.morimoto.gx@renesas.com>
	<CABMQnVLr9WqMWC6z3BuYyBvNSXM491VwrZ+DcKd3qGu0UN-G3Q@mail.gmail.com>
In-Reply-To: <CABMQnVLr9WqMWC6z3BuYyBvNSXM491VwrZ+DcKd3qGu0UN-G3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: Simon Horman <horms+renesas@verge.net.au>, netdev@vger.kernel.org, linux-sh@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Magnus Damm <magnus.damm@gmail.com>


Hi Iwamatsu-san

> >> +Required properties:
> >> +- compatible:                   "renesas,sh-eth";
> >> +- interrupt-parent:             The phandle for the interrupt controller that
> >> +                                services interrupts for this device.
> >> +- reg:                          Offset and length of the register set for the
> >> +                                device.
> >> +- interrupts:                   Interrupt mapping for the sh_eth interrupt
> >> +                                sources (vector id).
> >> +- phy-mode:              String, operation mode of the PHY interface.
> >> +- sh-eth,edmac-endian:          String, endian of sh_eth dmac.
> >
> > I believe endian is only little/big.
> > It can be "bool" settings, not "string" ?
> >
> 
> If we use bool , we may use this as "sh-eth,edmac-endian-big" or
> sh-eth,edmac-endian-little.
> Or we define big-endian, and when using big-endian, we specify this.
> Either way is okay.

Sorry, if it means

"we define big-endian as default settings,
and user can select little-endian by using sh-eth,edmac-little-endian"

then, it is nice.
Then, it can be "Option" properties.

> >> +- sh-eth,endian:                String, endian of sh_eth dmac.
> >
> > Is this really used it in this driver ?
> >
> 
> Yes. In many cases, this uses little-endian, but user may specify
> big-endian, I think.

I meant that I could find "sh-eth,edmac-endian" operation,
but, couldn't find "sh-eth,endian" operation on sh_eth_parse_dt()
and on Example either.

Best regards
---
Kuninori Morimoto
