From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 12 Jun 2014 09:42:09 +0000
Subject: [PATCH v2 00/07] ARM: shmobile: Lager/Koelsch MMCIF/SDHI LPAE DMA prototype V2
Message-Id: <20140612094209.4132.78270.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: Lager/Koelsch MMCIF/SDHI LPAE DMA prototype V2

[PATCH v2 01/07] mmc: sdhi: enable .dma_rx_offset for platform prototype
[PATCH v2 02/07] DMA: shdma: 40-bit address prototype
[PATCH v2 03/07] ARM: shmobile: Lager SYS-DMAC prototype
[PATCH v2 04/07] ARM: shmobile: Lager SYS-DMAC and MMCIF prototype
[PATCH v2 05/07] ARM: shmobile: Lager SYS-DMAC and SDHI prototype
[PATCH v2 06/07] ARM: shmobile: Koelsch SYS-DMAC prototype
[PATCH v2 07/07] ARM: shmobile: Koelsch SYS-DMAC and SDHI prototype

These patches add DMAC prototype support for MMCIF and SDHI on Lager
and SDHI on Koelsch. 40-bit physical address support in the DMAC
has been hacked in as a prototype. DMA support for the SDHI
driver has also been modified on a prototype level.

Written to show how to make use of platform devices for DMA support
until the DT bindings for the DMA hardware have been stabilized.

Not for upstream merge.

Changes since V1:
 - Updated patch 02/07 to correctly calculate the transfer length
 - Updated patch 07/07 to allow use together with Audio DMAC

Thanks to Geert for his constructive review and feedback!

Depends on the following public SDHI patches by Morimoto-san:
[PATCH] mmc: block: add block number limitation flag for lultiple block read
[PATCH] mmc: sdhi: tidyup mmc_data setting for R-Car SDHI
[PATCH] mmc: tmio: care about DMA tx/rx addr offset

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-v3.15-20140611

 arch/arm/mach-shmobile/board-koelsch-reference.c |  154 +++++++++++++++++++++
 arch/arm/mach-shmobile/board-lager-reference.c   |  155 +++++++++++++++++++++-
 drivers/dma/sh/shdma.h                           |    4 
 drivers/dma/sh/shdmac.c                          |   46 +++++-
 drivers/mmc/host/sh_mobile_sdhi.c                |    1 
 include/linux/mmc/sh_mobile_sdhi.h               |    1 
 include/linux/sh_dma.h                           |    2 
 7 files changed, 353 insertions(+), 10 deletions(-)
