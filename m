From: Simon Horman <horms@verge.net.au>
Date: Fri, 28 Aug 2015 08:27:06 +0000
Subject: Re: [PATCH/RFC 04/10] ravb: Add support for r8a7795 SoC
Message-Id: <20150828082638.GA3407@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 28, 2015 at 10:42:37AM +0900, Simon Horman wrote:
> On Thu, Aug 27, 2015 at 01:01:50PM +0200, Geert Uytterhoeven wrote:
> > On Thu, Aug 27, 2015 at 11:24 AM, Simon Horman
> > <horms+renesas@verge.net.au> wrote:
> > > --- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
> > > +++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
> > > @@ -6,8 +6,12 @@ interface contains.
> > >  Required properties:
> > >  - compatible: "renesas,etheravb-r8a7790" if the device is a part of R8A7790 SoC.
> > >               "renesas,etheravb-r8a7794" if the device is a part of R8A7794 SoC.
> > > +             "renesas,etheravb-r8a7795" if the device is a part of R8A7795 SoC.
> > >  - reg: offset and length of (1) the register block and (2) the stream buffer.
> > > -- interrupts: interrupt specifier for the sole interrupt.
> > > +- interrupts: if the device is a part of R8A7790/R8A7794 SoC
> > > +              interrupt specifier for the sole interrupt.
> > > +              if the device is a part of R8A7795 SoC
> > > +              interrupt specifier for the two interrupts.
> > 
> > If there are multiple interrupts, you best make them named interrupts,
> > i.e. requiring "interrupt-names", too.
> 
> Thanks, I will look into that.
> 
> > Why are there only 2 interrupts? The datasheet mentions 25, for ch0-ch24.
> 
> Thanks for bringing that up. I think it has also come up elsewhere in this
> thread. I'd like to focus on addressing it here rather than spreading the
> discussion around any further.
> 
> My understanding is that on the R-Car Gen3 r8a7795 SoC
> the EthernetAVB hardware may function in one of two modes.
> 
> 1. A mode which is "mostly" compatible with R-Car Gen2
>    (e.g. r8a7790, r8a7790).
> 
>    In this mode only ch22 and ch24 are used.
> 
>    I note that the emac interrupt also appears to be documented for Gen-2.
>    Its not clear to me at this time why it isn't appropriate to use it
>    on those SoCs.

I have confirmed with that the emac interrupt shouldn't be used
on Gen2 SoCs.

> 
> 2. A mode which is new in Gen 3.
> 
>    In this mode ch0 - ch24 are used.
>    I believe that in this mode there are per DMA queue interrupts.


With regards to named interrupts, and indeed most of the other feedback I
have received for this patch, how about the following?

I also confirmed with Mizuguchi-san that it is intentional that the same
handler is used for both interrupts.


From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Subject: [PATCH/RFC v1.1] ravb: Add support for r8a7795 SoC

This patch supports the r8a7795 SoC by:
- Adding a compat string for the new hardware
- Support named-interrupts
- Support the E-DMAC interrupt on the new hardware.
  Although also present on Gen2 SoCs my understanding is
  that it can't be used on those SoCs.

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
[horms: updated changelog and cleaned up]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

v0 [Kazuya Mizuguchi]

v1 [Simon Horman]
* Updated patch subject

v1.1 [Simon Horman]
* As suggested by Sergei Shtylyov
  - Updated changelog
  - Corrected capitalisation in documentation
  - Removed pdev variable from ravb_open()
  - Corrected indentation
  - Leave initialisation and freeing of existing interrupt in common code
* As suggested by Geert Uytterhoeven and Sergei Shtylyov
  - support named interrupts

TODO:
* Consider propagating error for both new and existing call to
  platform_get_irq().
---
 .../devicetree/bindings/net/renesas,ravb.txt       | 12 ++++++-
 drivers/net/ethernet/renesas/ravb.h                |  1 +
 drivers/net/ethernet/renesas/ravb_main.c           | 38 +++++++++++++++++++---
 3 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/renesas,ravb.txt b/Documentation/devicetree/bindings/net/renesas,ravb.txt
index 1fd8831437bf..e2b2a551813a 100644
--- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
+++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
@@ -6,8 +6,12 @@ interface contains.
 Required properties:
 - compatible: "renesas,etheravb-r8a7790" if the device is a part of R8A7790 SoC.
 	      "renesas,etheravb-r8a7794" if the device is a part of R8A7794 SoC.
