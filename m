From: Yangtao Li <tiny.windzz@gmail.com>
Date: Sat, 01 Dec 2018 13:43:20 +0000
Subject: [PATCH] sh: intc: convert to DEFINE_SHOW_ATTRIBUTE
Message-Id: <20181201134320.7351-1-tiny.windzz@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/sh/intc/virq-debugfs.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/sh/intc/virq-debugfs.c b/drivers/sh/intc/virq-debugfs.c
index 9e62ba9311f0..939915a07d99 100644
--- a/drivers/sh/intc/virq-debugfs.c
+++ b/drivers/sh/intc/virq-debugfs.c
@@ -16,7 +16,7 @@
 #include <linux/debugfs.h>
 #include "internals.h"
 
-static int intc_irq_xlate_debug(struct seq_file *m, void *priv)
+static int intc_irq_xlate_show(struct seq_file *m, void *priv)
 {
 	int i;
 
@@ -37,17 +37,7 @@ static int intc_irq_xlate_debug(struct seq_file *m, void *priv)
 	return 0;
 }
 
-static int intc_irq_xlate_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, intc_irq_xlate_debug, inode->i_private);
-}
-
-static const struct file_operations intc_irq_xlate_fops = {
-	.open = intc_irq_xlate_open,
-	.read = seq_read,
-	.llseek = seq_lseek,
-	.release = single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(intc_irq_xlate);
 
 static int __init intc_irq_xlate_init(void)
 {
-- 
2.17.0
