From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 17 Sep 2015 04:19:09 +0000
Subject: [PATCH 0/20 v2][RFC] arm64: Salvator-X sound support
Message-Id: <87vbb97kci.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are v2 of Salvator-X sound support patches.

These are based on renesas-drivers-2015-09-15-v4.3-rc1
and my previous PFC patch-set
      pinctrl: sh-pfc: r8a7795: add I2C pin support
      pinctrl: sh-pfc: r8a7795: add Audio clock pin support
      pinctrl: sh-pfc: r8a7795: add Audio SSI pin support

These is including non SH-ARM patches which are
posted to other ML, but still not yet merged.

1):	posted to ML, not yet merged
2):	posted to ML, not yet merged
3):	posted to ML, not yet merged
4):	not yet posted, since 3) is not merged yet

 5) - 14): for Salvator-X
15) - 17): for Salvator-X
18):       based on 2)

19) 20): posted by Wolfram

Kuninori Morimoto (18):
       1) dmaengine: OF DMAEngine API based on CONFIG_DMA_OF instead of CONFIG_OF
       2) clk: add CS2000 Fractional-N driver
       3) ASoC: add ak4613 support
       4) ASoC: ak4613: add Digital Playback Volume support
       5) arm64: renesas: tidyup MSTP9 reverse definition order
       6) arm64: renesas: r8a7795: add I2C support
       7) arm64: renesas: r8a7795: add PIO sound support
       8) arm64: renesas: r8a7795: add Renesas sound SRC support
       9) arm64: renesas: add AUDIO_DMAC support
      10) arm64: renesas: r8a7795: add SSI DMA support
      11) arm64: renesas: salvator-x: enable I2C
      12) arm64: renesas: salvator-x: add PIO sound support
      13) arm64: renesas: salvator-x: Sound DMA support on DTS
      14) arm64: renesas: salvator-x: Sound DMA support via BUSIF on DTS
      15) arm64: defconfig: Enable Renesas R-Car I2C Controller
      16) arm64: defconfig: add Renesas sound and AK4613 support
      17) arm64: defconfig: add Renesas R-Car DMAC driver support
      18) arm64: defconfig: add CS2000 driver support

Wolfram Sang (2):
      19) i2c: rcar: add support for r8a7795 (R-Car H3)
      20) i2c: sh_mobile: add support for r8a7795 (R-Car H3)

 Documentation/devicetree/bindings/clock/cs2000-cp.txt   |  24 +++++
 Documentation/devicetree/bindings/i2c/i2c-rcar.txt      |   1 +
 Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt |   1 +
 Documentation/devicetree/bindings/sound/ak4613.txt      |  17 ++++
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts      | 102 ++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi                | 306 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/arm64/configs/defconfig                            |  10 ++
 drivers/clk/Kconfig                                     |   6 ++
 drivers/clk/Makefile                                    |   1 +
 drivers/clk/clk-cs2000-cp.c                             | 530 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-rcar.c                           |   3 +
 drivers/i2c/busses/i2c-sh_mobile.c                      |   1 +
 include/dt-bindings/clock/r8a7795-clock.h               |  49 ++++++++--
 include/linux/of_dma.h                                  |   2 +-
 sound/soc/codecs/Kconfig                                |   5 +
 sound/soc/codecs/Makefile                               |   2 +
 sound/soc/codecs/ak4613.c                               | 497 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 17 files changed, 1548 insertions(+), 9 deletions(-)


Best regards
---
Kuninori Morimoto
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
