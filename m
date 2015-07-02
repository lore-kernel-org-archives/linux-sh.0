From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 02 Jul 2015 05:12:15 +0000
Subject: [PATCH 0/4 v2][RFC] arm64: Renesas Gen3 initial patch
Message-Id: <878uazm9gu.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi SH-ML

This patch-set should be Cc:ed to ARM-ML, but I didn't at this point.

These are v2 patch set for Gen3 support. These were tested on our emulator,
and these are pick-uped SoC related parts from it.
Basically, these are created by Inami-san, and I tidyuped.

v2 patch set is assuming that bootloader has disabled CPG write protection
for CPG/MSTP/APMU register. Thus, this patch set doesn't care about it.
It should be cared via Linux kernel in the future.

Gaku Inami (3):
      clk: shmobile: add Renesas R-Car Gen3 CPG support
      arm64: Add new Renesas R-Car Gen3 SoC Kconfig
      arm64: renesas: Add initial r8a7795 SoC support

Kuninori Morimoto (1):
      arm64: defconfig: Enable Renesas R-Car Gen3 SoC in defconfig

 Documentation/devicetree/bindings/arm/shmobile.txt                       |   2 +
 Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt |  31 ++++++++++++
 arch/arm64/Kconfig                                                       |   9 ++++
 arch/arm64/boot/dts/Makefile                                             |   1 +
 arch/arm64/boot/dts/renesas/Makefile                                     |   5 ++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi                                 |  93 +++++++++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig                                             |   4 ++
 drivers/clk/shmobile/Makefile                                            |   1 +
 drivers/clk/shmobile/clk-rcar-gen3.c                                     | 232 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h                                |  31 ++++++++++++
 10 files changed, 409 insertions(+)

--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
