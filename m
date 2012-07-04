From: Bastian Hecht <hechtb@googlemail.com>
Date: Wed, 04 Jul 2012 14:05:26 +0000
Subject: [PATCH] mtd: sh_flctl: Switch from tick-based to time-based timeout
Message-Id: <1341410726-10562-1-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mtd@lists.infradead.org
Cc: Bastian Hecht <hechtb@gmail.com>, Artem Bityutskiy <dedekind1@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>

Instead of counting down a compile-time value, we use a value based on
jiffies.

Signed-off-by: Bastian Hecht <hechtb@gmail.com>
---
Artem mentioned the idea a while ago - here is the simple implementation now.

 drivers/mtd/nand/sh_flctl.c  |   14 +++++++++-----
 include/linux/mtd/sh_flctl.h |    2 +-
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/sh_flctl.c b/drivers/mtd/nand/sh_flctl.c
index ed03ed2..0d9cce7 100644
--- a/drivers/mtd/nand/sh_flctl.c
+++ b/drivers/mtd/nand/sh_flctl.c
@@ -73,6 +73,8 @@ static struct nand_bbt_descr flctl_4secc_largepage = {
 	.pattern = scan_ff_pattern,
 };
 
+static int loop_timeout_max;
+
 static void empty_fifo(struct sh_flctl *flctl)
 {
 	writel(flctl->flintdmacr_base | AC1CLR | AC0CLR, FLINTDMACR(flctl));
@@ -91,7 +93,7 @@ static void timeout_error(struct sh_flctl *flctl, const char *str)
 
 static void wait_completion(struct sh_flctl *flctl)
 {
-	uint32_t timeout = LOOP_TIMEOUT_MAX;
+	uint32_t timeout = loop_timeout_max;
 
 	while (timeout--) {
 		if (readb(FLTRCR(flctl)) & TREND) {
@@ -138,7 +140,7 @@ static void set_addr(struct mtd_info *mtd, int column, int page_addr)
 
 static void wait_rfifo_ready(struct sh_flctl *flctl)
 {
-	uint32_t timeout = LOOP_TIMEOUT_MAX;
+	uint32_t timeout = loop_timeout_max;
 
 	while (timeout--) {
 		uint32_t val;
@@ -153,7 +155,7 @@ static void wait_rfifo_ready(struct sh_flctl *flctl)
 
 static void wait_wfifo_ready(struct sh_flctl *flctl)
 {
-	uint32_t len, timeout = LOOP_TIMEOUT_MAX;
+	uint32_t len, timeout = loop_timeout_max;
 
 	while (timeout--) {
 		/* check FIFO */
@@ -168,7 +170,7 @@ static void wait_wfifo_ready(struct sh_flctl *flctl)
 static enum flctl_ecc_res_t wait_recfifo_ready
 		(struct sh_flctl *flctl, int sector_number)
 {
-	uint32_t timeout = LOOP_TIMEOUT_MAX;
+	uint32_t timeout = loop_timeout_max;
 	void __iomem *ecc_reg[4];
 	int i;
 	int state = FL_SUCCESS;
@@ -247,7 +249,7 @@ static enum flctl_ecc_res_t wait_recfifo_ready
 
 static void wait_wecfifo_ready(struct sh_flctl *flctl)
 {
-	uint32_t timeout = LOOP_TIMEOUT_MAX;
+	uint32_t timeout = loop_timeout_max;
 	uint32_t len;
 
 	while (timeout--) {
@@ -939,6 +941,8 @@ static int __devinit flctl_probe(struct platform_device *pdev)
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_resume(&pdev->dev);
 
+	loop_timeout_max = loops_per_jiffy * msecs_to_jiffies(LOOP_TIMEOUT_MS);
+
 	ret = nand_scan_ident(flctl_mtd, 1, NULL);
 	if (ret)
 		goto err_chip;
diff --git a/include/linux/mtd/sh_flctl.h b/include/linux/mtd/sh_flctl.h
index 01e4b15..ade44c1 100644
--- a/include/linux/mtd/sh_flctl.h
+++ b/include/linux/mtd/sh_flctl.h
@@ -129,7 +129,7 @@
 #define	_4ECCEND	(0x1 << 1)	/* 4 symbols end */
 #define	_4ECCEXST	(0x1 << 0)	/* 4 symbols exist */
 
-#define LOOP_TIMEOUT_MAX	0x00010000
+#define LOOP_TIMEOUT_MS	100
 
 enum flctl_ecc_res_t {
 	FL_SUCCESS,
-- 
1.7.9.5

