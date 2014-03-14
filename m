From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 14 Mar 2014 23:27:59 +0000
Subject: [PATCH 1/3] sh_eth: convert pr_*() to netdev_*() calls
Message-Id: <201403150327.55110.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201403150321.47674.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201403150321.47674.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-sh@vger.kernel.org, joe@perches.com

Convert pr_*() to netdev_*() calls as the latter provide info on a device.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/net/ethernet/renesas/sh_eth.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -400,7 +400,8 @@ static void sh_eth_select_mii(struct net
 		value = 0x0;
 		break;
 	default:
-		pr_warn("PHY interface mode was not setup. Set to MII.\n");
+		netdev_warn(ndev,
+			    "PHY interface mode was not setup. Set to MII.\n");
 		value = 0x1;
 		break;
 	}
@@ -854,7 +855,7 @@ static int sh_eth_check_reset(struct net
 		cnt--;
 	}
 	if (cnt <= 0) {
-		pr_err("Device reset failed\n");
+		netdev_err(ndev, "Device reset failed\n");
 		ret = -ETIMEDOUT;
 	}
 	return ret;
@@ -2924,8 +2925,8 @@ static int sh_eth_drv_probe(struct platf
 	}
 
 	/* print device information */
-	pr_info("Base address at 0x%x, %pM, IRQ %d.\n",
-		(u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
+	netdev_info(ndev, "Base address at 0x%x, %pM, IRQ %d.\n",
+		    (u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
 
 	platform_set_drvdata(pdev, ndev);
 
