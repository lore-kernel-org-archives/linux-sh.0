From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 10 Nov 2014 18:49:33 +0000
Subject: [PATCH v2 0/6] ARM: shmobile: Change to using clock-indices
Message-Id: <1415645379-3366-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Turquette <mturquette@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Mike, Simon, Magnus,

This patch series finalizes the conversion from the vendor-specific
"renesas,clock-indices" to the generic "clock-indices", started by Ben Dooks.

The patches for r8a7790 and r8a7791 were extracted from a patch that Ben sent
before ("[PATCH 2/3] renesas: change to using clock-indices"), but it was never
split/updated.

Changes in v2:
  - Drop the reference to "renesas,clock-indices" completely,
  - Add Acked-by.

Thanks for applying!

Ben Dooks (2):
  ARM: shmobile: r8a7790 dtsi: Change to using clock-indices
  ARM: shmobile: r8a7791 dtsi: Change to using clock-indices

Geert Uytterhoeven (4):
  clk: shmobile: Deprecate renesas,clock-indices
  ARM: shmobile: r8a7740 dtsi: Change to using clock-indices
  ARM: shmobile: r8a7779 dtsi: Change to using clock-indices
  ARM: shmobile: r8a7794 dtsi: Change to using clock-indices

 .../bindings/clock/renesas,cpg-mstp-clocks.txt     |  8 ++++----
 arch/arm/boot/dts/r8a7740.dtsi                     | 10 +++++-----
 arch/arm/boot/dts/r8a7779.dtsi                     |  6 +++---
 arch/arm/boot/dts/r8a7790.dtsi                     | 20 +++++++++++---------
 arch/arm/boot/dts/r8a7791.dtsi                     | 22 ++++++++++++----------
 arch/arm/boot/dts/r8a7794.dtsi                     | 14 +++++++-------
 6 files changed, 42 insertions(+), 38 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
