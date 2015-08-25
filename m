From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 25 Aug 2015 09:15:06 +0000
Subject: Re: [PATCH] gpio: rcar: Enable r8a7795 for ARM64
Message-Id: <87zj1f68cp.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8737z77ok8.wl%kuninori.morimoto.gx@renesas.com>
	<CAMuHMdVGZyM7b3ONvrVF6-excdV094miUt97rSp-AVigH_CFoA@mail.gmail.com>
In-Reply-To: <CAMuHMdVGZyM7b3ONvrVF6-excdV094miUt97rSp-AVigH_CFoA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon <horms@verge.net.au>, Linus Walleij <linus.walleij@linaro.org>, Magnus <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>


Hi Geert

> >  config GPIO_RCAR
> >         tristate "Renesas R-Car GPIO"
> > -       depends on ARM && (ARCH_SHMOBILE || COMPILE_TEST)
> > +       depends on (ARM || ARM64) && (ARCH_SHMOBILE || COMPILE_TEST)
> 
> As this driver seems to compile fine on non-ARM, what about relaxing the
> dependency to
> 
>     depends on ARCH_SHMOBILE || COMPILE_TEST

I posted updated one, thanks

