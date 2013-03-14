From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 14 Mar 2013 01:09:55 +0000
Subject: Re: [PATCH 2/7] ARM: shmobile: marzen: add USB EHCI driver support
Message-Id: <87fvzy4win.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1352446306-19945-1-git-send-email-horms@verge.net.au>
 <1352446306-19945-3-git-send-email-horms@verge.net.au>
 <5140F35F.3090702@cogentembedded.com>
 <87li9q4ydj.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87li9q4ydj.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Sergei

> >     Morimoto-san, I don't understand why this SoC specific platform device
> > ended up in the board file? Could you explain your reasons please?
> >     I think this is generally a bad practice as this approach scales badly.
> 
> Do you mean it should exist in setup-r8a7779.c ?
> 
> I forgot detail of it, but these usb is using callback function,
> and it is using *phy*.
> This phy came from marzen_init_late() with usb_get_phy(USB_PHY_TYPE_USB2);
> This usb_get_phy() is not needed if board doesn't have USB.
> 
> You can modify it if you want

And, as you pointed in USB ML,
This rcar_usb_phy driver will need board specific initialization.
(it is not implemented at this point...)


Best regards
---
Kuninori Morimoto
