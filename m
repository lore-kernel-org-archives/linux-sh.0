From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 14 Aug 2020 11:07:29 +0000
Subject: [PATCH 1/3] rtc: rtc-rs5c313: Drop obsolete platform_set_drvdata() call
Message-Id: <20200814110731.29029-2-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200814110731.29029-1-geert+renesas@glider.be>
In-Reply-To: <20200814110731.29029-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, kogiidena <kogiidena@eggplant.ddo.jp>, Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-rtc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Commit 284e2fa1da00a998 ("rtc: rtc-rs5c313: use
devm_rtc_device_register()"), removed the last user of the
driver-specific data.  Hence there is no longer a need to set it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/rtc/rtc-rs5c313.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c313.c b/drivers/rtc/rtc-rs5c313.c
index 89f38e3e917d3d11..00b5ef753935ec8a 100644
--- a/drivers/rtc/rtc-rs5c313.c
+++ b/drivers/rtc/rtc-rs5c313.c
@@ -369,12 +369,7 @@ static int rs5c313_rtc_probe(struct platform_device *pdev)
 	struct rtc_device *rtc = devm_rtc_device_register(&pdev->dev, "rs5c313",
 				&rs5c313_rtc_ops, THIS_MODULE);
 
-	if (IS_ERR(rtc))
-		return PTR_ERR(rtc);
-
-	platform_set_drvdata(pdev, rtc);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(rtc);
 }
 
 static struct platform_driver rs5c313_rtc_platform_driver = {
-- 
2.17.1
