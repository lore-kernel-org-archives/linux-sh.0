From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 30 Jul 2014 22:27:05 +0000
Subject: [PATCH 00/02] ARM: shmobile: Lager/Koelsch SCIF DMA RX prototype
Message-Id: <20140730222705.4799.45483.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: Lager/Koelsch SCIF DMA RX prototype

[PATCH 01/02] ARM: shmobile: Lager SYS-DMAC and SCIF RX prototype
[PATCH 02/02] ARM: shmobile: Koelsch SYS-DMAC and SCIF RX prototype

These patches add DMAC prototype support for the RX side of SCIF
serial ports on Lager and Koelsch. It is built on top of several
earlier series that added MMCIF/SDHI DMAC prototype support together
with 40-bit physical address support in the DMAC controller and
additional SCIF and MSIOF DMA integration patches.

To use DMA with the SCIF driver the following kconfig bits are needed:
CONFIG_SERIAL_SH_SCI_DMA=y

DMA support in the SCIF driver is in pretty poor state. With these
patches applied DMA Engine support for both RX and TX are enabled,
however the SCIF driver is known to not work well with RX.

Written to show how to make use of platform devices for DMA support
until the DT bindings for the DMA hardware have been stabilized.

Not for upstream merge.

Depends on the following patches:
[PATCH] mmc: block: add block number limitation flag for lultiple block read
[PATCH] mmc: sdhi: tidyup mmc_data setting for R-Car SDHI
[PATCH] mmc: tmio: care about DMA tx/rx addr offset
[PATCH v2 00/07] ARM: shmobile: Lager/Koelsch MMCIF/SDHI LPAE DMA prototype V2
[PATCH v2 01/07] mmc: sdhi: enable .dma_rx_offset for platform prototype
[PATCH v2 02/07] DMA: shdma: 40-bit address prototype
[PATCH v2 03/07] ARM: shmobile: Lager SYS-DMAC prototype
[PATCH v2 04/07] ARM: shmobile: Lager SYS-DMAC and MMCIF prototype
[PATCH v2 05/07] ARM: shmobile: Lager SYS-DMAC and SDHI prototype
[PATCH v2 06/07] ARM: shmobile: Koelsch SYS-DMAC prototype
[PATCH v2 07/07] ARM: shmobile: Koelsch SYS-DMAC and SDHI prototype
[PATCH 0/5] spi: sh-msiof: Add DMA support
[PATCH 1/5] spi: sh-msiof: Add more register documentation
[PATCH 2/5] spi: sh-msiof: Extract sh_msiof_spi_{start,stop}() helpers
[PATCH 3/5] spi: sh-msiof: Improve transfer error handling
[PATCH 4/5] spi: sh-msiof: Refactor sh_msiof_transfer_one()
[PATCH 5/5] spi: sh-msiof: Add DMA support
[PATCH 00/05] ARM: shmobile: Lager/Koelsch SCIF/MSIOF DMA prototype
[PATCH 01/05] serial: sh-sci: Allow AUXDATA DMAC parameters 
[PATCH 02/05] ARM: shmobile: Lager SYS-DMAC and SCIF prototype
[PATCH 03/05] ARM: shmobile: Lager SYS-DMAC and MSIOF prototype
[PATCH 04/05] ARM: shmobile: Koelsch SYS-DMAC and SCIF prototype
[PATCH 05/05] ARM: shmobile: Koelsch SYS-DMAC and MSIOF prototype

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-v3.16-rc7-20140729 + above + collision fixes

 arch/arm/mach-shmobile/board-koelsch-reference.c |   44 +++++++++-------------
 arch/arm/mach-shmobile/board-lager-reference.c   |   28 +++++---------
 2 files changed, 28 insertions(+), 44 deletions(-)
