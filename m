From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 17 Jun 2020 14:36:32 +0000
Subject: [PATCH v2 2/9] Revert "sh: add loglvl to printk_address()"
Message-Id: <20200617143639.18315-3-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200617143639.18315-1-geert+renesas@glider.be>
In-Reply-To: <20200617143639.18315-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Guenter Roeck <linux@roeck-us.net>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

This reverts commit 2deebe4d56d638269a4a728086d64de5734b460a.

printk_address() is always used as a continuation of the previous
logging, hence it should not include a log level.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 arch/sh/include/asm/kdebug.h | 3 +--
 arch/sh/kernel/dumpstack.c   | 6 +++---
 arch/sh/mm/fault.c           | 2 +-
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/sh/include/asm/kdebug.h b/arch/sh/include/asm/kdebug.h
index 960545306afa4d93..de8693fabb1d95b5 100644
--- a/arch/sh/include/asm/kdebug.h
+++ b/arch/sh/include/asm/kdebug.h
@@ -12,8 +12,7 @@ enum die_val {
 };
 
 /* arch/sh/kernel/dumpstack.c */
-extern void printk_address(unsigned long address, int reliable,
-			   const char *loglvl);
+extern void printk_address(unsigned long address, int reliable);
 extern void dump_mem(const char *str, const char *loglvl,
 		     unsigned long bottom, unsigned long top);
 
diff --git a/arch/sh/kernel/dumpstack.c b/arch/sh/kernel/dumpstack.c
index a13c045804ed1027..ad548fc976350c50 100644
--- a/arch/sh/kernel/dumpstack.c
+++ b/arch/sh/kernel/dumpstack.c
@@ -44,9 +44,9 @@ void dump_mem(const char *str, const char *loglvl,
 	}
 }
 
-void printk_address(unsigned long address, int reliable, const char *loglvl)
+void printk_address(unsigned long address, int reliable)
 {
-	printk("%s [<%p>] %s%pS\n", loglvl, (void *) address,
+	printk(" [<%p>] %s%pS\n", (void *) address,
 			reliable ? "" : "? ", (void *) address);
 }
 
@@ -118,7 +118,7 @@ static int print_trace_stack(void *data, char *name)
  */
 static void print_trace_address(void *data, unsigned long addr, int reliable)
 {
-	printk_address(addr, reliable, (char *)data);
+	printk_address(addr, reliable);
 }
 
 static const struct stacktrace_ops print_trace_ops = {
diff --git a/arch/sh/mm/fault.c b/arch/sh/mm/fault.c
index acd1c75994983825..92b1ce105f4b6c6f 100644
--- a/arch/sh/mm/fault.c
+++ b/arch/sh/mm/fault.c
@@ -213,7 +213,7 @@ show_fault_oops(struct pt_regs *regs, unsigned long address)
 				     : "paging request",
 		 address);
 	pr_alert("PC:");
-	printk_address(regs->pc, 1, KERN_ALERT);
+	printk_address(regs->pc, 1);
 
 	show_pte(NULL, address);
 }
-- 
2.17.1
