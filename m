From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 06 Jan 2015 20:01:50 +0000
Subject: [PATCH resend 0/3] ARM: shmobile: dts sound updates
Message-Id: <1420574513-15135-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi Simon, Magnus, Morimoto-san,

This patch series updates/cleans up SoC-specific bindings in dts
files.

It was sent before as part of a larger series, of which the
ASoC-specific parts have been applied by the ASoC maintainer.

Thanks for applying!

Geert Uytterhoeven (3):
  ARM: shmobile: sh73a0 dtsi: Add SoC-specific FSI2 compatible property
  ARM: shmobile: r8a7790 dtsi: Drop "renesas,rcar_sound" compatible
    value
  ARM: shmobile: r8a7791 dtsi: Drop "renesas,rcar_sound" compatible
    value

 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 arch/arm/boot/dts/sh73a0.dtsi  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
