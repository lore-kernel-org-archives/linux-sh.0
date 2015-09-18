From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Sep 2015 01:51:41 +0000
Subject: [PATCH 0/25 v3][RFC] arm64: Salvator-X sound support
Message-Id: <87twqs1osz.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are v3 of Salvator-X sound support patches.

These are based on renesas-drivers-2015-09-15-v4.3-rc1
These is including non SH-ARM patches which are
posted to other ML, but still not yet merged.

Kuninori Morimoto (23):
      pinctrl: sh-pfc: r8a7795: add I2C pin support
      pinctrl: sh-pfc: r8a7795: add Audio clock pin support
      pinctrl: sh-pfc: r8a7795: add Audio SSI pin support
      dmaengine: OF DMAEngine API based on CONFIG_DMA_OF instead of CONFIG_OF
      clk: add CS2000 Fractional-N driver
      arm64: renesas: tidyup MSTP9 reverse definition order
      arm64: renesas: r8a7795: add I2C support
      arm64: renesas: r8a7795: add AUDIO_DMAC support
      arm64: renesas: r8a7795: Sound SSI PIO support
      arm64: renesas: r8a7795: Sound SSI DMA support
      arm64: renesas: r8a7795: Sound SRC support
      arm64: renesas: r8a7795: Sound DVC support
      arm64: renesas: r8a7795: Sound CTU/MIX support
      arm64: renesas: salvator-x: enable I2C
      arm64: renesas: salvator-x: Sound SSI PIO support
      arm64: renesas: salvator-x: Sound SSI DMA support
      arm64: renesas: salvator-x: Sound SSI DMA support via BUSIF
      arm64: renesas: salvator-x: Sound SRC support
      arm64: renesas: salvator-x: Sound DVC support
      arm64: defconfig: Enable Renesas R-Car I2C Controller
      arm64: defconfig: add Renesas sound and AK4613 support
      arm64: defconfig: add Renesas R-Car DMAC driver support
      arm64: defconfig: add CS2000 driver support

Wolfram Sang (2):
      i2c: rcar: add support for r8a7795 (R-Car H3)
      i2c: sh_mobile: add support for r8a7795 (R-Car H3)

 Documentation/devicetree/bindings/clock/cs2000-cp.txt   |  24 +++++
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt      |   1 +
 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt |   1 +
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts      | 125 +++++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi                | 401 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/arm64/configs/defconfig                            |  10 ++
 drivers/clk/Kconfig                                     |   6 ++
 drivers/clk/Makefile                                    |   1 +
 drivers/clk/clk-cs2000-cp.c                             | 530 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-rcar.c                           |   3 +
 drivers/i2c/busses/i2c-sh_mobile.c                      |   1 +
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c                    | 468 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h               |  49 ++++++++--
 include/linux/of_dma.h                                  |   2 +-
 14 files changed, 1613 insertions(+), 9 deletions(-)

Best regards
---
Kuninori Morimoto
