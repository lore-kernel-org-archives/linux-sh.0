From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 20 Jun 2014 10:17:26 +0000
Subject: [PATCH/POC 2/2] ARM: shmobile: koelsch legacy: Enable DMA for MSIOF
Message-Id: <1403259446-13696-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add the register set used by the DMA engine to access the MSIOF registers,
and DMA slave IDs.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/board-koelsch.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index f04fc3745a05..7a824f034113 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -190,12 +190,15 @@ static const struct rspi_plat_data qspi_pdata __initconst = {
 /* MSIOF0 */
 static const struct resource sh_msiof0_resources[] __initconst = {
 	DEFINE_RES_MEM(0xe6e20000, 0x0064),
+	DEFINE_RES_MEM(0xe7e20000, 0x0064),
 	DEFINE_RES_IRQ(gic_spi(156)),
 };
 
-static const struct sh_msiof_spi_info sh_msiof_info __initconst = {
+static const struct sh_msiof_spi_info sh_msiof0_info __initconst = {
 	.rx_fifo_override	= 256,
 	.num_chipselect		= 1,
+	.dma_tx_id		= SYS_DMAC_SLAVE_MSIOF0_TX,
+	.dma_rx_id		= SYS_DMAC_SLAVE_MSIOF0_RX,
 };
 
 /* SPI Flash memory (Spansion S25FL512SAGMFIG11 64 MiB) */
@@ -482,8 +485,8 @@ static void __init koelsch_add_standard_devices(void)
 	platform_device_register_resndata(&platform_bus, "spi_r8a7791_msiof",
 					  1 + 0, sh_msiof0_resources,
 					  ARRAY_SIZE(sh_msiof0_resources),
-					  &sh_msiof_info,
-					  sizeof(struct sh_msiof_spi_info));
+					  &sh_msiof0_info,
+					  sizeof(sh_msiof0_info));
 
 	spi_register_board_info(spi_info, ARRAY_SIZE(spi_info));
 
-- 
1.9.1

