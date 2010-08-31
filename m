From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 31 Aug 2010 09:22:36 +0000
Subject: [PATCH] ARM: mach-shmobile: Extend AP4EVB LCD comments
Message-Id: <20100831092236.13809.80418.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Extend dip switch comments for QHD and WVGA LCD panels
on AP4EVB. Similar to the Ecovec comments.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-ap4evb.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/board-ap4evb.c
+++ work/arch/arm/mach-shmobile/board-ap4evb.c	2010-08-19 13:47:23.000000000 +0900
@@ -951,8 +951,10 @@ static void __init ap4evb_init(void)
 				ARRAY_SIZE(i2c1_devices));
 
 #ifdef CONFIG_AP4EVB_QHD
+
 	/*
-	 * QHD
+	 * For QHD Panel (MIPI-DSI, CONFIG_AP4EVB_QHD=y) and
+	 * IRQ28 for Touch Panel, set dip switches S3, S43 as OFF, ON.
 	 */
 
 	/* enable KEYSC */
@@ -996,8 +998,10 @@ static void __init ap4evb_init(void)
 
 #else
 	/*
-	 * WVGA
+	 * For WVGA Panel (18-bit RGB, CONFIG_AP4EVB_WVGA=y) and
+	 * IRQ7 for Touch Panel, set dip switches S3, S43 to ON, OFF.
 	 */
+
 	gpio_request(GPIO_FN_LCDD17,   NULL);
 	gpio_request(GPIO_FN_LCDD16,   NULL);
 	gpio_request(GPIO_FN_LCDD15,   NULL);
