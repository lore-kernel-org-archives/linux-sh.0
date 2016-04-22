From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Fri, 22 Apr 2016 18:07:02 +0000
Subject: [PATCH 2/4] sh: make mm/asids-debugfs explicitly non-modular
Message-Id: <1461348424-3896-3-git-send-email-paul.gortmaker@windriver.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1461348424-3896-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1461348424-3896-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

The Makefile/Kconfig currently controlling compilation of this code is:

obj-$(CONFIG_DEBUG_FS)          += $(debugfs-y)
debugfs-y                       := asids-debugfs.o

lib/Kconfig.debug:config DEBUG_FS
lib/Kconfig.debug:      bool "Debug Filesystem"

...meaning that it currently is not being built as a module by anyone.

Lets remove the couple traces of modular code, so that when reading the
driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/sh/mm/asids-debugfs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/sh/mm/asids-debugfs.c b/arch/sh/mm/asids-debugfs.c
index ecfc6b0c1da1..bf95fdaedd0c 100644
--- a/arch/sh/mm/asids-debugfs.c
+++ b/arch/sh/mm/asids-debugfs.c
@@ -17,7 +17,6 @@
  * for more details.
  */
 #include <linux/init.h>
-#include <linux/module.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
 #include <linux/spinlock.h>
@@ -70,6 +69,4 @@ static int __init asids_debugfs_init(void)
 
 	return PTR_ERR_OR_ZERO(asids_dentry);
 }
-module_init(asids_debugfs_init);
-
-MODULE_LICENSE("GPL v2");
+device_initcall(asids_debugfs_init);
-- 
2.8.0

