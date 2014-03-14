From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Fri, 14 Mar 2014 19:00:05 +0000
Subject: [PATCH] sh_eth: ensure pm_runtime cannot suspend the device during init
Message-Id: <1394823605-31883-1-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It seems the pm_rumtime work queue is causing the device to be suspended
during initialisation, thus the initialisation may not be able to access
registers properly. Use pm_runtime_get_sync() and pm_runtime_put_sync()
to ensure that the pm system does not suspend it during the probe() call.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/net/ethernet/renesas/sh_eth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 4f76b5e..88aac2c 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -2870,6 +2870,7 @@ static int sh_eth_drv_probe(struct platform_device *pdev)
 	mdp->pdev = pdev;
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_resume(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
 
 	if (pdev->dev.of_node)
 		pd = sh_eth_parse_dt(&pdev->dev);
@@ -2961,6 +2962,7 @@ static int sh_eth_drv_probe(struct platform_device *pdev)
 	pr_info("Base address at 0x%x, %pM, IRQ %d.\n",
 		(u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
 
+	pm_runtime_put_sync(&pdev->dev);
 	platform_set_drvdata(pdev, ndev);
 
 	return ret;
-- 
1.9.0

