From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 27 Aug 2015 09:24:04 +0000
Subject: [PATCH/RFC 04/10] ravb: Add support for r8a7795 SoC
Message-Id: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
[horms: updated changelog]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../devicetree/bindings/net/renesas,ravb.txt       |  6 ++-
 drivers/net/ethernet/renesas/ravb.h                |  1 +
 drivers/net/ethernet/renesas/ravb_main.c           | 47 +++++++++++++++++++---
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/renesas,ravb.txt b/Documentation/devicetree/bindings/net/renesas,ravb.txt
index 1fd8831437bf..0b4ec02c35a4 100644
--- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
+++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
@@ -6,8 +6,12 @@ interface contains.
 Required properties:
 - compatible: "renesas,etheravb-r8a7790" if the device is a part of R8A7790 SoC.
 	      "renesas,etheravb-r8a7794" if the device is a part of R8A7794 SoC.
+	      "renesas,etheravb-r8a7795" if the device is a part of R8A7795 SoC.
 - reg: offset and length of (1) the register block and (2) the stream buffer.
-- interrupts: interrupt specifier for the sole interrupt.
+- interrupts: if the device is a part of R8A7790/R8A7794 SoC
+              interrupt specifier for the sole interrupt.
+              if the device is a part of R8A7795 SoC
+              interrupt specifier for the two interrupts.
 - phy-mode: see ethernet.txt file in the same directory.
 - phy-handle: see ethernet.txt file in the same directory.
 - #address-cells: number of address cells for the MDIO bus, must be equal to 1.
diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
index a157aaaaff6a..1832737063f3 100644
--- a/drivers/net/ethernet/renesas/ravb.h
+++ b/drivers/net/ethernet/renesas/ravb.h
@@ -809,6 +809,7 @@ struct ravb_private {
 
 	unsigned no_avb_link:1;
 	unsigned avb_link_active_low:1;
+	int emac_irq;
 };
 
 static inline u32 ravb_read(struct net_device *ndev, enum ravb_reg reg)
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index 026d98435d87..bf604a869458 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1185,16 +1185,36 @@ static const struct ethtool_ops ravb_ethtool_ops = {
 static int ravb_open(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct platform_device *pdev = priv->pdev;
+	struct device *dev = &pdev->dev;
 	int error;
 
 	napi_enable(&priv->napi[RAVB_BE]);
 	napi_enable(&priv->napi[RAVB_NC]);
 
-	error = request_irq(ndev->irq, ravb_interrupt, IRQF_SHARED, ndev->name,
-			    ndev);
-	if (error) {
-		netdev_err(ndev, "cannot request IRQ\n");
-		goto out_napi_off;
+	if (of_device_is_compatible(dev->of_node,
+				"renesas,etheravb-r8a7795")) {
+		error = request_irq(ndev->irq,
+				ravb_interrupt, IRQF_SHARED, ndev->name, ndev);
+		if (error) {
+			netdev_err(ndev, "cannot request IRQ\n");
+			goto out_napi_off;
+		}
+		error = request_irq(priv->emac_irq,
+				ravb_interrupt,	IRQF_SHARED, ndev->name, ndev);
+		if (error) {
+			netdev_err(ndev, "cannot request IRQ\n");
+			free_irq(ndev->irq, ndev);
+			goto out_napi_off;
+		}
+	}
+	else {
+		error = request_irq(ndev->irq, ravb_interrupt, IRQF_SHARED,
+				ndev->name, ndev);
+		if (error) {
+			netdev_err(ndev, "cannot request IRQ\n");
+			goto out_napi_off;
+		}
 	}
 
 	/* Device init */
@@ -1219,7 +1239,11 @@ out_ptp_stop:
 	/* Stop PTP Clock driver */
 	ravb_ptp_stop(ndev);
 out_free_irq:
-	free_irq(ndev->irq, ndev);
+	if (of_device_is_compatible(dev->of_node,
+				"renesas,etheravb-r8a7795"))
+		free_irq(priv->emac_irq, ndev);
+	else
+		free_irq(ndev->irq, ndev);
 out_napi_off:
 	napi_disable(&priv->napi[RAVB_NC]);
 	napi_disable(&priv->napi[RAVB_BE]);
@@ -1688,6 +1712,16 @@ static int ravb_probe(struct platform_device *pdev)
 	priv->avb_link_active_low  		of_property_read_bool(np, "renesas,ether-link-active-low");
 
+	if (of_device_is_compatible(np,
+				"renesas,etheravb-r8a7795")) {
+		irq = platform_get_irq(pdev, 1);
+		if (irq < 0) {
+			error = -ENODEV;
+			goto out_release;
+		}
+		priv->emac_irq = irq;
+	}
+
 	/* Set function */
 	ndev->netdev_ops = &ravb_netdev_ops;
 	ndev->ethtool_ops = &ravb_ethtool_ops;
@@ -1821,6 +1855,7 @@ static const struct dev_pm_ops ravb_dev_pm_ops = {
 static const struct of_device_id ravb_match_table[] = {
 	{ .compatible = "renesas,etheravb-r8a7790" },
 	{ .compatible = "renesas,etheravb-r8a7794" },
+	{ .compatible = "renesas,etheravb-r8a7795" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ravb_match_table);
-- 
2.1.4

