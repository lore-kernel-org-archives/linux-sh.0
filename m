From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Jun 2015 04:49:45 +0000
Subject: [PATCH 0/6][RFC] arm64: Renesas Gen3 initial patch
Message-Id: <87616pwp7a.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi SH-ML

I guess I need to Cc ARM-ML, but I didn't at this point.

These are initial patch set for Gen3 support. These were tested on our emulator,
not real board. And these are pick-uped SoC related parts from it.
Basically, these are created by Inami-san, and I tidyuped these.
Very limited people only can access to this emulator, and it takes very long
time to get output. Inami-san is using it, but I couldn't.

Inami-san (and I) have emulator parts (and hacks) patch as platform,
but I don't post it.

My concern about these patches are about clocks. CPG/MSTP/APMU need
write protection on Gen3, but these need to share same protection.
Current version is using new global rcar_cpgwpcr_lock(),
but we should to create new driver ? Then DT is ?

I know we need to more discuss / brushup for these Gen3.
But, I believe this patch-set can be good start point for Gen3 !


Gaku Inami (3):
      clk: shmobile: add Renesas R-Car Gen3 CPG support
      arm64: Add new Renesas R-Car Gen3 SoC Kconfig
      arm64: renesas: Add r8a7795 SoC support

Kuninori Morimoto (3):
      clk: shmobile: add CPG common lock support for Gen3
      clk: shmobile: CPG write protect register support for MSTP
      arm64: defconfig: Enable Renesas R-Car Gen3 SoC in defconfig

 Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt |   3 ++
 arch/arm64/Kconfig                                                  |  13 +++++
 arch/arm64/boot/dts/Makefile                                        |   1 +
 arch/arm64/boot/dts/renesas/Makefile                                |   5 ++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi                            |  90 ++++++++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig                                        |   3 ++
 drivers/clk/shmobile/Makefile                                       |   2 +
 drivers/clk/shmobile/clk-mstp.c                                     |  16 +++++-
 drivers/clk/shmobile/clk-rcar-gen3.c                                | 243 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/shmobile/rcar-clk.c                                     |  30 ++++++++++++
 drivers/clk/shmobile/rcar-clk.h                                     |  21 ++++++++
 include/dt-bindings/clock/r8a7795-clock.h                           |  31 ++++++++++++
 12 files changed, 457 insertions(+), 1 deletion(-)
