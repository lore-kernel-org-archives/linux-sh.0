From: Peter Griffin <pgriffin@mpc-data.co.uk>
Date: Fri, 08 May 2009 14:50:54 +0000
Subject: [PATCH] Add ptrace support for NOMMU debugging
Message-Id: <1241794254.16311.32.camel@quercus-bis>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From 2652ec6503dbe78e5bf371b77544e168166aa57d Mon Sep 17 00:00:00 2001
From: Peter Griffin <pgriffin@mpc-data.co.uk>
Date: Fri, 8 May 2009 15:01:21 +0100
Subject: [PATCH] Add ptrace support for NOMMU debugging


Signed-off-by: Peter Griffin <pgriffin@mpc-data.co.uk>
---
 arch/sh/kernel/ptrace_32.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index f7b22dd..28aa86f 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -33,6 +33,7 @@
 #include <asm/mmu_context.h>
 #include <asm/syscalls.h>
 #include <asm/fpu.h>
+#include <asm/asm-offsets.h>
 
 /*
  * This routine will get a word off of the process kernel stack.
@@ -334,6 +335,14 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 					[(addr - (long)&dummy->fpu) >> 2];
 		} else if (addr = (long) &dummy->u_fpvalid)
 			tmp = !!tsk_used_math(child);
+		else if ( addr = PT_TEXT_ADDR)
+			tmp = child->mm->start_code;
+		else if ( addr = PT_DATA_ADDR)
+			tmp = child->mm->start_data;
+		else if ( addr = PT_TEXT_END_ADDR )
+			tmp = child->mm->end_code;
+		else if ( addr = PT_TEXT_LEN )
+			tmp = child->mm->end_code - child->mm->start_code;
 		else
 			tmp = 0;
 		ret = put_user(tmp, datap);
-- 
1.5.6.3



