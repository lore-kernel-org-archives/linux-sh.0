From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 14 Dec 2012 05:55:53 +0000
Subject: [PATCH] clocksource: sh_cmt: 32-bit control register access prototype
Message-Id: <20121214060026.10668.35031.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This is a 32-bit control register access prototype
for the CMT driver. It is not ready for merge but
it intends to show the reasoning behind the
register access patches included in this series:
"[PATCH 00/08] clocksource: sh_cmt: CMT driver update"

Not-Yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 drivers/clocksource/sh_cmt.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- 0006/drivers/clocksource/sh_cmt.c
+++ work/drivers/clocksource/sh_cmt.c	2012-12-14 11:53:23.000000000 +0900
@@ -79,6 +79,12 @@ struct sh_cmt_priv {
  * CMCSR 0xffca0060 16-bit
  * CMCNT 0xffca0064 32-bit
  * CMCOR 0xffca0068 32-bit
+ *
+ * "32-bit counter and 32-bit control"
+ * CMSTR 0xe6130000 32-bit
+ * CMCSR 0xe6130010 32-bit
+ * CMCNT 0xe6130014 32-bit
+ * CMCOR 0xe6130018 32-bit
  */
 
 static unsigned long sh_cmt_read16(void __iomem *base, unsigned long offs)
@@ -734,8 +740,13 @@ static int sh_cmt_setup(struct sh_cmt_pr
 		goto err1;
 	}
 
+#if 1 /* XXX: filthy prototype hack! */
+	p->read_control = sh_cmt_read32;
+	p->write_control = sh_cmt_write32;
+#else
 	p->read_control = sh_cmt_read16;
 	p->write_control = sh_cmt_write16;
+#endif
 
 	if (resource_size(res) = 6) {
 		p->width = 16;
