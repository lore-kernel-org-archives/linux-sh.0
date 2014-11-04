From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 04 Nov 2014 22:48:48 +0000
Subject: [PATCH v2] renesas_usbhs: fix platform init error message
Message-Id: <5384843.KGcHOMgQLi@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

There is a typo ("prove" instead of "probe") in the error message printed when
the platform initialization fails. Replace that word with more fitting "init".

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'usb-linus' branch of Greg KH's 'usb.git' repo.

Changes in varsion 2:
- refreshed the patch.

 drivers/usb/renesas_usbhs/common.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: usb/drivers/usb/renesas_usbhs/common.c
=================================--- usb.orig/drivers/usb/renesas_usbhs/common.c
+++ usb/drivers/usb/renesas_usbhs/common.c
@@ -615,7 +615,7 @@ static int usbhs_probe(struct platform_d
 	 */
 	ret = usbhs_platform_call(priv, hardware_init, pdev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "platform prove failed.\n");
+		dev_err(&pdev->dev, "platform init failed.\n");
 		goto probe_end_mod_exit;
 	}
 

