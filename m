From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 14 Jan 2018 17:47:44 +0000
Subject: [PATCH 2/2] sh_eth: get Ether port # only when needed
Message-Id: <20180114175203.191929089@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

The dual-port Ether configurations always have a shared TSU to e.g. pass
the packets between those  ports.  With the  TSU init. code gathered under
the single *if*, we now can only get the port # from 'platform_device::id'
only when we actually  need it  (and not recalculate it each time)...

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/net/ethernet/renesas/sh_eth.c |   13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

Index: net-next/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net-next.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net-next/drivers/net/ethernet/renesas/sh_eth.c
@@ -3125,7 +3125,7 @@ static int sh_eth_drv_probe(struct platf
 	const struct platform_device_id *id = platform_get_device_id(pdev);
 	struct sh_eth_private *mdp;
 	struct net_device *ndev;
-	int ret, devno;
+	int ret;
 
 	/* get base addr */
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -3137,10 +3137,6 @@ static int sh_eth_drv_probe(struct platf
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
-	devno = pdev->id;
-	if (devno < 0)
-		devno = 0;
-
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
 		goto out_release;
@@ -3223,6 +3219,7 @@ static int sh_eth_drv_probe(struct platf
 	}
 
 	if (mdp->cd->tsu) {
+		int port = pdev->id < 0 ? 0 : pdev->id % 2;
 		struct resource *rtsu;
 
 		rtsu = platform_get_resource(pdev, IORESOURCE_MEM, 1);
@@ -3234,7 +3231,7 @@ static int sh_eth_drv_probe(struct platf
 		/* We can only request the  TSU region  for the first port
 		 * of the two  sharing this TSU for the probe to succeed...
 		 */
-		if (devno % 2 = 0 &&
+		if (port = 0 &&
 		    !devm_request_mem_region(&pdev->dev, rtsu->start,
 					     resource_size(rtsu),
 					     dev_name(&pdev->dev))) {
@@ -3250,11 +3247,11 @@ static int sh_eth_drv_probe(struct platf
 			ret = -ENOMEM;
 			goto out_release;
 		}
-		mdp->port = devno % 2;
+		mdp->port = port;
 		ndev->features = NETIF_F_HW_VLAN_CTAG_FILTER;
 
 		/* Need to init only the first port of the two sharing a TSU */
-		if (devno % 2 = 0) {
+		if (port = 0) {
 			if (mdp->cd->chip_reset)
 				mdp->cd->chip_reset(ndev);
 

