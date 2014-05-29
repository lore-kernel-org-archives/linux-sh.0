From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 29 May 2014 01:32:08 +0000
Subject: [PATCH v3 1/2] usb: host: xhci-plat: add optional PHY support
Message-Id: <53868E18.7090805@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "mathias.nyman@intel.com" <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

This commit extends the xhci-plat so that it can optionally be passed
a reference to a PHY through the Device Tree. It will be useful for
the Armada 375 SoCs. If no PHY is provided then the behavior of the
driver is unchanged.

As for the clock, to achieve this, it adds a 'struct phy *' member in
xhci_hcd. While only used for now in xhci-plat, here again, it might
be used by other drivers in the future.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/host/xhci-plat.c |   27 ++++++++++++++++++++++++++-
 drivers/usb/host/xhci.h      |    2 ++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 29d8adb..1389370 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -15,6 +15,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>

@@ -99,6 +100,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	struct resource         *res;
 	struct usb_hcd		*hcd;
 	struct clk              *clk;
+	struct phy              *phy;
 	int			ret;
 	int			irq;

@@ -165,9 +167,23 @@ static int xhci_plat_probe(struct platform_device *pdev)
 			goto unmap_registers;
 	}

+	phy = devm_phy_optional_get(&pdev->dev, "usb");
+	if (IS_ERR(phy)) {
+		ret = PTR_ERR(phy);
+		goto disable_clk;
+	} else {
+		ret = phy_init(phy);
+		if (ret)
+			goto disable_clk;
+
+		ret = phy_power_on(phy);
+		if (ret)
+			goto disable_phy;
+	}
+
 	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (ret)
-		goto disable_clk;
+		goto power_off_phy;

 	device_wakeup_enable(hcd->self.controller);

@@ -203,6 +219,12 @@ put_usb3_hcd:
 dealloc_usb2_hcd:
 	usb_remove_hcd(hcd);

+power_off_phy:
+	phy_power_off(phy);
+
+disable_phy:
+	phy_exit(phy);
+
 disable_clk:
 	if (!IS_ERR(clk))
 		clk_disable_unprepare(clk);
@@ -224,6 +246,7 @@ static int xhci_plat_remove(struct platform_device *dev)
 	struct usb_hcd	*hcd = platform_get_drvdata(dev);
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	struct clk *clk = xhci->clk;
+	struct phy *phy = xhci->phy;

 	usb_remove_hcd(xhci->shared_hcd);
 	usb_put_hcd(xhci->shared_hcd);
@@ -231,6 +254,8 @@ static int xhci_plat_remove(struct platform_device *dev)
 	usb_remove_hcd(hcd);
 	if (!IS_ERR(clk))
 		clk_disable_unprepare(clk);
+	phy_power_off(phy);
+	phy_exit(phy);
 	iounmap(hcd->regs);
 	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	usb_put_hcd(hcd);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 9ffecd5..fa4bf17 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1474,6 +1474,8 @@ struct xhci_hcd {
 	struct msix_entry	*msix_entries;
 	/* optional clock */
 	struct clk		*clk;
+	/* optional phy */
+	struct phy		*phy;
 	/* data structures */
 	struct xhci_device_context_array *dcbaa;
 	struct xhci_ring	*cmd_ring;
-- 
1.7.9.5
