From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Dec 2015 08:32:49 +0000
Subject: Re: [PATCH 1/2] usb: renesas_usbhs: add fallback compatibility string
Message-Id: <87a8pl5oms.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449553911-21412-1-git-send-email-horms+renesas@verge.net.au>
	<1449553911-21412-2-git-send-email-horms+renesas@verge.net.au>
	<87egex5vfl.wl%kuninori.morimoto.gx@renesas.com>
	<20151208074932.GA5663@verge.net.au>
In-Reply-To: <20151208074932.GA5663@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, linux-usb@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org


Hi Simon

> > > Add fallback compatibility string.
> > > This is in keeping with the fallback scheme being adopted wherever
> > > appropriate for drivers for Renesas SoCs.
> > > 
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > ---
> > (snip)
> > > +	{
> > > +		.compatible = "renesas,usbhs",
> > > +		.data = (void *)USBHS_TYPE_RCAR_GEN2,
> > > +	},
> > >  	{ },
> > >  };
> > 
> > I think this is too much. This driver is used not only from R-Car Gen2.
> > It will work as normal mode if .data was 0.
> > see usbhs_parse_dt()
> 
> Are you suggesting that we remove USBHS_TYPE_RCAR_GEN2 from the driver?

I mean this

+	{
+		.compatible = "renesas,usbhs",
+	},

