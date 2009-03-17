From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Tue, 17 Mar 2009 05:50:57 +0000
Subject: [PATCH] sh_eth: Change handling of IRQ
Message-Id: <49BF3A41.6040309@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: Linux-sh <linux-sh@vger.kernel.org>, Paul Mundt <lethal@linux-sh.org>

Handling of IRQ of the SH7763/SH7764 CPU which sh_eth supported was
changed.
This revises it for this change.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 drivers/net/sh_eth.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/net/sh_eth.c b/drivers/net/sh_eth.c
index 7f8e514..7b18827 100644
--- a/drivers/net/sh_eth.c
+++ b/drivers/net/sh_eth.c
@@ -687,6 +687,7 @@ static irqreturn_t sh_eth_interrupt(int irq, void *netdev)
 {
 	struct net_device *ndev = netdev;
 	struct sh_eth_private *mdp = netdev_priv(ndev);
+	irqreturn_t ret = IRQ_NONE;
 	u32 ioaddr, boguscnt = RX_RING_SIZE;
 	u32 intr_status = 0;

@@ -696,7 +697,13 @@ static irqreturn_t sh_eth_interrupt(int irq, void *netdev)
 	/* Get interrpt stat */
 	intr_status = ctrl_inl(ioaddr + EESR);
 	/* Clear interrupt */
-	ctrl_outl(intr_status, ioaddr + EESR);
+	if (intr_status & (EESR_FRC | EESR_RMAF | EESR_RRF |
+			EESR_RTLF | EESR_RTSF | EESR_PRE | EESR_CERF |
+			TX_CHECK | EESR_ERR_CHECK)) {
+		ctrl_outl(intr_status, ioaddr + EESR);
+		ret = IRQ_HANDLED;
+	} else
+		goto other_irq;

 	if (intr_status & (EESR_FRC | /* Frame recv*/
 			EESR_RMAF | /* Multi cast address recv*/
@@ -723,9 +730,10 @@ static irqreturn_t sh_eth_interrupt(int irq, void *netdev)
 		       ndev->name, intr_status);
 	}

+other_irq:
 	spin_unlock(&mdp->lock);

-	return IRQ_HANDLED;
+	return ret;
 }

 static void sh_eth_timer(unsigned long data)
@@ -844,7 +852,13 @@ static int sh_eth_open(struct net_device *ndev)
 	int ret = 0;
 	struct sh_eth_private *mdp = netdev_priv(ndev);

-	ret = request_irq(ndev->irq, &sh_eth_interrupt, 0, ndev->name, ndev);
+	ret = request_irq(ndev->irq, &sh_eth_interrupt,
+#if defined(CONFIG_CPU_SUBTYPE_SH7763) || defined(CONFIG_CPU_SUBTYPE_SH7764)
+				IRQF_SHARED,
+#else
+				0,
+#endif
+				ndev->name, ndev);
 	if (ret) {
 		printk(KERN_ERR "Can not assign IRQ number to %s\n", CARDNAME);
 		return ret;
-- 
1.6.2

