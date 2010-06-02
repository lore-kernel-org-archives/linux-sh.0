From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Jun 2010 00:27:31 +0000
Subject: [PATCH 2/4] sh: make sure static declaration on mach-ecovec24
Message-Id: <w3p7hmib7nx.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 778eb7c..be1d114 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -140,7 +140,7 @@ static struct resource sh_eth_resources[] = {
 	},
 };
 
-struct sh_eth_plat_data sh_eth_plat = {
+static struct sh_eth_plat_data sh_eth_plat = {
 	.phy = 0x1f, /* SMSC LAN8700 */
 	.edmac_endian = EDMAC_LITTLE_ENDIAN,
 	.ether_link_active_low = 1
@@ -160,7 +160,7 @@ static struct platform_device sh_eth_device = {
 };
 
 /* USB0 host */
-void usb0_port_power(int port, int power)
+static void usb0_port_power(int port, int power)
 {
 	gpio_set_value(GPIO_PTB4, power);
 }
@@ -196,7 +196,7 @@ static struct platform_device usb0_host_device = {
 };
 
 /* USB1 host/function */
-void usb1_port_power(int port, int power)
+static void usb1_port_power(int port, int power)
 {
 	gpio_set_value(GPIO_PTB5, power);
 }
@@ -422,7 +422,7 @@ static int ts_init(void)
 	return 0;
 }
 
-struct tsc2007_platform_data tsc2007_info = {
+static struct tsc2007_platform_data tsc2007_info = {
 	.model			= 2007,
 	.x_plate_ohms		= 180,
 	.get_pendown_state	= ts_get_pendown_state,
@@ -723,7 +723,7 @@ static struct clk fsimckb_clk = {
 	.rate		= 0, /* unknown */
 };
 
-struct sh_fsi_platform_info fsi_info = {
+static struct sh_fsi_platform_info fsi_info = {
 	.portb_flags = SH_FSI_BRS_INV |
 		       SH_FSI_OUT_SLAVE_MODE |
 		       SH_FSI_IN_SLAVE_MODE |
@@ -780,7 +780,7 @@ static struct platform_device irda_device = {
 #include <media/ak881x.h>
 #include <media/sh_vou.h>
 
-struct ak881x_pdata ak881x_pdata = {
+static struct ak881x_pdata ak881x_pdata = {
 	.flags = AK881X_IF_MODE_SLAVE,
 };
 
@@ -789,7 +789,7 @@ static struct i2c_board_info ak8813 = {
 	.platform_data = &ak881x_pdata,
 };
 
-struct sh_vou_pdata sh_vou_pdata = {
+static struct sh_vou_pdata sh_vou_pdata = {
 	.bus_fmt	= SH_VOU_BUS_8BIT,
 	.flags		= SH_VOU_HSYNC_LOW | SH_VOU_VSYNC_LOW,
 	.board_info	= &ak8813,
@@ -853,7 +853,7 @@ static struct resource sh_mmcif_resources[] = {
 	},
 };
 
-struct sh_mmcif_plat_data sh_mmcif_plat = {
+static struct sh_mmcif_plat_data sh_mmcif_plat = {
 	.set_pwr	= mmcif_set_pwr,
 	.down_pwr	= mmcif_down_pwr,
 	.sup_pclk	= 0, /* SH7724: Max Pclk/2 */
-- 
1.7.0.4

