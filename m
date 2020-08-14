From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 14 Aug 2020 11:07:30 +0000
Subject: [PATCH 2/3] rtc: rtc-rs5c313: Fix late hardware init
Message-Id: <20200814110731.29029-3-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200814110731.29029-1-geert+renesas@glider.be>
In-Reply-To: <20200814110731.29029-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, kogiidena <kogiidena@eggplant.ddo.jp>, Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-rtc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

rs5c313_rtc_init() calls platform_driver_register(), and initializes the
hardware.  This is wrong because of two reasons:
  1. As soon as the driver has been registered, the device may be
     probed.  If devm_rtc_device_register() is called before hardware
     initialization, reading the current time will fail:

	rs5c313 rs5c313: rs5c313_rtc_read_time: timeout error
	rs5c313 rs5c313: registered as rtc0
	rs5c313 rs5c313: rs5c313_rtc_read_time: timeout error
	rs5c313 rs5c313: hctosys: unable to read the hardware clock

  2. If the platform device does not exist, the driver will still write
     to a hardware device that may not be present.

Fix this by moving the hardware initialization sequence to the driver's
.probe() method.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/rtc/rtc-rs5c313.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c313.c b/drivers/rtc/rtc-rs5c313.c
index 00b5ef753935ec8a..af72e428b218173e 100644
--- a/drivers/rtc/rtc-rs5c313.c
+++ b/drivers/rtc/rtc-rs5c313.c
@@ -366,8 +366,13 @@ static const struct rtc_class_ops rs5c313_rtc_ops = {
 
 static int rs5c313_rtc_probe(struct platform_device *pdev)
 {
-	struct rtc_device *rtc = devm_rtc_device_register(&pdev->dev, "rs5c313",
-				&rs5c313_rtc_ops, THIS_MODULE);
+	struct rtc_device *rtc;
+
+	rs5c313_init_port();
+	rs5c313_check_xstp_bit();
+
+	rtc = devm_rtc_device_register(&pdev->dev, "rs5c313", &rs5c313_rtc_ops,
+				       THIS_MODULE);
 
 	return PTR_ERR_OR_ZERO(rtc);
 }
@@ -381,16 +386,7 @@ static struct platform_driver rs5c313_rtc_platform_driver = {
 
 static int __init rs5c313_rtc_init(void)
 {
-	int err;
-
-	err = platform_driver_register(&rs5c313_rtc_platform_driver);
-	if (err)
-		return err;
-
-	rs5c313_init_port();
-	rs5c313_check_xstp_bit();
-
-	return 0;
+	return platform_driver_register(&rs5c313_rtc_platform_driver);
 }
 
 static void __exit rs5c313_rtc_exit(void)
-- 
2.17.1
