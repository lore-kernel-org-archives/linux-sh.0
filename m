From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 14 Apr 2011 06:01:33 +0000
Subject: [PATCH 3/5] x86: convert to asm-generic ptrace.h
Message-Id: <1302760895-13459-4-git-send-email-vapier@gentoo.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1302760895-13459-1-git-send-email-vapier@gentoo.org>
In-Reply-To: <1302760895-13459-1-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roland McGrath <roland@redhat.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, Jason Wessel <jason.wessel@windriver.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 arch/x86/include/asm/ptrace.h |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/ptrace.h b/arch/x86/include/asm/ptrace.h
index 78cd1ea..98a5e97 100644
--- a/arch/x86/include/asm/ptrace.h
+++ b/arch/x86/include/asm/ptrace.h
@@ -136,6 +136,7 @@ struct cpuinfo_x86;
 struct task_struct;
 
 extern unsigned long profile_pc(struct pt_regs *regs);
+#define profile_pc profile_pc
 
 extern unsigned long
 convert_ip_to_linear(struct task_struct *child, struct pt_regs *regs);
@@ -202,20 +203,11 @@ static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
 #endif
 }
 
-static inline unsigned long instruction_pointer(struct pt_regs *regs)
-{
-	return regs->ip;
-}
-
-static inline unsigned long frame_pointer(struct pt_regs *regs)
-{
-	return regs->bp;
-}
+#define GET_IP(regs) ((regs)->ip)
+#define GET_FP(regs) ((regs)->bp)
+#define GET_USP(regs) ((regs)->sp)
 
-static inline unsigned long user_stack_pointer(struct pt_regs *regs)
-{
-	return regs->sp;
-}
+#include <asm-generic/ptrace.h>
 
 /* Query offset/name of register from its name/offset */
 extern int regs_query_register_offset(const char *name);
-- 
1.7.5.rc1

