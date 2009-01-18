From: Roel Kluin <roel.kluin@gmail.com>
Date: Sun, 18 Jan 2009 20:29:24 +0000
Subject: [PATCH] make boguscnt signed and less bogus.
Message-Id: <49739124.8050105@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

below in this function is:

if (--boguscnt < 0) {
	printk(KERN_WARNING
		"%s: Too much work at interrupt, status=0x%4.4x.\n",
		ndev->name, intr_status);
}


I am not sure it's sane like this, but at least it appears less insane.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index 7f8e514..3b9c20a 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -687,7 +687,8 @@ static irqreturn_t sh_eth_interrupt(int irq, void *netdev)
 {
 	struct net_device *ndev = netdev;
 	struct sh_eth_private *mdp = netdev_priv(ndev);
-	u32 ioaddr, boguscnt = RX_RING_SIZE;
+	u32 ioaddr;
+	int boguscnt = RX_RING_SIZE;
 	u32 intr_status = 0;
 
 	ioaddr = ndev->base_addr;
