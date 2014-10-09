From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 09 Oct 2014 04:45:47 +0000
Subject: [PATCH] usb: host: xhci-plat: fix suspend/resume on xhci-rcar
Message-Id: <1412829947-736-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch fixes an issue that suspend/resume cannot work correctly
on xhci-rcar because the xhci driver output the following log:

        xhci-hcd ee000000.usb: WARN: xHC CMD_RUN timeout

So, this patch adds to set the XHCI_SLOW_SUSPEND quirk if xhci-rcar.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 This patch is based on the Greg's usb.git / usb-next branch.
 (commit id : 4ed9a3d455558406cad83d38764ee659de25851c)

 drivers/usb/host/xhci-plat.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 3d78b0c..a266883 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -27,12 +27,18 @@ static struct hc_driver __read_mostly xhci_plat_hc_driver;
 
 static void xhci_plat_quirks(struct device *dev, struct xhci_hcd *xhci)
 {
+	struct device_node *of_node = dev->of_node;
 	/*
 	 * As of now platform drivers don't provide MSI support so we ensure
 	 * here that the generic code does not try to make a pci_dev from our
 	 * dev struct in order to setup MSI
 	 */
 	xhci->quirks |= XHCI_PLAT;
+
+	/* QUIRK: R-Car xHCI must be suspended extra slowly */
+	if (of_device_is_compatible(of_node, "renesas,xhci-r8a7790") ||
+	    of_device_is_compatible(of_node, "renesas,xhci-r8a7791"))
+		xhci->quirks |= XHCI_SLOW_SUSPEND;
 }
 
 /* called during probe() after chip reset completes */
-- 
1.7.9.5

