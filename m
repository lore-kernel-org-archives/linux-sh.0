From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 03 Jan 2018 17:09:49 +0000
Subject: [PATCH] sh_eth: fix TSU resource handling
Message-Id: <20180103170955.343662722@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc: linux-sh@vger.kernel.org, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

When switching  the driver to the managed device API,  I managed to break
the  case of a  dual Ether devices sharing a single TSU: the 2nd Ether port
wouldn't probe. Iwamatsu-san has tried to fix this but his patch was buggy
and he then dropped the ball...

The solution is to  limit calling devm_request_mem_region() to the first
of  the two  ports  sharing the same TSU, so devm_ioremap_resource() can't
be used anymore for the TSU resource...

Fixes: d5e07e69218f ("sh_eth: use managed device API")
Reported-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against Dave Miller's 'net.git' repo.

 drivers/net/ethernet/renesas/sh_eth.c |   25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

Index: net/drivers/net/ethernet/renesas/sh_eth.c
=================================--- net.orig/drivers/net/ethernet/renesas/sh_eth.c
+++ net/drivers/net/ethernet/renesas/sh_eth.c
@@ -3225,10 +3225,29 @@ static int sh_eth_drv_probe(struct platf
 	/* ioremap the TSU registers */
 	if (mdp->cd->tsu) {
 		struct resource *rtsu;
+
 		rtsu = platform_get_resource(pdev, IORESOURCE_MEM, 1);
-		mdp->tsu_addr = devm_ioremap_resource(&pdev->dev, rtsu);
-		if (IS_ERR(mdp->tsu_addr)) {
-			ret = PTR_ERR(mdp->tsu_addr);
+		if (!rtsu) {
+			dev_err(&pdev->dev, "no TSU resource\n");
+			ret = -ENODEV;
+			goto out_release;
+		}
+		/* We can only request the  TSU region  for the first port
+		 * of the two  sharing this TSU for the probe to succeed...
+		 */
+		if (devno % 2 = 0 &&
+		    !devm_request_mem_region(&pdev->dev, rtsu->start,
+					     resource_size(rtsu),
+					     dev_name(&pdev->dev))) {
+			dev_err(&pdev->dev, "can't request TSU resource.\n");
+			ret = -EBUSY;
+			goto out_release;
+		}
+		mdp->tsu_addr = devm_ioremap(&pdev->dev, rtsu->start,
+					     resource_size(rtsu));
+		if (!mdp->tsu_addr) {
+			dev_err(&pdev->dev, "TSU region ioremap() failed.\n");
+			ret = -ENOMEM;
 			goto out_release;
 		}
 		mdp->port = devno % 2;

