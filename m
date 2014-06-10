From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 10 Jun 2014 23:51:29 +0000
Subject: [PATCH v2] ARM: shmobile: Koelsch SYS-DMAC and SDHI prototype V2
Message-Id: <20140610235129.16048.68945.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Hook up SYS-DMAC prototype support for SDHI on Koelsch.

Local platform device version of SYS-DMAC and local slave IDs
are used together with AUXDATA. CD and WP pins, regulators
and clocks are provided via DT.

Only the DT reference case is covered. Not for upstream merge.

Updates patch 7 of the following series:
[PATCH 00/07] ARM: shmobile: Lager/Koelsch MMCIF/SDHI LPAE DMA prototype

Changes since V1:
- Initialize SYS_DMAC_SLAVE_SDHI0_TX to 64 to coexist with other DMACs.
  This is done to split the slave ID space and allow other DMACs to
  use the initial portion of the slave ID space. Without this fix other
  DMACs like for instance sound prototype support will not work with
  this prototype patch series and SDHI will be broken.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/board-koelsch-reference.c |   61 +++++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

--- 0010/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ work/arch/arm/mach-shmobile/board-koelsch-reference.c	2014-06-11 08:38:38.000000000 +0900
@@ -68,10 +68,19 @@ static const struct resource du_resource
 
 #include <linux/sh_dma.h>
 #include <mach/dma-register.h>
+#include <linux/mmc/host.h>
+#include <linux/mfd/tmio.h>
+#include <linux/mmc/sh_mobile_sdhi.h>
 
 /* Local DMA slave IDs */
 enum {
 	RCAR_DMA_SLAVE_KOELSCH_INVALID = 0,
+	SYS_DMAC_SLAVE_SDHI0_TX = 64,
+	SYS_DMAC_SLAVE_SDHI0_RX,
+	SYS_DMAC_SLAVE_SDHI1_TX,
+	SYS_DMAC_SLAVE_SDHI1_RX,
+	SYS_DMAC_SLAVE_SDHI2_TX,
+	SYS_DMAC_SLAVE_SDHI2_RX,
 };
 
 #define DMAE_CHANNEL(a, b)			\
@@ -97,6 +106,9 @@ enum {
 }
 
 static const struct sh_dmae_slave_config r8a7791_sys_dmac_slaves[] = {
+	SYS_DMAC_SLAVE(SDHI0, 16, 0xee100000, 0x60, 0x2060, 0xcd, 0xce),
+	SYS_DMAC_SLAVE(SDHI1, 16, 0xee140000, 0x30, 0x2030, 0xc1, 0xc2),
+	SYS_DMAC_SLAVE(SDHI2, 16, 0xee160000, 0x30, 0x2030, 0xd3, 0xd4),
 };
 
 static const struct sh_dmae_channel r8a7791_sys_dmac_channels[] = {
@@ -158,6 +170,52 @@ static void __init koelsch_add_dmac_prot
 	r8a7791_register_sys_dmac(0);
 }
 
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
+static struct sh_mobile_sdhi_info sdhi1_info __initdata = {
+	.dma_slave_tx   = SYS_DMAC_SLAVE_SDHI1_TX,
+	.dma_slave_rx   = SYS_DMAC_SLAVE_SDHI1_RX,
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
+static struct of_dev_auxdata koelsch_auxdata_lookup[] __initdata = {
+	OF_DEV_AUXDATA("renesas,sdhi-r8a7791", 0xee100000, "sdhi0",
+			&sdhi0_info),
+	OF_DEV_AUXDATA("renesas,sdhi-r8a7791", 0xee140000, "sdhi1",
+			&sdhi1_info),
+	OF_DEV_AUXDATA("renesas,sdhi-r8a7791", 0xee160000, "sdhi2",
+			&sdhi2_info),
+	{},
+};
+
 static void __init koelsch_add_du_device(void)
 {
 	struct platform_device_info info = {
@@ -189,7 +247,8 @@ static void __init koelsch_add_standard_
 	shmobile_clk_workaround(clk_names, ARRAY_SIZE(clk_names), false);
 	r8a7791_add_dt_devices();
 	koelsch_add_dmac_prototype();
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table,
+			     koelsch_auxdata_lookup, NULL);
 
 	koelsch_add_du_device();
 }
