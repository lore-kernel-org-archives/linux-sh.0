From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 14 Jul 2015 11:56:51 +0000
Subject: [PATCH v2 0/4] pinctrl: sh-pfc: sh73a0/r8a7740 legacy is gone
Message-Id: <1436875015-13706-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Linus,

In -next, legacy support for the Renesas SH-Mobile AG5 (sh73a0) and
R-Mobile A1 (r8a7740) SoCs has been removed, and these SoCs are now only
supported in generic ARM multi-platform builds.

Hence this patch series, which is the remaining part of series "[PATCH
00/15] ARM: shmobile: Remove legacy sh73a0/kzm9g and r8a7740/armadillo"
(http://www.spinics.net/lists/arm-kernel/msg425987.html) removes
multi-platform checks and platform_device_id entries that are no longer
needed.

Changes in v2:
  - Add Laurent's Acked-by.

Thanks for applying!

Geert Uytterhoeven (4):
  pinctrl: sh-pfc: sh73a0: Remove obsolete multi-platform check
  pinctrl: sh-pfc: Remove obsolete sh73a0 platform_device_id entry
  pinctrl: sh-pfc: r8a7740: Remove obsolete multi-platform check
  pinctrl: sh-pfc: Remove obsolete r8a7740 platform_device_id entry

 drivers/pinctrl/sh-pfc/core.c        | 6 ------
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 4 ----
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  | 4 ----
 3 files changed, 14 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
