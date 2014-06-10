From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 10 Jun 2014 23:03:14 +0000
Subject: [PATCH 00/07] ARM: shmobile: Lager/Koelsch MMCIF/SDHI LPAE DMA prototype
Message-Id: <20140610230314.13594.91830.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: Lager/Koelsch MMCIF/SDHI LPAE DMA prototype

[PATCH 01/07] mmc: sdhi: enable .dma_rx_offset for platform prototype
[PATCH 02/07] DMA: shdma: 40-bit address prototype
[PATCH 03/07] ARM: shmobile: Lager SYS-DMAC prototype
[PATCH 04/07] ARM: shmobile: Lager SYS-DMAC and MMCIF prototype
[PATCH 05/07] ARM: shmobile: Lager SYS-DMAC and SDHI prototype
[PATCH 06/07] ARM: shmobile: Koelsch SYS-DMAC prototype
[PATCH 07/07] ARM: shmobile: Koelsch SYS-DMAC and SDHI prototype

These patches add DMAC prototype support for MMCIF and SDHI on Lager
and SDHI on Koelsch. 40-bit physical address support in the DMAC
has been hacked in as a prototype. DMA support for the SDHI
driver has also been modified on a prototype level.

Written to show how to make use of platform devices for DMA support
until the DT bindings for the DMA hardware have been stabilized.

Not for upstream merge.

Depends on the following public SDHI patches by Morimoto-san:
[PATCH] mmc: block: add block number limitation flag for lultiple block read
[PATCH] mmc: sdhi: tidyup mmc_data setting for R-Car SDHI
[PATCH] mmc: tmio: care about DMA tx/rx addr offset

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-v3.15-20140609v3

 arch/arm/mach-shmobile/board-koelsch-reference.c |  154 +++++++++++++++++++++
 arch/arm/mach-shmobile/board-lager-reference.c   |  155 +++++++++++++++++++++-
 drivers/dma/sh/shdma.h                           |    4 
 drivers/dma/sh/shdmac.c                          |   48 +++++-
 drivers/mmc/host/sh_mobile_sdhi.c                |    1 
 include/linux/mmc/sh_mobile_sdhi.h               |    1 
 include/linux/sh_dma.h                           |    2 
 7 files changed, 355 insertions(+), 10 deletions(-)
