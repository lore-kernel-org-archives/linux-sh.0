From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 10 Nov 2014 19:00:39 +0000
Subject: [PATCH 0/5] ARM: shmobile: Sound binding updates
Message-Id: <1415646044-4168-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Mark, Liam, Simon, Magnus, Morimoto-san,

THis patch series add SoC-specific binding to the shmobile sound bindings,
and updates/cleans up the affected dtsi files.

Patches 1 and 3 are meant for the ASoC tree.
Patches 2, 4, 5 and are meant for the shmobile tree.

Thanks!

Geert Uytterhoeven (5):
  ASoC: sh: fsi: Document SoC-specific bindings
  ARM: shmobile: sh73a0 dtsi: Add SoC-specific FSI2 compatible property
  ASoC: rsnd: Document SoC-specific bindings
  ARM: shmobile: r8a7790 dtsi: Drop "renesas,rcar_sound" compatible
    value
  ARM: shmobile: r8a7791 dtsi: Drop "renesas,rcar_sound" compatible
    value

 Documentation/devicetree/bindings/sound/renesas,fsi.txt  |  9 +++++++--
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 10 +++++++---
 arch/arm/boot/dts/r8a7790.dtsi                           |  2 +-
 arch/arm/boot/dts/r8a7791.dtsi                           |  2 +-
 arch/arm/boot/dts/sh73a0.dtsi                            |  2 +-
 5 files changed, 17 insertions(+), 8 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
