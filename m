From: Li Zefan <lizf@cn.fujitsu.com>
Date: Tue, 24 Jun 2008 05:30:23 +0000
Subject: [PATCH] sh: fix seq_file memory leak
Message-Id: <4860866F.7050703@cn.fujitsu.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

When using single_open(), single_release() should be used instead
of seq_release(), otherwise there is a memory leak.

Signed-off-by: Li Zefan <lizf@cn.fujitsu.com>
---
 arch/sh/mm/cache-debugfs.c |    2 +-
 arch/sh/mm/pmb.c           |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/mm/cache-debugfs.c b/arch/sh/mm/cache-debugfs.c
index c5b56d5..0e189cc 100644
--- a/arch/sh/mm/cache-debugfs.c
+++ b/arch/sh/mm/cache-debugfs.c
@@ -120,7 +120,7 @@ static const struct file_operations cache_debugfs_fops = {
 	.open		= cache_debugfs_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= seq_release,
+	.release	= single_release,
 };
 
 static int __init cache_debugfs_init(void)
diff --git a/arch/sh/mm/pmb.c b/arch/sh/mm/pmb.c
index 0b0ec6e..95653e2 100644
--- a/arch/sh/mm/pmb.c
+++ b/arch/sh/mm/pmb.c
@@ -385,7 +385,7 @@ static const struct file_operations pmb_debugfs_fops = {
 	.open		= pmb_debugfs_open,
 	.read		= seq_read,
 	.llseek		= seq_lseek,
-	.release	= seq_release,
+	.release	= single_release,
 };
 
 static int __init pmb_debugfs_init(void)
-- 
1.5.4.rc3
