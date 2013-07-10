From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 10 Jul 2013 00:46:00 +0000
Subject: Re: [PATCH 4/4] ARM: shmobile: bockw: add USB Function support
Message-Id: <877ggzw8ca.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87a9lwth26.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a9lwth26.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi


> > +		.platform_callback = {
> > +			/* .get_id	will be set in register function */
> > +			/* .power_ctrl	will be set in register function */
> > +		},
> 
>     Why have empty initializer?

comment helps code-reader

> > +	#define USB_PHY_SETTING {.port1_func = 1, .ovc_pin[1].active_high = 1,}
> > +	#define PIN_MAP_MUX_GROUP_USB1 \
> > +		PIN_MAP_MUX_GROUP_DEFAULT("renesas_usbhs", "pfc-r8a7778", \
> > +					  "usb1_ovc", "usb1")
> 
>      USB_OVC1 is 3.3V pin and your common PHY settings above don't 
> select it. I don't think you need this group, actually the group should 
> be the same as for the USB host mode.

Indeed
Thank you for pointing it


Best regards
---
Kuninori Morimoto
