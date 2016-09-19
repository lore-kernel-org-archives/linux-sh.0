From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 19 Sep 2016 22:03:35 +0000
Subject: [PATCH] sh: migrate exception table users off module.h and onto extable.h
Message-Id: <20160919220335.5974-1-paul.gortmaker@windriver.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org

These files were only including module.h for exception table
related functions.  We've now separated that content out into its
own file "extable.h" so now move over to that and avoid all the
extra header content in module.h that we don't really need to compile
these files.

One uses "print_modules" so that prevents us removing module.h in
that case, however.

We also delete a duplicate prototype that doesn't need to exist, as
it duplicates content in extable.h

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[see: https://lkml.org/lkml/2016/7/24/224 for additional context if needed]


 arch/sh/include/asm/uaccess.h | 1 -
 arch/sh/kernel/kprobes.c      | 2 +-
 arch/sh/kernel/traps.c        | 3 ++-
 arch/sh/mm/extable_32.c       | 2 +-
 arch/sh/mm/extable_64.c       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sh/include/asm/uaccess.h b/arch/sh/include/asm/uaccess.h
index a49635c51266..94746c806ffc 100644
--- a/arch/sh/include/asm/uaccess.h
+++ b/arch/sh/include/asm/uaccess.h
@@ -191,7 +191,6 @@ struct exception_table_entry {
 int fixup_exception(struct pt_regs *regs);
 /* Returns 0 if exception not found and fixup.unit otherwise.  */
 unsigned long search_exception_table(unsigned long addr);
-const struct exception_table_entry *search_exception_tables(unsigned long addr);
 
 extern void *set_exception_table_vec(unsigned int vec, void *handler);
 
diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index 83acbf3f6de8..5999df326b43 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -9,7 +9,7 @@
  * for more details.
  */
 #include <linux/kprobes.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/ptrace.h>
 #include <linux/preempt.h>
 #include <linux/kdebug.h>
diff --git a/arch/sh/kernel/traps.c b/arch/sh/kernel/traps.c
index dfdad72c61ca..9513fa7840aa 100644
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -8,7 +8,8 @@
 #include <linux/hardirq.h>
 #include <linux/kernel.h>
 #include <linux/kexec.h>
-#include <linux/module.h>
+#include <linux/extable.h>
+#include <linux/module.h>	/* print_modules */
 #include <asm/unwinder.h>
 #include <asm/traps.h>
 
diff --git a/arch/sh/mm/extable_32.c b/arch/sh/mm/extable_32.c
index c1cf4463d09d..f73d9927805f 100644
--- a/arch/sh/mm/extable_32.c
+++ b/arch/sh/mm/extable_32.c
@@ -4,7 +4,7 @@
  *   linux/arch/i386/mm/extable.c
  */
 
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <asm/uaccess.h>
 
 int fixup_exception(struct pt_regs *regs)
diff --git a/arch/sh/mm/extable_64.c b/arch/sh/mm/extable_64.c
index f05499688d88..f8de5289d119 100644
--- a/arch/sh/mm/extable_64.c
+++ b/arch/sh/mm/extable_64.c
@@ -11,7 +11,7 @@
  * for more details.
  */
 #include <linux/rwsem.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <asm/uaccess.h>
 
 extern unsigned long copy_user_memcpy, copy_user_memcpy_end;
-- 
2.8.4

