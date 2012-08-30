From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 30 Aug 2012 23:48:43 +0000
Subject: Re: [PATCH 0/8] ARM: shmobile: r8a7779/marzen/kzm9g patches for v3.7
Message-Id: <874nnk7xgu.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87mx1fdbgl.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mx1fdbgl.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

Thank you for checking my patches

> * v3.6-rc3
> * usb-next
> * exynos_v6_thermal_tree
> * My marzen branch
> * Patches 1-7 of this series
> 
> And the R-Car Thermal driver selected in the kernel .config I see the following:
> 
> # make
>   CC      drivers/thermal/rcar_thermal.o
> drivers/thermal/rcar_thermal.c: In function 'rcar_thermal_probe':
> drivers/thermal/rcar_thermal.c:214:10: warning: passing argument 3 of 'thermal_zone_device_register' makes integer from pointer without a cast include/linux/thermal.h:166:29: note: expected 'int' but argument is of type 'struct rcar_thermal_priv *'
> drivers/thermal/rcar_thermal.c:214:10: error: too few arguments to function 'thermal_zone_device_register'
> include/linux/thermal.h:166:29: note: declared here
> make[2]: *** [drivers/thermal/rcar_thermal.o] Error 1
> make[1]: *** [drivers/thermal] Error 2
> make: *** [drivers] Error 2

Someone had sent fixup patch for this issue to ML, but it seems still not applied.


> > 7) adds thermal support for marzen,
> > but it depends on this branch
> >     git://git.linaro.org/people/amitdanielk/linux.git - exynos_v6_thermal_tree
> 
> It seems to be safe enough to apply this patch without exynos_v6_thermal_tree
> present, the R-Car Thermal driver isn't built but both build and boot
> of a defconfig kernel work. Accordingly, my plan is to include this
> patch in the usb-net based pull request described above.
(snip)
> > 8) switch to use gpio-keys instead of gpio-keys-polled,
> > but it depends on this branch
> >     git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git - for-next
> 
> This seems to be a build-time dependency.
> My current plan is to create a kzm9g-gpio tree based
> on linux-gpio/for-next and send a pull request to
> arm-soc.
> 
> > These are based on linus/master + above each branch + "Simon's defconfig patch"
> 
> Thanks for the details, they are very helpful.

Thank you


Best regards
---
Kuninori Morimoto
