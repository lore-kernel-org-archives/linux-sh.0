From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Jun 2010 00:25:03 +0000
Subject: [PATCH 1/3] ARM: mach-shmobile: make sure static declaration on ap4evb
Message-Id: <w3peigqb7s1.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ap4evb.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index bdc4c6b..8f42dbe 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -277,7 +277,7 @@ static struct resource sh_mmcif_resources[] = {
 	},
 };
 
-struct sh_mmcif_plat_data sh_mmcif_plat = {
+static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.sup_pclk	= 0,
 	.ocr		= MMC_VDD_165_195 | MMC_VDD_32_33 | MMC_VDD_33_34,
 	.caps		= MMC_CAP_4_BIT_DATA |
@@ -357,7 +357,7 @@ static struct platform_device sdhi1_device = {
 };
 
 /* USB1 */
-void usb1_host_port_power(int port, int power)
+static void usb1_host_port_power(int port, int power)
 {
 	if (!power) /* only power-on supported for now */
 		return;
@@ -492,7 +492,7 @@ static struct clk fsiackcr_clk = {
 	.rate		= 0, /* unknown */
 };
 
-struct sh_fsi_platform_info fsi_info = {
+static struct sh_fsi_platform_info fsi_info = {
 	.porta_flags = SH_FSI_BRS_INV |
 		       SH_FSI_OUT_SLAVE_MODE |
 		       SH_FSI_IN_SLAVE_MODE |
@@ -538,7 +538,7 @@ static struct platform_device *ap4evb_devices[] __initdata = {
 
 /* TouchScreen (Needs SW3 set to OFF) */
 #define IRQ28	evt2irq(0x3380) /* IRQ28A */
-struct tsc2007_platform_data tsc2007_info = {
+static struct tsc2007_platform_data tsc2007_info = {
 	.model			= 2007,
 	.x_plate_ohms		= 180,
 };
-- 
1.7.0.4

