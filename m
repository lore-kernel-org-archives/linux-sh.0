From: Jeffrey Merkey <jeffmerkey@gmail.com>
Date: Thu, 28 Jan 2016 19:47:24 +0000
Subject: [PATCH 23/31] Add debugger entry points for SH
Message-Id: <1454010444-29349-1-git-send-email-jeffmerkey@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: ysato@users.sourceforge.jp, dalias@libc.org, linux.mdb@gmail.com, linux-sh@vger.kernel.org

This patch series adds an export which can be set by system debuggers to
direct the hard lockup and soft lockup detector to trigger a breakpoint
exception and enter a debugger if one is active.  It is assumed that if
someone sets this variable, then an breakpoint handler of some sort will
be actively loaded or registered via the notify die handler chain.

This addition is extremely useful for debugging hard and soft lockups
real time and quickly from a console debugger.

Signed-off-by: Jeffrey Merkey <jeffmerkey@gmail.com>
---
 arch/sh/include/asm/kdebug.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/sh/include/asm/kdebug.h b/arch/sh/include/asm/kdebug.h
index 8d6a831..468d17e 100644
--- a/arch/sh/include/asm/kdebug.h
+++ b/arch/sh/include/asm/kdebug.h
@@ -14,4 +14,9 @@ enum die_val {
 extern void printk_address(unsigned long address, int reliable);
 extern void dump_mem(const char *str, unsigned long bottom, unsigned long top);
 
+static inline void arch_breakpoint(void)
+{
+	__asm__ __volatile__ ("trapa #0x3c\n");
+}
+
 #endif /* __ASM_SH_KDEBUG_H */
-- 
1.8.3.1

