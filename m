From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 22 Apr 2013 00:48:30 +0000
Subject: Re: [PATCH 3/6] ARM: shmobile: r8a7778: Register SDHI device
Message-Id: <87ppxn1jcb.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87bo9denxa.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bo9denxa.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Sergei

> >   extern void r8a7778_add_standard_devices(void);
> > @@ -29,5 +30,6 @@ extern void r8a7778_init_irq_dt(void);
> >   extern void r8a7778_clock_init(void);
> >   extern void r8a7778_init_irq_extpin(int irlm);
> >   extern void r8a7778_pinmux_init(void);
> > +extern void r8a7778_sdhi_init(int id, struct sh_mobile_sdhi_info *info);
> 
>     You should have called the function r8a7778_add_sdhi_device() to be in
> the same vein with already added registration functions. I'll prepare a
> renaming patch if you don't beat me to it.

Indeed...
Thank you for your help !
Please rename it.

Best regards
---
Kuninori Morimoto
