From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 02 Jun 2010 00:27:38 +0000
Subject: [PATCH 4/4] sh: make sure static declaration on ms7724se
Message-Id: <w3p6322b7np.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/sh/boards/mach-se/7724/setup.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sh/boards/mach-se/7724/setup.c b/arch/sh/boards/mach-se/7724/setup.c
index f9b8254..552ebd9 100644
--- a/arch/sh/boards/mach-se/7724/setup.c
+++ b/arch/sh/boards/mach-se/7724/setup.c
@@ -283,7 +283,7 @@ static struct clk fsimcka_clk = {
 };
 
 /* change J20, J21, J22 pin to 1-2 connection to use slave mode */
-struct sh_fsi_platform_info fsi_info = {
+static struct sh_fsi_platform_info fsi_info = {
 	.porta_flags = SH_FSI_BRS_INV |
 		       SH_FSI_OUT_SLAVE_MODE |
 		       SH_FSI_IN_SLAVE_MODE |
@@ -371,7 +371,7 @@ static struct resource sh_eth_resources[] = {
 	},
 };
 
-struct sh_eth_plat_data sh_eth_plat = {
+static struct sh_eth_plat_data sh_eth_plat = {
 	.phy = 0x1f, /* SMSC LAN8187 */
 	.edmac_endian = EDMAC_LITTLE_ENDIAN,
 };
@@ -535,7 +535,7 @@ static struct platform_device irda_device = {
 #include <media/ak881x.h>
 #include <media/sh_vou.h>
 
-struct ak881x_pdata ak881x_pdata = {
+static struct ak881x_pdata ak881x_pdata = {
 	.flags = AK881X_IF_MODE_SLAVE,
 };
 
@@ -545,7 +545,7 @@ static struct i2c_board_info ak8813 = {
 	.platform_data = &ak881x_pdata,
 };
 
-struct sh_vou_pdata sh_vou_pdata = {
+static struct sh_vou_pdata sh_vou_pdata = {
 	.bus_fmt	= SH_VOU_BUS_8BIT,
 	.flags		= SH_VOU_HSYNC_LOW | SH_VOU_VSYNC_LOW,
 	.board_info	= &ak8813,
-- 
1.7.0.4

