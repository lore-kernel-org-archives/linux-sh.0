From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 14 Apr 2011 06:01:34 +0000
Subject: [PATCH 4/5] sh: convert to asm-generic ptrace.h
Message-Id: <1302760895-13459-5-git-send-email-vapier@gentoo.org>
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
 arch/sh/include/asm/ptrace.h |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/ptrace.h b/arch/sh/include/asm/ptrace.h
index b219a08..3f2a6e7 100644
--- a/arch/sh/include/asm/ptrace.h
+++ b/arch/sh/include/asm/ptrace.h
@@ -40,9 +40,8 @@
 #include <asm/system.h>
 
 #define user_mode(regs)			(((regs)->sr & 0x40000000)=0)
-#define user_stack_pointer(_regs)	((unsigned long)(_regs)->regs[15])
 #define kernel_stack_pointer(_regs)	((unsigned long)(_regs)->regs[15])
-#define instruction_pointer(regs)	((unsigned long)(regs)->pc)
+#define GET_USP(regs) ((regs)->regs[15])
 
 #define arch_has_single_step()	(1)
 
@@ -137,6 +136,9 @@ static inline unsigned long profile_pc(struct pt_regs *regs)
 
 	return pc;
 }
+#define profile_pc profile_pc
+
+#include <asm-generic/ptrace.h>
 #endif /* __KERNEL__ */
 
 #endif /* __ASM_SH_PTRACE_H */
-- 
1.7.5.rc1

