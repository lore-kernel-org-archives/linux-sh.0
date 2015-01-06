From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 06 Jan 2015 19:42:03 +0000
Subject: [PATCH 0/6] ARM: shmobile: kzm9g-reference: Add missing i2c devices
Message-Id: <1420573329-12762-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

	Hi Simon, Magnus,

This patch series adds i2c devices that are supported by kzm9g-legacy
but missing on kzm9g-reference (and -multiplatform).

The first patch ("ARM: shmobile: sh73a0 dtsi: Set control-parent for
all irqpin nodes") is a prerequisite to avoid causing an interrupt
storm when accessing the adxl345 accelerometer through
/dev/input/event1, which requires a power-cycle to recover from.

Parts of this series and of the individual patches were written by
Laurent Pinchart.

Thanks for applying!

Geert Uytterhoeven (4):
  ARM: shmobile: kzm9g-reference dts: Sort i2c0 children by unit address
  ARM: shmobile: kzm9g-reference dts: Add ak8975 magnetometer node
  ARM: shmobile: kzm9g-reference dts: Add adxl345 accelerometer node
  ARM: shmobile: kzm9g-reference dts: Add r2025sd rtc node

Laurent Pinchart (2):
  ARM: shmobile: sh73a0 dtsi: Set control-parent for all irqpin nodes
  ARM: shmobile: kzm9g-reference dts: Add st1232 touchscreen node

 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 40 +++++++++++++++++++++++++---
 arch/arm/boot/dts/sh73a0.dtsi                |  3 +++
 2 files changed, 39 insertions(+), 4 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
