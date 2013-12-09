From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 09 Dec 2013 22:20:50 +0000
Subject: [PATCH] micrel: add support for KSZ8041RNLI
Message-Id: <201312100220.42153.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org

Renesas R-Car development boards use KSZ8041RNLI PHY which for some reason has
ID of 0x00221537 that is not documented for KSZ8041-family PHYs and does not
match the  documented ID of  0x0022151x (where 'x' is the revision).  We have
to add the new #define PHY_ID_* and new ksphy_driver[] entry, almost the same
as KSZ8041 one, differing only in the 'phy_id' and 'name' fields. 

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is atop of DaveM's 'net-next.git' repo.

 drivers/net/phy/micrel.c   |   15 +++++++++++++++
 include/linux/micrel_phy.h |    2 ++
 2 files changed, 17 insertions(+)

Index: net-next/drivers/net/phy/micrel.c
=================================--- net-next.orig/drivers/net/phy/micrel.c
+++ net-next/drivers/net/phy/micrel.c
@@ -336,6 +336,21 @@ static struct phy_driver ksphy_driver[] 
 	.resume		= genphy_resume,
 	.driver		= { .owner = THIS_MODULE,},
 }, {
+	.phy_id		= PHY_ID_KSZ8041RNLI,
+	.phy_id_mask	= 0x00fffff0,
+	.name		= "Micrel KSZ8041RNLI",
+	.features	= PHY_BASIC_FEATURES |
+			  SUPPORTED_Pause | SUPPORTED_Asym_Pause,
+	.flags		= PHY_HAS_MAGICANEG | PHY_HAS_INTERRUPT,
+	.config_init	= kszphy_config_init,
+	.config_aneg	= genphy_config_aneg,
+	.read_status	= genphy_read_status,
+	.ack_interrupt	= kszphy_ack_interrupt,
+	.config_intr	= kszphy_config_intr,
+	.suspend	= genphy_suspend,
+	.resume		= genphy_resume,
+	.driver		= { .owner = THIS_MODULE,},
+}, {
 	.phy_id		= PHY_ID_KSZ8051,
 	.phy_id_mask	= 0x00fffff0,
 	.name		= "Micrel KSZ8051",
Index: net-next/include/linux/micrel_phy.h
=================================--- net-next.orig/include/linux/micrel_phy.h
+++ net-next/include/linux/micrel_phy.h
@@ -22,6 +22,8 @@
 #define PHY_ID_KSZ8021		0x00221555
 #define PHY_ID_KSZ8031		0x00221556
 #define PHY_ID_KSZ8041		0x00221510
+/* undocumented */
+#define PHY_ID_KSZ8041RNLI	0x00221537
 #define PHY_ID_KSZ8051		0x00221550
 /* same id: ks8001 Rev. A/B, and ks8721 Rev 3. */
 #define PHY_ID_KSZ8001		0x0022161A
