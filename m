From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 14 Aug 2020 11:07:31 +0000
Subject: [PATCH 3/3] rtc: rtc-rs5c313: Convert to module_platform_driver()
Message-Id: <20200814110731.29029-4-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200814110731.29029-1-geert+renesas@glider.be>
In-Reply-To: <20200814110731.29029-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alessandro Zummo <a.zummo@towertech.it>, Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, kogiidena <kogiidena@eggplant.ddo.jp>, Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-rtc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Reduce boilerplate by using the module_platform_driver() helper.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/rtc/rtc-rs5c313.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/rtc/rtc-rs5c313.c b/drivers/rtc/rtc-rs5c313.c
index af72e428b218173e..e98f85f34206f16c 100644
--- a/drivers/rtc/rtc-rs5c313.c
+++ b/drivers/rtc/rtc-rs5c313.c
@@ -384,18 +384,7 @@ static struct platform_driver rs5c313_rtc_platform_driver = {
 	.probe	= rs5c313_rtc_probe,
 };
 
-static int __init rs5c313_rtc_init(void)
-{
-	return platform_driver_register(&rs5c313_rtc_platform_driver);
-}
-
-static void __exit rs5c313_rtc_exit(void)
-{
-	platform_driver_unregister(&rs5c313_rtc_platform_driver);
-}
-
-module_init(rs5c313_rtc_init);
-module_exit(rs5c313_rtc_exit);
+module_platform_driver(rs5c313_rtc_platform_driver);
 
 MODULE_AUTHOR("kogiidena , Nobuhiro Iwamatsu <iwamatsu@nigauri.org>");
 MODULE_DESCRIPTION("Ricoh RS5C313 RTC device driver");
-- 
2.17.1
