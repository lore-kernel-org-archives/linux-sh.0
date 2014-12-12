From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 12 Dec 2014 19:53:18 +0000
Subject: [PATCH] renesas_usbhs: kill dead code in usbhs_probe()
Message-Id: <1712999.cba28NOnAE@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

usbhsc_drvcllbck_notify_hotplug() always returns 0, so it's rather pointless to
store and check its result for being < 0.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'next' branch of Felipe Balbi's 'usb.git' repo.

 drivers/usb/renesas_usbhs/common.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

Index: usb/drivers/usb/renesas_usbhs/common.c
=================================--- usb.orig/drivers/usb/renesas_usbhs/common.c
+++ usb/drivers/usb/renesas_usbhs/common.c
@@ -632,16 +632,12 @@ static int usbhs_probe(struct platform_d
 	/*
 	 * manual call notify_hotplug for cold plug
 	 */
-	ret = usbhsc_drvcllbck_notify_hotplug(pdev);
-	if (ret < 0)
-		goto probe_end_call_remove;
+	usbhsc_drvcllbck_notify_hotplug(pdev);
 
 	dev_info(&pdev->dev, "probed\n");
 
 	return ret;
 
-probe_end_call_remove:
-	usbhs_platform_call(priv, hardware_exit, pdev);
 probe_end_mod_exit:
 	usbhs_mod_remove(priv);
 probe_end_fifo_exit:

