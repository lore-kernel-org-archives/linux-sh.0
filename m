From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Mon, 25 Aug 2008 06:31:56 +0000
Subject: [PATCH] sh: ap325rxa: create CPLD data area in mtd
Message-Id: <48B251DC.2030709@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <48B24FF8.6060009@renesas.com>
In-Reply-To: <48B24FF8.6060009@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

AP320 and AP325RXA has CPLD data in NOR Flash.
If this area erased, this board can not boot.
This patch create CPLD data area and set writeable mask bit.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/boards/board-ap325rxa.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/board-ap325rxa.c b/arch/sh/boards/board-ap325rxa.c
index fd16125..9e24455 100644
--- a/arch/sh/boards/board-ap325rxa.c
+++ b/arch/sh/boards/board-ap325rxa.c
@@ -52,6 +52,10 @@ static struct platform_device smc9118_device = {
 	},
 };

+/*
+ * AP320 and AP325RXA has CPLD data in NOR Flash(0xA80000-0xABFFFF).
+ * If this area erased, this board can not boot.
+ */
 static struct mtd_partition ap325rxa_nor_flash_partitions[] = {
 	{
 		 .name = "uboot",
@@ -63,7 +67,17 @@ static struct mtd_partition ap325rxa_nor_flash_partitions[] = {
 		 .offset = MTDPART_OFS_APPEND,
 		 .size = (2 * 1024 * 1024),
 	}, {
-		 .name = "other",
+		 .name = "free-area0",
+		 .offset = MTDPART_OFS_APPEND,
+		 .size = ((7 * 1024 * 1024) + (512 * 1024)),
+	}, {
+		 .name = "FPGA-Data",
+		 .offset = MTDPART_OFS_APPEND,
+		 .mask_flags = MTD_WRITEABLE,	/* Read-only */
+		 .size = (1024 * 128 * 2),
+		 .size = MTDPART_SIZ_FULL,
+	}, {
+		 .name = "free-area1",
 		 .offset = MTDPART_OFS_APPEND,
 		 .size = MTDPART_SIZ_FULL,
 	},
@@ -292,7 +306,7 @@ static int __init ap325rxa_devices_setup(void)

 	i2c_register_board_info(0, ap325rxa_i2c_devices,
 				ARRAY_SIZE(ap325rxa_i2c_devices));
-
+
 	return platform_add_devices(ap325rxa_devices,
 				ARRAY_SIZE(ap325rxa_devices));
 }
-- 
1.5.6.3

