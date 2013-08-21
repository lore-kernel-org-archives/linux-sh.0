From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 21 Aug 2013 22:18:30 +0000
Subject: [PATCH 2/2] SolutionEngine7724: fix typo in Ether platform data
Message-Id: <201308220218.31183.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201308220215.16463.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201308220215.16463.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org, davem@davemloft.net

Commit bd61224b1cbec096694e89c4187119c8576fe186 (SolutionEngine7724: fix Ether
support) has a typo in the 'phy_interface' field name of the platform data which
causes build error -- fix it. 

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/sh/boards/mach-se/7724/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: net-next/arch/sh/boards/mach-se/7724/setup.c
=================================--- net-next.orig/arch/sh/boards/mach-se/7724/setup.c
+++ net-next/arch/sh/boards/mach-se/7724/setup.c
@@ -377,7 +377,7 @@ static struct resource sh_eth_resources[
 static struct sh_eth_plat_data sh_eth_plat = {
 	.phy = 0x1f, /* SMSC LAN8187 */
 	.edmac_endian = EDMAC_LITTLE_ENDIAN,
-	.phy_interace = PHY_INTERFACE_MODE_MII,
+	.phy_interface = PHY_INTERFACE_MODE_MII,
 };
 
 static struct platform_device sh_eth_device = {
