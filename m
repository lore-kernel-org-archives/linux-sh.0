From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Wed, 24 Sep 2008 02:46:48 +0000
Subject: [PATCH v2] sh: ap325rxa: create CPLD data area in mtd
Message-Id: <48D9AA18.2070803@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

AP320 and AP325RXA has CPLD data in NOR Flash.
If this area erased, this board can not boot.
This patch create CPLD data area and set writeable mask bit.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/boards/board-ap325rxa.c |   33 +++++++++++++++++++++++----------
 1 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/sh/boards/board-ap325rxa.c b/arch/sh/boards/board-ap325rxa.c
index fd16125..f0b82c6 100644
--- a/arch/sh/boards/board-ap325rxa.c
+++ b/arch/sh/boards/board-ap325rxa.c
@@ -52,20 +52,33 @@ static struct platform_device smc9118_device = {
 	},
 };

+/*
+ * AP320 and AP325RXA has CPLD data in NOR Flash(0xA80000-0xABFFFF).
+ * If this area erased, this board can not boot.
+ */
 static struct mtd_partition ap325rxa_nor_flash_partitions[] = {
 	{
-		 .name = "uboot",
-		 .offset = 0,
-		 .size = (1 * 1024 * 1024),
-		 .mask_flags = MTD_WRITEABLE,	/* Read-only */
+		.name = "uboot",
+		.offset = 0,
+		.size = (1 * 1024 * 1024),
+		.mask_flags = MTD_WRITEABLE,	/* Read-only */
+	}, {
+		.name = "kernel",
+		.offset = MTDPART_OFS_APPEND,
+		.size = (2 * 1024 * 1024),
+	}, {
+		.name = "free-area0",
+		.offset = MTDPART_OFS_APPEND,
+		.size = ((7 * 1024 * 1024) + (512 * 1024)),
 	}, {
-		 .name = "kernel",
-		 .offset = MTDPART_OFS_APPEND,
-		 .size = (2 * 1024 * 1024),
+		.name = "CPLD-Data",
+		.offset = MTDPART_OFS_APPEND,
+		.mask_flags = MTD_WRITEABLE,	/* Read-only */
+		.size = (1024 * 128 * 2),
 	}, {
-		 .name = "other",
-		 .offset = MTDPART_OFS_APPEND,
-		 .size = MTDPART_SIZ_FULL,
+		.name = "free-area1",
+		.offset = MTDPART_OFS_APPEND,
+		.size = MTDPART_SIZ_FULL,
 	},
 };

-- 
1.5.6.3

