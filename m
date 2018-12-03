From: "Dmitry V. Levin" <ldv@altlinux.org>
Date: Mon, 03 Dec 2018 03:18:04 +0000
Subject: [PATCH] sh: fix syscall_set_return_value()
Message-Id: <20181203031804.GD11573@altlinux.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>
Cc: Elvira Khabirova <lineprinter@altlinux.org>, Eugene Syromyatnikov <esyr@redhat.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

According to documentation in include/asm-generic/syscall.h,
if error argument of syscall_set_return_value() is nonzero,
it is a negated errno.

This change fixes syscall_set_return_value() implementation on sh
to match its own syscall_get_error(), the documentation, and other
architectures where error argument of syscall_set_return_value()
is non-positive.

Fixes: fb4f87a2f048b ("sh: Provide the asm/syscall.h interface, needed by tracehook.")
Fixes: 94e2fb3d3e1f4 ("sh: Provide asm/syscall.h for SH-5.")
Cc: stable@vger.kernel.org # v2.6.28+
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 arch/sh/include/asm/syscall_32.h | 5 +----
 arch/sh/include/asm/syscall_64.h | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/sh/include/asm/syscall_32.h b/arch/sh/include/asm/syscall_32.h
index 6e118799831c..5d636a3593d1 100644
--- a/arch/sh/include/asm/syscall_32.h
+++ b/arch/sh/include/asm/syscall_32.h
@@ -40,10 +40,7 @@ static inline void syscall_set_return_value(struct task_struct *task,
 					    struct pt_regs *regs,
 					    int error, long val)
 {
-	if (error)
-		regs->regs[0] = -error;
-	else
-		regs->regs[0] = val;
+	regs->regs[0] = error ?: val;
 }
 
 static inline void syscall_get_arguments(struct task_struct *task,
diff --git a/arch/sh/include/asm/syscall_64.h b/arch/sh/include/asm/syscall_64.h
index 43882580c7f9..799fe72316e2 100644
--- a/arch/sh/include/asm/syscall_64.h
+++ b/arch/sh/include/asm/syscall_64.h
@@ -39,10 +39,7 @@ static inline void syscall_set_return_value(struct task_struct *task,
 					    struct pt_regs *regs,
 					    int error, long val)
 {
-	if (error)
-		regs->regs[9] = -error;
-	else
-		regs->regs[9] = val;
+	regs->regs[9] = error ?: val;
 }
 
 static inline void syscall_get_arguments(struct task_struct *task,
-- 
ldv
