From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 24 Aug 2009 09:14:16 +0000
Subject: Re: Current ms7724se LAN doesn't work
Message-Id: <20090824091416.GB15330@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <uzl9pr5cs.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uzl9pr5cs.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 24, 2009 at 05:19:47PM +0900, Kuninori Morimoto wrote:
> 
> Dear all
> 
> I got latest kernel from Paul's git,
> and current ms7724se LAN doesn't work.
> 
> When If I remove 
> archdata = {
>          .hwblk_id = HWBLK_ETHER,
> }
> from ${LINUX}/arch/sh/boards/mach-se/7724/setup.c
> then, it start works for me.
> 
> Are there any CONFIG to use SH-ETH or HWBLK ?
> 
This would be a runtime PM issue, which SH-Mobile unconditionally
selects. The problem is that the module is most likely disabled via its
MSTP bit under the new scheme, so sh-eth will need to tie in to the
runtime PM framework to get that resolved.

Can you give this a try?

---

 drivers/net/sh_eth.c |   28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index a2d82dd..c195baa 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -30,7 +30,7 @@
 #include <linux/phy.h>
 #include <linux/cache.h>
 #include <linux/io.h>
-
+#include <linux/pm_runtime.h>
 #include "sh_eth.h"
 
 /* There is CPU dependent code */
@@ -1006,6 +1006,8 @@ static int sh_eth_open(struct net_device *ndev)
 	int ret = 0;
 	struct sh_eth_private *mdp = netdev_priv(ndev);
 
+	pm_runtime_get_sync(&ndev->dev);
+
 	ret = request_irq(ndev->irq, &sh_eth_interrupt,
 #if defined(CONFIG_CPU_SUBTYPE_SH7763) || defined(CONFIG_CPU_SUBTYPE_SH7764)
 				IRQF_SHARED,
@@ -1173,6 +1175,8 @@ static int sh_eth_close(struct net_device *ndev)
 	ringsize = sizeof(struct sh_eth_txdesc) * TX_RING_SIZE;
 	dma_free_coherent(NULL, ringsize, mdp->tx_ring, mdp->tx_desc_dma);
 
+	pm_runtime_put_sync(&ndev->dev);
+
 	return 0;
 }
 
@@ -1404,6 +1408,7 @@ static int sh_eth_drv_probe(struct platform_device *pdev)
 
 	mdp = netdev_priv(ndev);
 	spin_lock_init(&mdp->lock);
+	pm_runtime_enable(&pdev->dev);
 
 	pd = (struct sh_eth_plat_data *)(pdev->dev.platform_data);
 	/* get PHY ID */
@@ -1477,18 +1482,37 @@ static int sh_eth_drv_remove(struct platform_device *pdev)
 	sh_mdio_release(ndev);
 	unregister_netdev(ndev);
 	flush_scheduled_work();
-
+	pm_runtime_disable(&pdev->dev);
 	free_netdev(ndev);
 	platform_set_drvdata(pdev, NULL);
 
 	return 0;
 }
 
+static int sh_eth_runtime_nop(struct device *dev)
+{
+	/*
+	 * Runtime PM callback shared between ->runtime_suspend()
+	 * and ->runtime_resume(). Simply returns success.
+	 *
+	 * This driver re-initializes all registers after
+	 * pm_runtime_get_sync() anyway so there is no need
+	 * to save and restore registers here.
+	 */
+	return 0;
+}
+
+static struct dev_pm_ops sh_eth_dev_pm_ops = {
+	.runtime_suspend = sh_eth_runtime_nop,
+	.runtime_resume = sh_eth_runtime_nop,
+};
+
 static struct platform_driver sh_eth_driver = {
 	.probe = sh_eth_drv_probe,
 	.remove = sh_eth_drv_remove,
 	.driver = {
 		   .name = CARDNAME,
+		   .pm = &sh_eth_dev_pm_ops,
 	},
 };
 
