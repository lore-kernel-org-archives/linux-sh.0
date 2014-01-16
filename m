From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Jan 2014 22:20:00 +0000
Subject: [PATCH] sh: kgdb: Add missing #include <linux/sched.h>
Message-Id: <1389910800-13083-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Wanlong Gao <gaowanlong@cn.fujitsu.com>, Geert Uytterhoeven <geert+renesas@linux-m68k.org>

From: Wanlong Gao <gaowanlong@cn.fujitsu.com>

arch/sh/kernel/kgdb.c: In function 'sleeping_thread_to_gdb_regs':
arch/sh/kernel/kgdb.c:225:32: error: implicit declaration of function 'task_stack_page' [-Werror=implicit-function-declaration]
arch/sh/kernel/kgdb.c:242:23: error: dereferencing pointer to incomplete type
arch/sh/kernel/kgdb.c:243:22: error: dereferencing pointer to incomplete type
arch/sh/kernel/kgdb.c: In function 'singlestep_trap_handler':
arch/sh/kernel/kgdb.c:310:27: error: 'SIGTRAP' undeclared (first use in this function)
arch/sh/kernel/kgdb.c:310:27: note: each undeclared identifier is reported only once for each function it appears in

This is introduced by commit 16559ae48c76f1ceb970b9719dea62b77eb5d06b
("kgdb: remove #include <linux/serial_8250.h> from kgdb.h").

Reported-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
[geert: Reworded and reformatted]
Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
http://kisskb.ellerman.id.au/kisskb/buildresult/10477672/

 arch/sh/kernel/kgdb.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/kernel/kgdb.c b/arch/sh/kernel/kgdb.c
index 38b313909ac9..adad46e41a1d 100644
--- a/arch/sh/kernel/kgdb.c
+++ b/arch/sh/kernel/kgdb.c
@@ -13,6 +13,7 @@
 #include <linux/kdebug.h>
 #include <linux/irq.h>
 #include <linux/io.h>
+#include <linux/sched.h>
 #include <asm/cacheflush.h>
 #include <asm/traps.h>
 
-- 
1.7.9.5

