From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 30 Oct 2014 08:25:59 +0000
Subject: [PATCH 0/11] Lager sound support
Message-Id: <87k33ix8tm.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These patches add sound support (= PIO/DMA) for Lager board.
I will send Koelsh board sound support when I can access to it.
These are based on Laurent's R-Car DMA driver patch-set +
renesas-devel-20141030-v3.18-rc2

Kuninori Morimoto (11):
      ARM: shmobile: r8a7790: Add Audio DMAC devices to DT
      ARM: shmobile: r8a7790: Add Audio DMAC peri peri devices to DT
      ARM: shmobile: r8a7790: sound enables Audio DMAC entry on DTSI
      ARM: shmobile: r8a7790: sound enables Audio DMAC peri peri entry on DTSI
      ARM: shmobile: lager: Sound PIO support on DTS
      ARM: shmobile: lager: Sound DMA support on DTS
      ARM: shmobile: lager: Sound DMA support via BUSIF on DTS
      ARM: shmobile: lager: Sound DMA support via SRC on DTS
      ARM: shmobile: lager: Sound DMA support via DVC on DTS
      ARM: shmobile: multiplatform: add Audo DMAC peri peri support on defconfig
      ARM: shmobile: multiplatform: add R-Car DMAC support on defconfig

 arch/arm/boot/dts/r8a7790-lager.dts       |   72 ++++++++++
 arch/arm/boot/dts/r8a7790.dtsi            |  203 ++++++++++++++++++++++++++++-
 arch/arm/configs/shmobile_defconfig       |    2 +
 arch/arm/mach-shmobile/Kconfig            |    1 +
 include/dt-bindings/clock/r8a7790-clock.h |    2 +
 5 files changed, 277 insertions(+), 3 deletions(-)
