From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 07 Oct 2015 10:28:38 +0000
Subject: [PATCH 0/2] pinctrl: sh-pfc: Remove obsolete platform_device_id entries
Message-Id: <1444213720-26770-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Linus, Laurent,

Since the removal of the r8a7778 legacy SoC code in commit
4baadb9e05c68962 ("ARM: shmobile: r8a7778: remove obsolete setup code"),
which is now in arm-soc/for-next, Renesas R-Car Gen1 SoCs are only
supported in generic DT-only ARM multi-platform builds.
The driver doesn't need to match platform devices by name anymore, hence
this series removes the corresponding platform_device_id entries.

Geert Uytterhoeven (2):
  pinctrl: sh-pfc: Remove obsolete r8a7779 platform_device_id entry
  pinctrl: sh-pfc: Remove obsolete r8a7778 platform_device_id entry

 drivers/pinctrl/sh-pfc/core.c | 6 ------
 1 file changed, 6 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
