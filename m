From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 31 Oct 2014 08:00:31 +0000
Subject: [PATCH 0/12] Koelsch sound support
Message-Id: <871tpo3bz4.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These patches add sound support (= PIO/DMA) for Koelsch board.
These are based on Laurent's R-Car DMA driver patch-set +
renesas-devel-20141030-v3.18-rc2

Kuninori Morimoto (12):
      ARM: shmobile: r8a7790: Remove unneeded prefix for sound
      ARM: shmobile: r8a7791: Remove unneeded prefix for sound
      ARM: shmobile: r8a7791: Add Audio DMAC devices to DT
      ARM: shmobile: r8a7791: Add Audio DMAC peri peri devices to DT
      ARM: shmobile: r8a7791: sound enables Audio DMAC entry on DTSI
      ARM: shmobile: r8a7791: sound enables Audio DMAC peri peri entry on DTSI
      ARM: shmobile: koelsch: fixup overkill I2C2 clock frequency
      ARM: shmobile: koelsch: Sound PIO support on DTS
      ARM: shmobile: koelsch: Sound DMA support on DTS
      ARM: shmobile: koelsch: Sound DMA support via BUSIF on DTS
      ARM: shmobile: koelsch: Sound DMA support via SRC on DTS
      ARM: shmobile: koelsch: Sound DMA support via DVC on DTS

 arch/arm/boot/dts/r8a7790.dtsi            |    2 +-
 arch/arm/boot/dts/r8a7791-koelsch.dts     |   73 ++++++++++-
 arch/arm/boot/dts/r8a7791.dtsi            |  204 ++++++++++++++++++++++++++++-
 include/dt-bindings/clock/r8a7791-clock.h |    2 +
 4 files changed, 275 insertions(+), 6 deletions(-)
