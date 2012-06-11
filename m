From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 11 Jun 2012 10:00:19 +0000
Subject: Re: [PATCH 03/27] ARM: shmobile: shareing extra gpio setting functions
Message-Id: <87d356p3rk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ipeyqzdr.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ipeyqzdr.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

Thank you for checking patch

> > diff --git a/arch/arm/mach-shmobile/include/mach/gpio.h b/arch/arm/mach-shmobile/include/mach/gpio.h
> > index de795b4..7c1e4ab 100644
> > --- a/arch/arm/mach-shmobile/include/mach/gpio.h
> > +++ b/arch/arm/mach-shmobile/include/mach/gpio.h
> > @@ -13,6 +13,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/errno.h>
> >  #include <linux/sh_pfc.h>
> > +#include <asm/io.h>
> >  
> >  #ifdef CONFIG_GPIOLIB
> >  
> Minor nit, but please use linux/ headers when they are available.

OK.
I will fix it on v2

Best regards
---
Kuninori Morimoto
