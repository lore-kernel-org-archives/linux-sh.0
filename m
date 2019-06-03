From: <gregkh@linuxfoundation.org>
Date: Mon, 03 Jun 2019 13:40:59 +0000
Subject: patch "sh: no need to check return value of debugfs_create functions" added to driver-core-testing
Message-Id: <155956925917149@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


This is a note to let you know that I've just added the patch titled

    sh: no need to check return value of debugfs_create functions

to my driver-core git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git
in the driver-core-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the driver-core-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 03eb2a08fccc49f93587666e4e1a14ce00df955a Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 22 Jan 2019 15:50:30 +0100
Subject: sh: no need to check return value of debugfs_create functions

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: <linux-sh@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/sh/kernel/kdebugfs.c  |  3 ---
 arch/sh/mm/asids-debugfs.c | 11 +++--------
 arch/sh/mm/cache-debugfs.c | 20 ++++----------------
 arch/sh/mm/pmb.c           |  9 ++-------
 arch/sh/mm/tlb-debugfs.c   | 20 ++++----------------
 5 files changed, 13 insertions(+), 50 deletions(-)

diff --git a/arch/sh/kernel/kdebugfs.c b/arch/sh/kernel/kdebugfs.c
index 95428e05d212..8b505e1556a5 100644
--- a/arch/sh/kernel/kdebugfs.c
+++ b/arch/sh/kernel/kdebugfs.c
@@ -9,9 +9,6 @@ EXPORT_SYMBOL(arch_debugfs_dir);
 static int __init arch_kdebugfs_init(void)
 {
 	arch_debugfs_dir = debugfs_create_dir("sh", NULL);
-	if (!arch_debugfs_dir)
-		return -ENOMEM;
-
 	return 0;
 }
 arch_initcall(arch_kdebugfs_init);
diff --git a/arch/sh/mm/asids-debugfs.c b/arch/sh/mm/asids-debugfs.c
index e5539e0f8e3b..4c1ca197e9c5 100644
--- a/arch/sh/mm/asids-debugfs.c
+++ b/arch/sh/mm/asids-debugfs.c
@@ -63,13 +63,8 @@ static const struct file_operations asids_debugfs_fops = {
 
 static int __init asids_debugfs_init(void)
 {
-	struct dentry *asids_dentry;
-
-	asids_dentry = debugfs_create_file("asids", S_IRUSR, arch_debugfs_dir,
-					   NULL, &asids_debugfs_fops);
-	if (!asids_dentry)
-		return -ENOMEM;
-
-	return PTR_ERR_OR_ZERO(asids_dentry);
+	debugfs_create_file("asids", S_IRUSR, arch_debugfs_dir, NULL,
+			    &asids_debugfs_fops);
+	return 0;
 }
 device_initcall(asids_debugfs_init);
diff --git a/arch/sh/mm/cache-debugfs.c b/arch/sh/mm/cache-debugfs.c
index 4eb9d43578b4..17d780794497 100644
--- a/arch/sh/mm/cache-debugfs.c
+++ b/arch/sh/mm/cache-debugfs.c
@@ -109,22 +109,10 @@ static const struct file_operations cache_debugfs_fops = {
 
 static int __init cache_debugfs_init(void)
 {
-	struct dentry *dcache_dentry, *icache_dentry;
-
-	dcache_dentry = debugfs_create_file("dcache", S_IRUSR, arch_debugfs_dir,
-					    (unsigned int *)CACHE_TYPE_DCACHE,
-					    &cache_debugfs_fops);
-	if (!dcache_dentry)
-		return -ENOMEM;
-
-	icache_dentry = debugfs_create_file("icache", S_IRUSR, arch_debugfs_dir,
-					    (unsigned int *)CACHE_TYPE_ICACHE,
-					    &cache_debugfs_fops);
-	if (!icache_dentry) {
-		debugfs_remove(dcache_dentry);
-		return -ENOMEM;
-	}
-
+	debugfs_create_file("dcache", S_IRUSR, arch_debugfs_dir,
+			    (void *)CACHE_TYPE_DCACHE, &cache_debugfs_fops);
+	debugfs_create_file("icache", S_IRUSR, arch_debugfs_dir,
+			    (void *)CACHE_TYPE_ICACHE, &cache_debugfs_fops);
 	return 0;
 }
 module_init(cache_debugfs_init);
diff --git a/arch/sh/mm/pmb.c b/arch/sh/mm/pmb.c
index a53a040d0054..b59bad86b31e 100644
--- a/arch/sh/mm/pmb.c
+++ b/arch/sh/mm/pmb.c
@@ -861,13 +861,8 @@ static const struct file_operations pmb_debugfs_fops = {
 
 static int __init pmb_debugfs_init(void)
 {
-	struct dentry *dentry;
-
-	dentry = debugfs_create_file("pmb", S_IFREG | S_IRUGO,
-				     arch_debugfs_dir, NULL, &pmb_debugfs_fops);
-	if (!dentry)
-		return -ENOMEM;
-
+	debugfs_create_file("pmb", S_IFREG | S_IRUGO, arch_debugfs_dir, NULL,
+			    &pmb_debugfs_fops);
 	return 0;
 }
 subsys_initcall(pmb_debugfs_init);
diff --git a/arch/sh/mm/tlb-debugfs.c b/arch/sh/mm/tlb-debugfs.c
index dea637a09246..11c6148283f3 100644
--- a/arch/sh/mm/tlb-debugfs.c
+++ b/arch/sh/mm/tlb-debugfs.c
@@ -149,22 +149,10 @@ static const struct file_operations tlb_debugfs_fops = {
 
 static int __init tlb_debugfs_init(void)
 {
-	struct dentry *itlb, *utlb;
-
-	itlb = debugfs_create_file("itlb", S_IRUSR, arch_debugfs_dir,
-				   (unsigned int *)TLB_TYPE_ITLB,
-				   &tlb_debugfs_fops);
-	if (unlikely(!itlb))
-		return -ENOMEM;
-
-	utlb = debugfs_create_file("utlb", S_IRUSR, arch_debugfs_dir,
-				   (unsigned int *)TLB_TYPE_UTLB,
-				   &tlb_debugfs_fops);
-	if (unlikely(!utlb)) {
-		debugfs_remove(itlb);
-		return -ENOMEM;
-	}
-
+	debugfs_create_file("itlb", S_IRUSR, arch_debugfs_dir,
+			    (void *)TLB_TYPE_ITLB, &tlb_debugfs_fops);
+	debugfs_create_file("utlb", S_IRUSR, arch_debugfs_dir,
+			    (void *)TLB_TYPE_UTLB, &tlb_debugfs_fops);
 	return 0;
 }
 module_init(tlb_debugfs_init);
-- 
2.21.0
