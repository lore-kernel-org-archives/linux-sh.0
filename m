From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 25 Jun 2014 00:40:27 +0000
Subject: [PATCH 00/05] ARM: shmobile: Lager/Koelsch SCIF/MSIOF DMA prototype
Message-Id: <20140625004027.18295.39707.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

ARM: shmobile: Lager/Koelsch SCIF/MSIOF DMA prototype

[PATCH 01/05] serial: sh-sci: Allow AUXDATA DMAC parameters 
[PATCH 02/05] ARM: shmobile: Lager SYS-DMAC and SCIF prototype
[PATCH 03/05] ARM: shmobile: Lager SYS-DMAC and MSIOF prototype
[PATCH 04/05] ARM: shmobile: Koelsch SYS-DMAC and SCIF prototype
[PATCH 05/05] ARM: shmobile: Koelsch SYS-DMAC and MSIOF prototype

These patches add DMAC prototype support for SCIF and MSIOF on Lager
and SDHI on Koelsch. It is built on top of an earlier series that
added MMCIF/SDHI DMAC prototype support together with 40-bit physical
address support in the DMAC controller.

To use DMA with the SCIF driver the following kconfig bits are needed:
CONFIG_SERIAL_SH_SCI_DMA=y

DMA support in the SCIF driver is in pretty poor state. To be able to
pass platform data DMA parameters the driver needs slight adjustment,
moreover, at this point only TX DMA is enabled due to RX driver issues.

Regarding MSIOF, additional dependencies are needed for DMA support
(see below) but once that is applied enabling MSIOF DMA is simple.
As for testing, there is no driver support for the chip connected to
the MSIOF port on lager and koelsch, so this is untested by me apart
from the boot message:
# dmesg | grep -i msiof                                                         
<6>spi_sh_msiof spi_r8a7791_msiof.0: DMA available

Written to show how to make use of platform devices for DMA support
until the DT bindings for the DMA hardware have been stabilized.

Not for upstream merge.

Thanks to Geert for his MSIOF work together with review and feedback!

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

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-v3.16-rc2-20140623 + above + header clash fixes

 arch/arm/boot/dts/r8a7790.dtsi                   |    8 -
 arch/arm/boot/dts/r8a7791.dtsi                   |    6 
 arch/arm/mach-shmobile/board-koelsch-reference.c |  143 ++++++++++++++++++++++
 arch/arm/mach-shmobile/board-lager-reference.c   |  105 ++++++++++++++++
 drivers/tty/serial/sh-sci.c                      |    8 -
 5 files changed, 261 insertions(+), 9 deletions(-)
