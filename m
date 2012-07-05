From: Bastian Hecht <hechtb@googlemail.com>
Date: Thu, 05 Jul 2012 10:41:01 +0000
Subject: [PATCH 1/2] mtd: sh_flctl: Use memcpy() instead of using a loop
Message-Id: <1341484862-24033-1-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org
Cc: Bastian Hecht <hechtb@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>

Elemets have been copied "manually" in a loop. Better use memcpy().

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
 drivers/mtd/nand/sh_flctl.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index 0d9cce7..e4f31ef 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -29,6 +29,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/nand.h>
@@ -748,10 +749,9 @@ static void flctl_select_chip(struct mtd_info *mtd, int chipnr)
 static void flctl_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 {
 	struct sh_flctl *flctl = mtd_to_flctl(mtd);
-	int i, index = flctl->index;
+	int index = flctl->index;
 
-	for (i = 0; i < len; i++)
-		flctl->done_buff[index + i] = buf[i];
+	memcpy(&flctl->done_buff[index], buf, len);
 	flctl->index += len;
 }
 
@@ -780,10 +780,11 @@ static uint16_t flctl_read_word(struct mtd_info *mtd)
 
 static void flctl_read_buf(struct mtd_info *mtd, uint8_t *buf, int len)
 {
-	int i;
+	struct sh_flctl *flctl = mtd_to_flctl(mtd);
+	int index = flctl->index;
 
-	for (i = 0; i < len; i++)
-		buf[i] = flctl_read_byte(mtd);
+	memcpy(buf, &flctl->done_buff[index], len);
+	flctl->index += len;
 }
 
 static int flctl_verify_buf(struct mtd_info *mtd, const u_char *buf, int len)
-- 
1.7.9.5

