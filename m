From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 03 Jan 2018 20:08:14 +0000
Subject: [PATCH 1/2] SolutionEngine771x: fix Ether platform data
Message-Id: <20180103201133.743597164@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Cc: netdev@vger.kernel.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

The 'sh_eth' driver's probe() method would fail  on the SolutionEngine7710
board and crash on SolutionEngine7712 board  as the platform code is
hopelessly behind the driver's platform data --  it passes the PHY address
instead of 'struct sh_eth_plat_data *'; pass the latter to the driver in
order to fix the bug...

Fixes: 71557a37adb5 ("[netdrvr] sh_eth: Add SH7619 support")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against Paul Mundt's 'linux-sh.git' repo, 'sh-latest' branch.

 arch/sh/boards/mach-se/770x/setup.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: linux/arch/sh/boards/mach-se/770x/setup.c
=================================--- linux.orig/arch/sh/boards/mach-se/770x/setup.c
+++ linux/arch/sh/boards/mach-se/770x/setup.c
@@ -115,6 +115,11 @@ static struct platform_device heartbeat_
 #if defined(CONFIG_CPU_SUBTYPE_SH7710) ||\
 	defined(CONFIG_CPU_SUBTYPE_SH7712)
 /* SH771X Ethernet driver */
+static struct sh_eth_plat_data sh_eth_plat = {
+	.phy = PHY_ID,
+	.phy_interface = PHY_INTERFACE_MODE_MII,
+};
+
 static struct resource sh_eth0_resources[] = {
 	[0] = {
 		.start = SH_ETH0_BASE,
@@ -132,7 +137,7 @@ static struct platform_device sh_eth0_de
 	.name = "sh771x-ether",
 	.id = 0,
 	.dev = {
-		.platform_data = PHY_ID,
+		.platform_data = &sh_eth_plat,
 	},
 	.num_resources = ARRAY_SIZE(sh_eth0_resources),
 	.resource = sh_eth0_resources,
@@ -155,7 +160,7 @@ static struct platform_device sh_eth1_de
 	.name = "sh771x-ether",
 	.id = 1,
 	.dev = {
-		.platform_data = PHY_ID,
+		.platform_data = &sh_eth_plat,
 	},
 	.num_resources = ARRAY_SIZE(sh_eth1_resources),
 	.resource = sh_eth1_resources,

