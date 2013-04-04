From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 04 Apr 2013 22:59:50 +0000
Subject: [PATCH 2/8] ehci-platform: add init() method to platform data
Message-Id: <201304050259.51025.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Sometimes there is a need to initialize some non-standard registers mapped to
the EHCI region before accessing the standard EHCI registers.  Add the init()
method to the 'ehci-platform' platform data for this purpose.

Suggested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/usb/host/ehci-platform.c |    7 +++++++
 include/linux/usb/ehci_pdriver.h |    1 +
 2 files changed, 8 insertions(+)

Index: renesas/drivers/usb/host/ehci-platform.c
=================================--- renesas.orig/drivers/usb/host/ehci-platform.c
+++ renesas/drivers/usb/host/ehci-platform.c
@@ -110,6 +110,13 @@ static int ehci_platform_probe(struct pl
 		err = PTR_ERR(hcd->regs);
 		goto err_put_hcd;
 	}
+
+	if (pdata->init) {
+		err = pdata->init(dev, hcd->regs);
+		if (err < 0)
+			goto err_put_hcd;
+	}
+
 	err = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (err)
 		goto err_put_hcd;
Index: renesas/include/linux/usb/ehci_pdriver.h
=================================--- renesas.orig/include/linux/usb/ehci_pdriver.h
+++ renesas/include/linux/usb/ehci_pdriver.h
@@ -50,6 +50,7 @@ struct usb_ehci_pdata {
 	/* Turn on only VBUS suspend power and hotplug detection,
 	 * turn off everything else */
 	void (*power_suspend)(struct platform_device *pdev);
+	int (*init)(struct platform_device *pdev, void __iomem *regs);
 };
 
 #endif /* __USB_CORE_EHCI_PDRIVER_H */
