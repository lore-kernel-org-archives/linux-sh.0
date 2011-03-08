From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 08 Mar 2011 08:00:04 +0000
Subject: [PATCH] sh: modify platform_device for sh_eth driver
Message-Id: <4D75E204.7000800@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

A new parameter is added to sh_eth_plat_data. And the sh_eth driver
needs additional memory resource if a module has TSU.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 This patch depends on the following patches in netdev ml.
  - net: sh_eth: modify the definitions of register
  - net: sh_eth: remove the SH_TSU_ADDR
  - net: sh_eth: modify the PHY_INTERFACE_MODE

 arch/sh/boards/board-espt.c           |    7 +++++++
 arch/sh/boards/mach-ecovec24/setup.c  |    2 ++
 arch/sh/boards/mach-sh7763rdp/setup.c |    6 ++++++
 3 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/sh/boards/board-espt.c b/arch/sh/boards/board-espt.c
index d5ce5e1..9da92ac 100644
--- a/arch/sh/boards/board-espt.c
+++ b/arch/sh/boards/board-espt.c
@@ -66,6 +66,11 @@ static struct resource sh_eth_resources[] = {
 		.end    = 0xFEE00F7C - 1,
 		.flags  = IORESOURCE_MEM,
 	}, {
+		.start  = 0xFEE01800,   /* TSU */
+		.end    = 0xFEE01FFF,
+		.flags  = IORESOURCE_MEM,
+	}, {
+
 		.start  = 57,   /* irq number */
 		.flags  = IORESOURCE_IRQ,
 	},
@@ -74,6 +79,8 @@ static struct resource sh_eth_resources[] = {
 static struct sh_eth_plat_data sh7763_eth_pdata = {
 	.phy = 0,
 	.edmac_endian = EDMAC_LITTLE_ENDIAN,
+	.register_type = SH_ETH_REG_GIGABIT,
+	.phy_interface = PHY_INTERFACE_MODE_MII,
 };

 static struct platform_device espt_eth_device = {
diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 701667a..3b71d21 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -142,6 +142,8 @@ static struct resource sh_eth_resources[] = {
 static struct sh_eth_plat_data sh_eth_plat = {
 	.phy = 0x1f, /* SMSC LAN8700 */
 	.edmac_endian = EDMAC_LITTLE_ENDIAN,
+	.register_type = SH_ETH_REG_FAST_SH4,
+	.phy_interface = PHY_INTERFACE_MODE_MII,
 	.ether_link_active_low = 1
 };

diff --git a/arch/sh/boards/mach-sh7763rdp/setup.c b/arch/sh/boards/mach-sh7763rdp/setup.c
index f64a691..f3d828f 100644
--- a/arch/sh/boards/mach-sh7763rdp/setup.c
+++ b/arch/sh/boards/mach-sh7763rdp/setup.c
@@ -75,6 +75,10 @@ static struct resource sh_eth_resources[] = {
 		.end    = 0xFEE00F7C - 1,
 		.flags  = IORESOURCE_MEM,
 	}, {
+		.start  = 0xFEE01800,   /* TSU */
+		.end    = 0xFEE01FFF,
+		.flags  = IORESOURCE_MEM,
+	}, {
 		.start  = 57,   /* irq number */
 		.flags  = IORESOURCE_IRQ,
 	},
@@ -83,6 +87,8 @@ static struct resource sh_eth_resources[] = {
 static struct sh_eth_plat_data sh7763_eth_pdata = {
 	.phy = 1,
 	.edmac_endian = EDMAC_LITTLE_ENDIAN,
+	.register_type = SH_ETH_REG_GIGABIT,
+	.phy_interface = PHY_INTERFACE_MODE_MII,
 };

 static struct platform_device sh7763rdp_eth_device = {
-- 
1.7.1
