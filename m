From: Zhaolei <zhaolei@cn.fujitsu.com>
Date: Fri, 17 Oct 2008 11:25:03 +0000
Subject: [PATCH] Fix debugfs_create_dir's error checking method for arch/sh/kernel/
Message-Id: <48F8760F.4070909@cn.fujitsu.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org
Cc: linux-sh@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,

debugfs_create_dir() returns NULL if an error occurs, returns -ENODEV
when debugfs is not enabled in the kernel.

Signed-off-by: Zhao Lei <zhaolei@cn.fujitsu.com>
---
 arch/sh/kernel/setup.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
index de83205..c41c4dc 100644
--- a/arch/sh/kernel/setup.c
+++ b/arch/sh/kernel/setup.c
@@ -530,6 +530,8 @@ struct dentry *sh_debugfs_root;
 static int __init sh_debugfs_init(void)
 {
 	sh_debugfs_root = debugfs_create_dir("sh", NULL);
+	if (!sh_debugfs_root)
+		return -ENOMEM;
 	if (IS_ERR(sh_debugfs_root))
 		return PTR_ERR(sh_debugfs_root);
 
-- 
1.5.5.3


