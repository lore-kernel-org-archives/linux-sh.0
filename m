From: Yangtao Li <tiny.windzz@gmail.com>
Date: Tue, 06 Nov 2018 14:40:30 +0000
Subject: [PATCH] sh: mm: Change to use DEFINE_SHOW_ATTRIBUTE macro
Message-Id: <20181106144030.8663-1-tiny.windzz@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ysato@users.sourceforge.jp, dalias@libc.org
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 arch/sh/mm/asids-debugfs.c | 15 ++-------------
 arch/sh/mm/cache-debugfs.c | 15 ++-------------
 arch/sh/mm/tlb-debugfs.c   | 15 ++-------------
 3 files changed, 6 insertions(+), 39 deletions(-)

diff --git a/arch/sh/mm/asids-debugfs.c b/arch/sh/mm/asids-debugfs.c
index e5539e0f8e3b..a3cfa04543e4 100644
--- a/arch/sh/mm/asids-debugfs.c
+++ b/arch/sh/mm/asids-debugfs.c
@@ -26,7 +26,7 @@
 #include <asm/processor.h>
 #include <asm/mmu_context.h>
 
-static int asids_seq_show(struct seq_file *file, void *iter)
+static int asids_debugfs_show(struct seq_file *file, void *iter)
 {
 	struct task_struct *p;
 
@@ -48,18 +48,7 @@ static int asids_seq_show(struct seq_file *file, void *iter)
 	return 0;
 }
 
-static int asids_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, asids_seq_show, inode->i_private);
-}
-
-static const struct file_operations asids_debugfs_fops = {
-	.owner		= THIS_MODULE,
-	.open		= asids_debugfs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(asids_debugfs);
 
 static int __init asids_debugfs_init(void)
 {
diff --git a/arch/sh/mm/cache-debugfs.c b/arch/sh/mm/cache-debugfs.c
index 4eb9d43578b4..08420371af97 100644
--- a/arch/sh/mm/cache-debugfs.c
+++ b/arch/sh/mm/cache-debugfs.c
@@ -22,7 +22,7 @@ enum cache_type {
 	CACHE_TYPE_UNIFIED,
 };
 
-static int cache_seq_show(struct seq_file *file, void *iter)
+static int cache_debugfs_show(struct seq_file *file, void *iter)
 {
 	unsigned int cache_type = (unsigned int)file->private;
 	struct cache_info *cache;
@@ -94,18 +94,7 @@ static int cache_seq_show(struct seq_file *file, void *iter)
 	return 0;
 }
 
-static int cache_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, cache_seq_show, inode->i_private);
-}
-
-static const struct file_operations cache_debugfs_fops = {
-	.owner		= THIS_MODULE,
-	.open		= cache_debugfs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(cache_debugfs);
 
 static int __init cache_debugfs_init(void)
 {
diff --git a/arch/sh/mm/tlb-debugfs.c b/arch/sh/mm/tlb-debugfs.c
index dea637a09246..74c252ed35fc 100644
--- a/arch/sh/mm/tlb-debugfs.c
+++ b/arch/sh/mm/tlb-debugfs.c
@@ -36,7 +36,7 @@ static struct {
 	{ 0xc, " 64MB" },
 };
 
-static int tlb_seq_show(struct seq_file *file, void *iter)
+static int tlb_debugfs_show(struct seq_file *file, void *iter)
 {
 	unsigned int tlb_type = (unsigned int)file->private;
 	unsigned long addr1, addr2, data1, data2;
@@ -134,18 +134,7 @@ static int tlb_seq_show(struct seq_file *file, void *iter)
 	return 0;
 }
 
-static int tlb_debugfs_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, tlb_seq_show, inode->i_private);
-}
-
-static const struct file_operations tlb_debugfs_fops = {
-	.owner		= THIS_MODULE,
-	.open		= tlb_debugfs_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(tlb_debugfs);
 
 static int __init tlb_debugfs_init(void)
 {
-- 
2.17.0
