From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 10 Jul 2013 01:27:18 +0000
Subject: Re: [PATCH 1/4] ARM: shmobile: r8a7778: add usb phy power control function
Message-Id: <871u77w6fg.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehb8th3c.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehb8th3c.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

> > diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
> > index 2a101eb..cd98079 100644
> > --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> > +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> > @@ -109,29 +109,44 @@ void __init r8a7778_add_usb_phy_device(struct rcar_phy_platform_data *pdata)
> >   					  pdata, sizeof(*pdata));
> >   }
> >
> > -/* USB */
> 
>     Why move this comment?

Current setup-r8a7778.c already has /* USB PHY */ above here

> > -static struct usb_phy *phy;
> > -
> > -static int usb_power_on(struct platform_device *pdev)
> > +static int r8a7778_usb_phy_power(int enable)
> 
>     Why not 'bool enable'?

will fix in v2


Best regards
---
Kuninori Morimoto
