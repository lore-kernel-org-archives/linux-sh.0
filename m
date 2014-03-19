From: Eric Paris <eparis@redhat.com>
Date: Wed, 19 Mar 2014 22:04:00 +0000
Subject: [PATCH 1/4] SH: define syscall_get_arch() for superh
Message-Id: <1395266643-3139-1-git-send-email-eparis@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-audit@redhat.com
Cc: Eric Paris <eparis@redhat.com>, linux-sh@vger.kernel.org

This patch defines syscall_get_arch() for the superh platform.  It does
so in both syscall_32.h and syscall_64.h.  I'm not certain if the
implementation in syscall_64.h couldn't just be used in syscall.h as I
can't really track the setting of CONFIG_64BIT...

This way is safe, but we might be able to combine these if a superh
person were able to review...

Signed-off-by: Eric Paris <eparis@redhat.com>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/include/asm/syscall_32.h | 10 ++++++++++
 arch/sh/include/asm/syscall_64.h | 14 ++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/sh/include/asm/syscall_32.h b/arch/sh/include/asm/syscall_32.h
index 7d80df4..460e9c6 100644
--- a/arch/sh/include/asm/syscall_32.h
+++ b/arch/sh/include/asm/syscall_32.h
@@ -1,6 +1,7 @@
 #ifndef __ASM_SH_SYSCALL_32_H
 #define __ASM_SH_SYSCALL_32_H
 
+#include <uapi/linux/audit.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/err.h>
@@ -93,4 +94,13 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	}
 }
 
+static inline int syscall_get_arch(void)
+{
+	int arch = EM_SH;
+
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+		arch |= __AUDIT_ARCH_LE;
+#endif
+	return arch;
+}
 #endif /* __ASM_SH_SYSCALL_32_H */
diff --git a/arch/sh/include/asm/syscall_64.h b/arch/sh/include/asm/syscall_64.h
index c3561ca..e03e77d 100644
--- a/arch/sh/include/asm/syscall_64.h
+++ b/arch/sh/include/asm/syscall_64.h
@@ -1,6 +1,7 @@
 #ifndef __ASM_SH_SYSCALL_64_H
 #define __ASM_SH_SYSCALL_64_H
 
+#include <uapi/linux/audit.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <asm/ptrace.h>
@@ -61,4 +62,17 @@ static inline void syscall_set_arguments(struct task_struct *task,
 	memcpy(&regs->regs[2 + i], args, n * sizeof(args[0]));
 }
 
+static inline int syscall_get_arch(void)
+{
+	int arch = EM_SH;
+
+#ifdef CONFIG_64BIT
+	arch |= __AUDIT_ARCH_64BIT;
+#endif
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+	arch |= __AUDIT_ARCH_LE;
+#endif
+
+	return arch;
+}
 #endif /* __ASM_SH_SYSCALL_64_H */
-- 
1.8.5.3