+	      "renesas,etheravb-r8a7795" if the device is a part of R8A7795 SoC.
 - reg: offset and length of (1) the register block and (2) the stream buffer.
-- interrupts: interrupt specifier for the sole interrupt.
+- interrupts: interrupt specifiers.
+	      One data and one emac interrupt for the R8A7795 SoC;
+	      these interrupts must be named.
+              One named or unnamed data interrupt otherwise.
 - phy-mode: see ethernet.txt file in the same directory.
 - phy-handle: see ethernet.txt file in the same directory.
 - #address-cells: number of address cells for the MDIO bus, must be equal to 1.
@@ -18,6 +22,12 @@ Required properties:
 Optional properties:
 - interrupt-parent: the phandle for the interrupt controller that services
 		    interrupts for this device.
+- interrupt-names: Names of named interrupts.
+                   If the property is present "data" is required.
+                   "emac" is also required for the R8A7795 SoC;
+		   it is prohibited otherwise.
+		   This property is mandatory for the R8A7795 SoC;
+		   optional otherwise.
 - pinctrl-names: pin configuration state name ("default").
 - renesas,no-ether-link: boolean, specify when a board does not provide a proper
 			 AVB_LINK signal.
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
index 026d98435d87..0276707089a5 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1185,6 +1185,7 @@ static const struct ethtool_ops ravb_ethtool_ops = {
 static int ravb_open(struct net_device *ndev)
 {
 	struct ravb_private *priv = netdev_priv(ndev);
+	struct device *dev = &priv->pdev->dev;
 	int error;
 
 	napi_enable(&priv->napi[RAVB_BE]);
@@ -1197,6 +1198,16 @@ static int ravb_open(struct net_device *ndev)
 		goto out_napi_off;
 	}
 
+	if (of_device_is_compatible(dev->of_node, "renesas,etheravb-r8a7795")) {
+		error = request_irq(priv->emac_irq, ravb_interrupt,
+				    IRQF_SHARED, ndev->name, ndev);
+		if (error) {
+			netdev_err(ndev, "cannot request IRQ\n");
+			free_irq(ndev->irq, ndev);
+			goto out_napi_off;
+		}
+	}
+
 	/* Device init */
 	error = ravb_dmac_init(ndev);
 	if (error)
@@ -1220,6 +1231,8 @@ out_ptp_stop:
 	ravb_ptp_stop(ndev);
 out_free_irq:
 	free_irq(ndev->irq, ndev);
+	if (of_device_is_compatible(dev->of_node, "renesas,etheravb-r8a7795"))
+		free_irq(priv->emac_irq, ndev);
 out_napi_off:
 	napi_disable(&priv->napi[RAVB_NC]);
 	napi_disable(&priv->napi[RAVB_BE]);
@@ -1628,9 +1641,9 @@ static int ravb_mdio_release(struct ravb_private *priv)
 static int ravb_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	int error, irq, q, is_r8a7795;
 	struct ravb_private *priv;
 	struct net_device *ndev;
-	int error, irq, q;
 	struct resource *res;
 
 	if (!np) {
@@ -1657,10 +1670,17 @@ static int ravb_probe(struct platform_device *pdev)
 	/* The Ether-specific entries in the device structure. */
 	ndev->base_addr = res->start;
 	ndev->dma = -1;
-	irq = platform_get_irq(pdev, 0);
+
+	is_r8a7795 = of_device_is_compatible(np, "renesas,etheravb-r8a7795");
+
+	irq = platform_get_irq_byname(pdev, "data");
 	if (irq < 0) {
-		error = -ENODEV;
-		goto out_release;
+		if (!is_r8a7795)
+			irq = platform_get_irq(pdev, 0);
+		if (irq < 0) {
+			error = -ENODEV;
+			goto out_release;
+		}
 	}
 	ndev->irq = irq;
 
@@ -1688,6 +1708,15 @@ static int ravb_probe(struct platform_device *pdev)
 	priv->avb_link_active_low  		of_property_read_bool(np, "renesas,ether-link-active-low");
 
+	if (is_r8a7795) {
+		irq = platform_get_irq_byname(pdev, "emac");
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
@@ -1821,6 +1850,7 @@ static const struct dev_pm_ops ravb_dev_pm_ops = {
 static const struct of_device_id ravb_match_table[] = {
 	{ .compatible = "renesas,etheravb-r8a7790" },
 	{ .compatible = "renesas,etheravb-r8a7794" },
+	{ .compatible = "renesas,etheravb-r8a7795" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ravb_match_table);
-- 
2.1.4

