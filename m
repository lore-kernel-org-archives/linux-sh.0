From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 16 Apr 2012 05:27:54 +0000
Subject: Re: [PATCH 0/7 v2] ARM: mach-shmobile: add Armadillo800eva board support
Message-Id: <87ty0k5jqh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> It seems to me that its more likely that my build is broken
> than my board. Would it be possible for you to test the image
> at the following link on your board?
>
> http://horms.org/tmp/zImage-g9adc328
>
> md5sum: 6d747f8f4f44a20bdde31a324f844c0b
>
> It is an image of 3.4-rc2 + the following patches + an initrd with
> tmenu included. The config is available in /proc/config.gz
>
> 9adc328 ASoC: fsi: update for dmaengine prep_slave_sg fallout.
> 8d6c869 ARM: mach-shmobile: armadillo800eva: add support sh_eth
> 8afd7b1 ARM: mach-shmobile: armadillo800eva: add support gpio_key
> 5f0c97e ARM: mach-shmobile: armadillo800eva: add support ST1232
> 9699241 ARM: mach-shmobile: armadillo800eva: add support LCDC0
> 5cb5735 ARM: mach-shmobile: armadillo800eva: add defconfig
> 092928a ARM: mach-shmobile: add armadillo800eva board support.
> c8ad89c ARM: mach-shmobile: pfc-r8a7740: add gpio_irq support

I tested your zImage, and touch-screen works well :)
your board seems broken.

# tmenu /dev/input/event0
----------------
Event: type 3 (EV_ABS), code 48 (ABS_MT_TOUCH_MAJOR), value 76
Event: type 3 (EV_ABS), code 53 (ABS_MT_POSITION_X), value 467
Event: type 3 (EV_ABS), code 54 (ABS_MT_POSITION_Y), value 230
Event: type 0 (EV_SYN), code 2 (EV_REL), value 0
Event: type 0 (EV_SYN), code 0 (EV_SYN), value 0
...


Best regards
---
Kuninori Morimoto
