From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Sun, 08 Oct 2017 16:10:10 +0000
Subject: [PATCH 09/12] sh: intc: replace <linux/radix-tree.h> with <linux/radix-tree-root.h>
Message-Id: <1507479013-5207-10-git-send-email-yamada.masahiro@socionext.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1507479013-5207-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1507479013-5207-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, Ian Abbott <abbotti@mev.co.uk>, Ingo Molnar <mingo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

This header requires the definition of struct radix_tree_root, but
does not need to know anything about other radix tree stuff.

Include <linux/radix-tree-root.h> instead of <linux/radix-tree.h> to
reduce the header dependency.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/sh/intc/internals.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sh/intc/internals.h b/drivers/sh/intc/internals.h
index 6ce7f0d..4021c1c 100644
--- a/drivers/sh/intc/internals.h
+++ b/drivers/sh/intc/internals.h
@@ -4,7 +4,7 @@
 #include <linux/list.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/radix-tree.h>
+#include <linux/radix-tree-root.h>
 #include <linux/device.h>
 
 #define _INTC_MK(fn, mode, addr_e, addr_d, width, shift) \
-- 
2.7.4

