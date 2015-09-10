From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 10 Sep 2015 07:12:00 +0000
Subject: [PATCH 0/14][RFC] arm64: Salvator-X sound support
Message-Id: <87si6mn452.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon, Wolfram

These are Salvator-X sound support patches.
These are based on renesas-drivers-2015-09-08-v4.2
But, many necessary patches are lacking on it.
So, please don't queue these patches on topic branch,
otherwise it will be compile error

Necessary, but lacking patches
 - OF DMA fixup patch (posted)
 - Renesas sound Gen3 support patches (posting)
 - CS2000 driver (posting)

Thus, These are just information for H3 user at this point.
I will repost these later as formal patches.
Main user is I2C I think >> Wolfram ?
AK4613, and CS2000 driver use I2C

Kuninori Morimoto (14):
      arm64: renesas: tidyup MSTP9 reverse definition order
      arm64: renesas: r8a7795: add I2C support
      arm64: renesas: r8a7795: add MSTP10 support
      arm64: renesas: r8a7795: add SSI sound support
      arm64: renesas: r8a7795: add AUDIO-DMAC support
      arm64: renesas: r8a7795: add SSI DMA support
      arm64: renesas: salvator-x: enable I2C
      arm64: renesas: salvator-x: add PIO sound support
      arm64: renesas: salvator-x: Sound DMA support on DTS
      arm64: renesas: salvator-x: Sound DMA support via BUSIF on DTS
      arm64: defconfig: Enable Renesas R-Car I2C Controller
      arm64: defconfig: add Renesas sound and AK4613 support
      arm64: defconfig: add Renesas R-Car DMAC driver support
      arm64: defconfig: add CS2000 driver support

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  98 +++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 307 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 arch/arm64/configs/defconfig                       |  10 ++++
 include/dt-bindings/clock/r8a7795-clock.h          |  49 +++++++++++++++---
 4 files changed, 456 insertions(+), 8 deletions(-)

Best regards
---
Kuninori Morimoto
