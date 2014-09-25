From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 25 Sep 2014 16:13:16 +0000
Subject: [PATCH 00/13] ARM: shmobile: dts: Add chosen/stdout-path
Message-Id: <1411661609-4280-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

	Hi Simon, Magnus,

This patch series adds chosen/stdout-path to the various shmobile DTS files
that are used for reference or multi-platform builds.

This serves two purposes:
  1. It makes automatic console selection work in the absence of a "console="
     parameter on the kernel command line, allowing to remove "console="
     parameters from chosen/bootargs on many platforms.
     Note that these "console=" parameters are still needed in some cases:
       a. If console output is wanted on two consoles devices (graphical and
          serial consoles), like on armadillo and kzm9g,
       b. When using a non-default baud for the serial console, like on
          henninger and alt,
  2. It will allow the PM domain code to find the PM domain for the console
     device, to make "no_console_suspend" work in the DT case.
     For now, this will matter on armadillo.

The first two patches are small cleanups for emev2 dtsi, on top of which the
change for kzm9d is built.

Thanks!

Geert Uytterhoeven (13):
  ARM: shmobile: emev2 dtsi: Use generic names for device nodes
  ARM: shmobile: emev2 dtsi: Add uart* labels for easier referencing
  ARM: shmobile: kzm9d dts: Add chosen/stdout-path
  ARM: shmobile: genmai dts: Add chosen/stdout-path
  ARM: shmobile: ape6evm-reference dts: Add chosen/stdout-path
  ARM: shmobile: armadillo800eva dts: Add chosen/stdout-path
  ARM: shmobile: bockw-reference dts: Add chosen/stdout-path
  ARM: shmobile: marzen dts: Add chosen/stdout-path
  ARM: shmobile: lager dts: Add chosen/stdout-path
  ARM: shmobile: henninger dts: Add chosen/stdout-path
  ARM: shmobile: koelsch dts: Add chosen/stdout-path
  ARM: shmobile: alt dts: Add chosen/stdout-path
  ARM: shmobile: kzm9g-reference dts: Add chosen/stdout-path

 arch/arm/boot/dts/emev2-kzm9d.dts               |  3 ++-
 arch/arm/boot/dts/emev2.dtsi                    | 12 ++++++------
 arch/arm/boot/dts/r7s72100-genmai.dts           |  3 ++-
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts |  3 ++-
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts   |  1 +
 arch/arm/boot/dts/r8a7778-bockw-reference.dts   |  3 ++-
 arch/arm/boot/dts/r8a7779-marzen.dts            |  3 ++-
 arch/arm/boot/dts/r8a7790-lager.dts             |  3 ++-
 arch/arm/boot/dts/r8a7791-henninger.dts         |  1 +
 arch/arm/boot/dts/r8a7791-koelsch.dts           |  3 ++-
 arch/arm/boot/dts/r8a7794-alt.dts               |  1 +
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts    |  1 +
 12 files changed, 24 insertions(+), 13 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
