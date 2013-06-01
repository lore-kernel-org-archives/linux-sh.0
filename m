From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 01 Jun 2013 21:33:56 +0000
Subject: [PATCH v8 2/9] ehci-platform: add pre_setup() method to platform data
Message-Id: <201306020133.57070.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Sometimes there is a need  to initialize some non-standard registers mapped to
the EHCI region before accessing the standard EHCI registers.  Add pre_setup()
method with 'struct usb_hcd *' parameter to be called just before ehci_setup()
to the 'ehci-platform'  driver's platform data for this purpose...

While at it, add the missing incomplete declaration of 'struct platform_device'
to <linux/usb/ehci_pdriver.h>...

The patch has been tested on the Marzen and BOCK-W boards.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Alan Stern <stern@rowland.harvard.edu>

---
Changes since version 7:
- refreshed the patch.

Changes since version 3:
- added ACK from Alan Stern.

Changes since version 2:
- replaced #include with incomplete declarations of 'struct platform_device' and
  'struct usb_hcd';
- added a note about testing to the changelog;
- added ACKs from Simon Horman and Kuninori Morimoto.

Changes since the original posting:
- changed init() method to pre_setup() with different parameters and call site.

 drivers/usb/host/ehci-platform.c |    6 ++++++
 include/linux/usb/ehci_pdriver.h |    4 ++++
 2 files changed, 10 insertions(+)

Index: renesas/drivers/usb/host/ehci-platform.c
=================================--- renesas.orig/drivers/usb/host/ehci-platform.c
+++ renesas/drivers/usb/host/ehci-platform.c
@@ -48,6 +48,12 @@ static int ehci_platform_reset(struct us
 	ehci->big_endian_desc = pdata->big_endian_desc;
 	ehci->big_endian_mmio = pdata->big_endian_mmio;
 
+	if (pdata->pre_setup) {
+		retval = pdata->pre_setup(hcd);
+		if (retval < 0)
+			return retval;
+	}
+
 	ehci->caps = hcd->regs + pdata->caps_offset;
 	retval = ehci_setup(hcd);
 	if (retval)
Index: renesas/include/linux/usb/ehci_pdriver.h
=================================--- renesas.orig/include/linux/usb/ehci_pdriver.h
+++ renesas/include/linux/usb/ehci_pdriver.h
@@ -19,6 +19,9 @@
 #ifndef __USB_CORE_EHCI_PDRIVER_H
 #define __USB_CORE_EHCI_PDRIVER_H
 
+struct platform_device;
+struct usb_hcd;
+
 /**
  * struct usb_ehci_pdata - platform_data for generic ehci driver
  *
@@ -50,6 +53,7 @@ struct usb_ehci_pdata {
 	/* Turn on only VBUS suspend power and hotplug detection,
 	 * turn off everything else */
 	void (*power_suspend)(struct platform_device *pdev);
+	int (*pre_setup)(struct usb_hcd *hcd);
 };
 
 #endif /* __USB_CORE_EHCI_PDRIVER_H */

