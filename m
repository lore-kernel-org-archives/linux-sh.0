From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 12 Jun 2014 09:42:48 +0000
Subject: [PATCH v2 05/07] ARM: shmobile: Lager SYS-DMAC and SDHI prototype
Message-Id: <20140612094248.4132.48805.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Hook up SYS-DMAC prototype support for SDHI on Lager.

Local platform device version of SYS-DMAC and local slave IDs
are used together with AUXDATA. CD and WP pins, regulators
and clocks are provided via DT.

Only the DT reference case is covered. Not for upstream merge.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - None

 arch/arm/mach-shmobile/board-lager-reference.c |   36 ++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

--- 0006/arch/arm/mach-shmobile/board-lager-reference.c
+++ work/arch/arm/mach-shmobile/board-lager-reference.c	2014-06-10 22:00:10.000000000 +0900
@@ -74,6 +74,8 @@ static const struct resource du_resource
 #include <mach/dma-register.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mmcif.h>
+#include <linux/mfd/tmio.h>
+#include <linux/mmc/sh_mobile_sdhi.h>
 
 /* Local DMA slave IDs */
 enum {
@@ -82,6 +84,10 @@ enum {
 	SYS_DMAC_SLAVE_MMCIF0_RX,
 	SYS_DMAC_SLAVE_MMCIF1_TX,
 	SYS_DMAC_SLAVE_MMCIF1_RX,
+	SYS_DMAC_SLAVE_SDHI0_TX,
+	SYS_DMAC_SLAVE_SDHI0_RX,
+	SYS_DMAC_SLAVE_SDHI2_TX,
+	SYS_DMAC_SLAVE_SDHI2_RX,
 };
 
 #define DMAE_CHANNEL(a, b)			\
@@ -109,6 +115,8 @@ enum {
 static const struct sh_dmae_slave_config r8a7790_sys_dmac_slaves[] = {
 	SYS_DMAC_SLAVE(MMCIF0, 32, 0xee200000, 0x34, 0x34, 0xd1, 0xd2),
 	SYS_DMAC_SLAVE(MMCIF1, 32, 0xee220000, 0x34, 0x34, 0xe1, 0xe2),
+	SYS_DMAC_SLAVE(SDHI0, 16, 0xee100000, 0x60, 0x2060, 0xcd, 0xce),
+	SYS_DMAC_SLAVE(SDHI2, 16, 0xee140000, 0x30, 0x2030, 0xc1, 0xc2),
 };
 
 static const struct sh_dmae_channel r8a7790_sys_dmac_channels[] = {
@@ -178,9 +186,37 @@ static struct sh_mmcif_plat_data mmcif1_
 	.slave_id_rx	= SYS_DMAC_SLAVE_MMCIF1_RX,
 };
 
+static struct sh_mobile_sdhi_info sdhi0_info __initdata = {
+	.dma_slave_tx   = SYS_DMAC_SLAVE_SDHI0_TX,
+	.dma_slave_rx   = SYS_DMAC_SLAVE_SDHI0_RX,
+	.dma_rx_offset  = 0x2000,
+
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
+			  MMC_CAP_POWER_OFF_CARD,
+	.tmio_caps2	= MMC_CAP2_NO_MULTI_READ,
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT |
+			  TMIO_MMC_WRPROTECT_DISABLE,
+};
+
+static struct sh_mobile_sdhi_info sdhi2_info __initdata = {
+	.dma_slave_tx   = SYS_DMAC_SLAVE_SDHI2_TX,
+	.dma_slave_rx   = SYS_DMAC_SLAVE_SDHI2_RX,
+	.dma_rx_offset  = 0x2000,
+
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
+			  MMC_CAP_POWER_OFF_CARD,
+	.tmio_caps2	= MMC_CAP2_NO_MULTI_READ,
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT |
+			  TMIO_MMC_WRPROTECT_DISABLE,
+};
+
 static struct of_dev_auxdata lager_auxdata_lookup[] __initdata = {
 	OF_DEV_AUXDATA("renesas,mmcif-r8a7790", 0xee220000, "sh_mmcif",
 			&mmcif1_pdata),
+	OF_DEV_AUXDATA("renesas,sdhi-r8a7790", 0xee100000, "sdhi0",
+			&sdhi0_info),
+	OF_DEV_AUXDATA("renesas,sdhi-r8a7790", 0xee140000, "sdhi2",
+			&sdhi2_info),
 	{},
 };
 
