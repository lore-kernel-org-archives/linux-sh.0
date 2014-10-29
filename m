From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 29 Oct 2014 14:09:36 +0000
Subject: [PATCH 0/3] ARM: shmobile: Remove unnecessary MMC options
Message-Id: <1414591779-22954-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Simon, Magnus,

This patch series, sent before by Morimoto-san, removes unnecessary MMC options
from the DTS files that are already set automatically by the driver, based on
the compatible property value. Note that these options were never added on
r8a7791, which gained SDHI device nodes later than the three affected SoCs.

Thanks for applying!

Kuninori Morimoto (3):
  ARM: shmobile: r8a7778 dtsi: Remove unnecessary MMC options
  ARM: shmobile: r8a7779 dtsi: Remove unnecessary MMC options
  ARM: shmobile: r8a7790 dtsi: Remove unnecessary MMC options

 arch/arm/boot/dts/r8a7778.dtsi | 6 ------
 arch/arm/boot/dts/r8a7779.dtsi | 8 --------
 arch/arm/boot/dts/r8a7790.dtsi | 4 ----
 3 files changed, 18 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
