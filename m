From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Jul 2009 07:48:02 +0000
Subject: [PATCH 06/09] sh: Runtime PM pdev hwblk - AP325RXA
Message-Id: <20090731074802.29009.24632.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add hwblk_id to AP325RXA board specific on-chip sh7723
platform devices.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/board-ap325rxa.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- 0001/arch/sh/boards/board-ap325rxa.c
+++ work/arch/sh/boards/board-ap325rxa.c	2009-07-30 15:40:23.000000000 +0900
@@ -227,6 +227,9 @@ static struct platform_device lcdc_devic
 	.dev		= {
 		.platform_data	= &lcdc_info,
 	},
+	.archdata = {
+		.hwblk_id = HWBLK_LCDC,
+	},
 };
 
 static void camera_power(int val)
@@ -377,6 +380,9 @@ static struct platform_device ceu_device
 	.dev		= {
 		.platform_data	= &sh_mobile_ceu_info,
 	},
+	.archdata = {
+		.hwblk_id = HWBLK_CEU,
+	},
 };
 
 struct spi_gpio_platform_data sdcard_cn3_platform_data = {
