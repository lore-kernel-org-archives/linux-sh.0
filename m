From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 21 Aug 2013 22:17:25 +0000
Subject: [PATCH 1/2] SH7619: fix typo in Ether platform data
Message-Id: <201308220217.26081.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201308220215.16463.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201308220215.16463.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org, davem@davemloft.net

Commit 06a64f91da72cb5827e2bedef2ead60a123fd66e (SH7619: fix Ether support)  has
a typo in the 'phy_interface' field name of the platform data which causes build
error -- fix it. 

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/sh/kernel/cpu/sh2/setup-sh7619.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: net-next/arch/sh/kernel/cpu/sh2/setup-sh7619.c
=================================--- net-next.orig/arch/sh/kernel/cpu/sh2/setup-sh7619.c
+++ net-next/arch/sh/kernel/cpu/sh2/setup-sh7619.c
@@ -114,7 +114,7 @@ static struct platform_device scif2_devi
 static struct sh_eth_plat_data eth_platform_data = {
 	.phy		= 1,
 	.edmac_endian	= EDMAC_LITTLE_ENDIAN,
-	.phy_interace	= PHY_INTERFACE_MODE_MII,
+	.phy_interface	= PHY_INTERFACE_MODE_MII,
 };
 
 static struct resource eth_resources[] = {
