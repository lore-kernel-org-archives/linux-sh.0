From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Date: Sun, 06 Dec 2015 09:42:22 +0000
Subject: [PATCH 01/10] sh: Replace "hweight_long(flags) != 1" with "!is_power_of_2(flags)"
Message-Id: <1449394942-13964-1-git-send-email-zhaoxiu.zeng@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>

From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
---
 arch/sh/kernel/io_trapped.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sh/kernel/io_trapped.c b/arch/sh/kernel/io_trapped.c
index f8ce362..d8f32bf 100644
--- a/arch/sh/kernel/io_trapped.c
+++ b/arch/sh/kernel/io_trapped.c
@@ -15,6 +15,7 @@
 #include <linux/vmalloc.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/log2.h>
 #include <asm/mmu_context.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
@@ -62,7 +63,7 @@ int register_trapped_io(struct trapped_io *tiop)
 	}
 
 	/* support IORESOURCE_IO _or_ MEM, not both */
-	if (hweight_long(flags) != 1)
+	if (!is_power_of_2(flags))
 		goto bad;
 
 	n = len >> PAGE_SHIFT;
-- 
2.5.0

