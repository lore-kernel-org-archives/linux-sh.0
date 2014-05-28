From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 28 May 2014 11:22:58 +0000
Subject: [PATCH v2 1/3] usb: host: xhci-plat: add xhci_plat_start()
Message-Id: <5385C712.8090405@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "mathias.nyman@intel.com" <mathias.nyman@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Cc: SH-Linux <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Some platforms (such as the Renesas R-Car) need to initialize some specific
registers after xhci driver calls usb_add_hcd() and before the driver calls
xhci_run(). So, this patch adds the xhci_plat_start() function.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/usb/host/xhci-plat.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 9b645ae..1389370 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -38,6 +38,11 @@ static int xhci_plat_setup(struct usb_hcd *hcd)
 	return xhci_gen_setup(hcd, xhci_plat_quirks);
 }

+static int xhci_plat_start(struct usb_hcd *hcd)
+{
+	return xhci_run(hcd);
+}
+
 static const struct hc_driver xhci_plat_xhci_driver = {
 	.description =		"xhci-hcd",
 	.product_desc =		"xHCI Host Controller",
@@ -53,7 +58,7 @@ static const struct hc_driver xhci_plat_xhci_driver = {
 	 * basic lifecycle operations
 	 */
 	.reset =		xhci_plat_setup,
-	.start =		xhci_run,
+	.start =		xhci_plat_start,
 	.stop =			xhci_stop,
 	.shutdown =		xhci_shutdown,

-- 
1.7.9.5
