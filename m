From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 07 Oct 2015 08:23:42 +0000
Subject: [PATCH 0/3] gpio: rcar: Remove obsolete platform data support
Message-Id: <1444206225-25664-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Greg, Linus, Alexandre,

Since commit 4baadb9e05c68962 ("ARM: shmobile: r8a7778: remove obsolete
setup code"), which is now in arm-soc/for-next, Renesas R-Car SoCs are
only supported in generic DT-only ARM multi-platform builds.  The driver
doesn't need to use platform data anymore, hence this driver removes
platform data configuration.

Unfortunately the platform data header file is used in a few other
places, so we have to fix these first to avoid breaking the build.

Thanks!

Geert Uytterhoeven (3):
  usb: renesas_usbhs: Remove unneeded #include
    <linux/platform_data/gpio-rcar.h>
  pinctrl: sh-pfc: Stop including <linux/platform_data/gpio-rcar.h>
  gpio: rcar: Remove obsolete platform data support

 drivers/gpio/gpio-rcar.c                | 77 +++++++++++----------------------
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c    |  1 -
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c    |  1 -
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c    |  1 -
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c    |  1 -
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c    |  1 -
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c    |  1 -
 drivers/pinctrl/sh-pfc/sh_pfc.h         |  5 +++
 drivers/usb/renesas_usbhs/rcar2.c       |  1 -
 include/linux/platform_data/gpio-rcar.h | 29 -------------
 10 files changed, 31 insertions(+), 87 deletions(-)
 delete mode 100644 include/linux/platform_data/gpio-rcar.h

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
