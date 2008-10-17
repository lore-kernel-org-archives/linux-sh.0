From: Zhaolei <zhaolei@cn.fujitsu.com>
Date: Fri, 17 Oct 2008 11:25:09 +0000
Subject: [PATCH] Fix debugfs_create_file's error checking method for arch/sh/mm/
Message-Id: <48F87615.60302@cn.fujitsu.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

debugfs_create_file() returns NULL if an error occurs, returns -ENODEV
when debugfs is not enabled in the kernel.

Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
---
 arch/sh/mm/cache-debugfs.c |    6 ++++++
 arch/sh/mm/pmb.c           |    2 ++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/sh/mm/cache-debugfs.c b/arch/sh/mm/cache-debugfs.c
index 0e189cc..5ba067b 100644
--- a/arch/sh/mm/cache-debugfs.c
+++ b/arch/sh/mm/cache-debugfs.c
@@ -130,12 +130,18 @@ static int __init cache_debugfs_init(void)
 	dcache_dentry = debugfs_create_file("dcache", S_IRUSR, sh_debugfs_root,
 					    (unsigned int *)CACHE_TYPE_DCACHE,
 					    &cache_debugfs_fops);
+	if (!dcache_dentry)
+		return -ENOMEM;
 	if (IS_ERR(dcache_dentry))
 		return PTR_ERR(dcache_dentry);
 
 	icache_dentry = debugfs_create_file("icache", S_IRUSR, sh_debugfs_root,
 					    (unsigned int *)CACHE_TYPE_ICACHE,
 					    &cache_debugfs_fops);
+	if (!icache_dentry) {
+		debugfs_remove(dcache_dentry);
+		return -ENOMEM;
+	}
 	if (IS_ERR(icache_dentry)) {
 		debugfs_remove(dcache_dentry);
 		return PTR_ERR(icache_dentry);
diff --git a/arch/sh/mm/pmb.c b/arch/sh/mm/pmb.c
index cef7276..8424167 100644
--- a/arch/sh/mm/pmb.c
+++ b/arch/sh/mm/pmb.c
@@ -394,6 +394,8 @@ static int __init pmb_debugfs_init(void)
 
 	dentry = debugfs_create_file("pmb", S_IFREG | S_IRUGO,
 				     sh_debugfs_root, NULL, &pmb_debugfs_fops);
+	if (!dentry)
+		return -ENOMEM;
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
-- 
1.5.5.3


