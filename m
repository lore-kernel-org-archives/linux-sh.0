From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 04 Nov 2014 01:43:36 +0000
Subject: [PATCH 00/23 v3] Lager/Koelsch sound support v3
Message-Id: <87zjc791v2.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

These are v3 sound support (= PIO/DMA) patches,
I merged both Lager/Koelsch board support in this patch-set.

These are based on Laurent's R-Car DMA driver patch-set +
renesas-devel-20141030-v3.18-rc2
I added I2C clock frequency fixup patch on 9) and 15)
1) - 8) are r8a7790/r8a7791 patches for DMA.
We can share around this code in the future (?).

Kuninori Morimoto (23):
       1) ARM: shmobile: r8a7790: Add Audio DMAC devices to DT
       2) ARM: shmobile: r8a7791: Add Audio DMAC devices to DT
       3) ARM: shmobile: r8a7790: Add Audio DMAC peri peri devices to DT
       4) ARM: shmobile: r8a7791: Add Audio DMAC peri peri devices to DT
       5) ARM: shmobile: r8a7790: sound enables Audio DMAC entry on DTSI
       6) ARM: shmobile: r8a7791: sound enables Audio DMAC entry on DTSI
       7) ARM: shmobile: r8a7790: sound enables Audio DMAC peri peri entry on DTSI
       8) ARM: shmobile: r8a7791: sound enables Audio DMAC peri peri entry on DTSI
       9) ARM: shmobile: lager: fixup IIC2 clock frequency
      10) ARM: shmobile: lager: Sound PIO support on DTS
      11) ARM: shmobile: lager: Sound DMA support on DTS
      12) ARM: shmobile: lager: Sound DMA support via BUSIF on DTS
      13) ARM: shmobile: lager: Sound DMA support via SRC on DTS
      14) ARM: shmobile: lager: Sound DMA support via DVC on DTS
      15) ARM: shmobile: koelsch: fixup I2C2 clock frequency
      16) ARM: shmobile: koelsch: Sound PIO support on DTS
      17) ARM: shmobile: koelsch: Sound DMA support on DTS
      18) ARM: shmobile: koelsch: Sound DMA support via BUSIF on DTS
      19) ARM: shmobile: koelsch: Sound DMA support via SRC on DTS
      20) ARM: shmobile: koelsch: Sound DMA support via DVC on DTS
      21) ARM: shmobile: multiplatform: add R-Car DMAC support on defconfig
      22) ARM: shmobile: multiplatform: add Audo DMAC peri peri support on defconfig
      23) ARM: shmobile: multiplatform: add AK4642 support on defconfig

 arch/arm/boot/dts/r8a7790-lager.dts       |   74 +++++++++++
 arch/arm/boot/dts/r8a7790.dtsi            |  203 ++++++++++++++++++++++++++++-
 arch/arm/boot/dts/r8a7791-koelsch.dts     |   74 ++++++++++-
 arch/arm/boot/dts/r8a7791.dtsi            |  202 +++++++++++++++++++++++++++-
 arch/arm/configs/shmobile_defconfig       |    3 +
 include/dt-bindings/clock/r8a7790-clock.h |    2 +
 include/dt-bindings/clock/r8a7791-clock.h |    2 +
 7 files changed, 553 insertions(+), 7 deletions(-)
