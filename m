From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Wed, 18 Jun 2014 09:02:45 +0000
Subject: [PROTOTYPE 0/18]: ARM: shmobile: lager: sound support via DT
Message-Id: <87oaxqy4i1.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi all

These patches are still under PROTOTYPE,
because DMA DT is still prototype.
But, these are add sound DMA support via DT.
Please test these patches. some comments are welcome.

These patches are based on Ben's 1st DMA DT support
patch-set. (I konw Ben sent v2 patches, but...)

>> Simon

Almost all are PROTOTYPE, but, #1 #2 are not PROTOTYPE.
Please consider these patches.

You can use these patches by...

  git checkout renesas-devel-v3.16-rc1-20140617
  git merge asoc/fix/rcar
       # asoc : git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git
  git am ${ASOC-PATCHES}
  git am ${AUDMAPP-PATCHES}
  git am ${THESE-PATCHES}

ASOC-PATCHES
      ASoC: rsnd: fixup rsnd_gen_dma_addr() for Gen1
      ASoC: rsnd: fixup loop exit timing of dma name search
      ASoC: rsnd: SSI + DMA can select BUSIF
      ASoC: fsi: use SNDRV_DMA_TYPE_DEV for sound buffer
      ASoC: fsi: add fsi_pointer_update() for common pointer method
      ASoC: fsi: use dmaengine_prep_dma_cyclic() for DMA transfer
      ASoC: rsnd: use dmaengine_prep_dma_cyclic() instead of original method
      ASoC: rsnd: enable DVC when capture
      ASoC: rsnd: enable SRC setting via DT
      ASoC: rsnd: DMA cleanup for flexible SSI/SRC selection
      ASoC: rsnd: DMA start address is properly used for each DMAC
      ASoC: rsnd: add DT support to DVC

AUDMAPP-PATCHES
      dma: rcar-audmapp: enable .set_slave
      dma: audmapp: don't keep audmapp_slave_config for each channeles
      dma: rcar-audmapp: add DT support

THESE-PATCHES
Ben Dooks (7):
      DMA: shdma: initial of common code
      DMA: shdma: wire r8a7790
      ARM: shmobile: r8a7790: add dmac0,dmac1 clocks
      ARM: shmobile: r8a7790: add dmac0 dmac1 nodes
      ARM: shmobile: add Audio DMAC clocks on DTSI
      ARM: shmobile: r8a7790: add audio dmac node
      ARM: shmobile: r8a7790: add dma defines for sys and audio dmacs

Kuninori Morimoto (11):
      Ben's bug fix
      ARM: shmobile: r8a7790: add DVC support on DTSI
      ARM: shmobile: r8a7791: add DVC support on DTSI
      ARM: shmobile: r8a7790: add Audio DMAC entry for sound on DTSI
      ARM: shmobile: r8a7790: add Audio DMAC peri peri support on DTSI
      ARM: shmobile: lager: Sound PIO support on DTS
      ARM: shmobile: lager: Sound DMA support on DTS
      ARM: shmobile: lager: Sound DMA support via BUSIF on DTS
      ARM: shmobile: lager: Sound DMA support via SRC on DTS
      ARM: shmobile: lager: Sound DMA support via DVC on DTS
      ARM: shmobile: multiplatform: add Audo DMAC peri peri support on defconfig

 Documentation/devicetree/bindings/dma/shdma.txt |   23 +-
 arch/arm/boot/dts/r8a7790-lager.dts             |   73 ++++++
 arch/arm/boot/dts/r8a7790.dtsi                  |  297 ++++++++++++++++++++++-
 arch/arm/boot/dts/r8a7791.dtsi                  |    7 +
 arch/arm/configs/shmobile_defconfig             |    1 +
 arch/arm/mach-shmobile/Kconfig                  |    1 +
 drivers/dma/sh/shdma-of.c                       |  175 ++++++++++++-
 drivers/dma/sh/shdma.h                          |   29 +++
 drivers/dma/sh/shdmac.c                         |   32 ++-
 include/dt-bindings/clock/r8a7790-clock.h       |    2 +
 include/dt-bindings/dma/r8a7790-dma.h           |  230 ++++++++++++++++++
 include/dt-bindings/dma/shdma.h                 |   45 ++++
 12 files changed, 900 insertions(+), 15 deletions(-)
