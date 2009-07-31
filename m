From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Jul 2009 07:47:35 +0000
Subject: [PATCH 03/09] sh: Runtime PM pdev hwblk - Migo-R
Message-Id: <20090731074735.29009.52413.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Add hwblk_id to Migo-R board specific on-chip sh7722
platform devices.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/boards/mach-migor/setup.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- 0001/arch/sh/boards/mach-migor/setup.c
+++ work/arch/sh/boards/mach-migor/setup.c	2009-07-30 15:06:31.000000000 +0900
@@ -98,6 +98,9 @@ static struct platform_device sh_keysc_d
 	.dev	= {
 		.platform_data	= &sh_keysc_info,
 	},
+	.archdata = {
+		.hwblk_id = HWBLK_KEYSC,
+	},
 };
 
 static struct mtd_partition migor_nor_flash_partitions[] @@ -292,6 +295,9 @@ static struct platform_device migor_lcdc
 	.dev	= {
 		.platform_data	= &sh_mobile_lcdc_info,
 	},
+	.archdata = {
+		.hwblk_id = HWBLK_LCDC,
+	},
 };
 
 static struct clk *camera_clk;
@@ -379,6 +385,9 @@ static struct platform_device migor_ceu_
 	.dev	= {
 		.platform_data	= &sh_mobile_ceu_info,
 	},
+	.archdata = {
+		.hwblk_id = HWBLK_CEU,
+	},
 };
 
 struct spi_gpio_platform_data sdcard_cn9_platform_data = {
