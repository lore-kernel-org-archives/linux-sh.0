From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 18 Sep 2015 02:01:46 +0000
Subject: [PATCH 0/18 v3] arm64: renesas: add sound support
Message-Id: <87d1xg1oc7.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These patches add sound support
previous patch-set didn't include SRC/DVC/CTU/MIX, but this time
these are included

Kuninori Morimoto (18):
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

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 125 ++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 401 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/arm64/configs/defconfig                       |  10 +++
 include/dt-bindings/clock/r8a7795-clock.h          |  49 ++++++++++++--
 4 files changed, 577 insertions(+), 8 deletions(-)
