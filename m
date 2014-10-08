From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 08 Oct 2014 21:42:29 +0000
Subject: [PATCH] renesas_usbhs: fix platform init error message
Message-Id: <1629718.KlA1FP4xFz@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

There is a typo ("prove" instead of "probe") in the error message printed when
the platform initialization fails. Replace that word with more fitting "init".

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 drivers/usb/renesas_usbhs/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: usb/drivers/usb/renesas_usbhs/common.c
=================================--- usb.orig/drivers/usb/renesas_usbhs/common.c
+++ usb/drivers/usb/renesas_usbhs/common.c
@@ -572,7 +572,7 @@ static int usbhs_probe(struct platform_d
 	 */
 	ret = usbhs_platform_call(priv, hardware_init, pdev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "platform prove failed.\n");
+		dev_err(&pdev->dev, "platform init failed.\n");
 		goto probe_end_mod_exit;
 	}
 

