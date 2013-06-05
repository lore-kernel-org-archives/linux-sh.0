From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 05 Jun 2013 21:20:53 +0000
Subject: [PATCH v4 8/8] sh_eth: enclose PM code into #ifdef CONFIG_PM
Message-Id: <201306060120.53740.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201306060106.51082.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201306060106.51082.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: nobuhiro.iwamatsu.yj@renesas.com, linux-sh@vger.kernel.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Put '#ifdef CONFIG_PM' around sh_eth_runtime_nop() and 'sh_eth_dev_pm_ops'.
Add '#define SH_ETH_PM_OPS' to facilitate initialization of driver's 'pm' field
depending on whether CONFIG_PM is enabled. 

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
[Sergei: added the changelog, reworded the subject, changing the prefix.]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 4:
- refreshed the patch;
- added the changelog;
- reworded the subject, changing the prefix.

Changes in version 3:
- fixed "ERROR: Macros with complex values should be enclosed in parenthesis" by
  scripts/checkpatch.pl.

 drivers/net/ethernet/renesas/sh_eth.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -2675,6 +2675,7 @@ static int sh_eth_drv_remove(struct plat
 	return 0;
 }
 
+#ifdef CONFIG_PM
 static int sh_eth_runtime_nop(struct device *dev)
 {
 	/*
@@ -2688,17 +2689,21 @@ static int sh_eth_runtime_nop(struct dev
 	return 0;
 }
 
-static struct dev_pm_ops sh_eth_dev_pm_ops = {
+static const struct dev_pm_ops sh_eth_dev_pm_ops = {
 	.runtime_suspend = sh_eth_runtime_nop,
 	.runtime_resume = sh_eth_runtime_nop,
 };
+#define SH_ETH_PM_OPS (&sh_eth_dev_pm_ops)
+#else
+#define SH_ETH_PM_OPS NULL
+#endif
 
 static struct platform_driver sh_eth_driver = {
 	.probe = sh_eth_drv_probe,
 	.remove = sh_eth_drv_remove,
 	.driver = {
 		   .name = CARDNAME,
-		   .pm = &sh_eth_dev_pm_ops,
+		   .pm = SH_ETH_PM_OPS,
 	},
 };
 
