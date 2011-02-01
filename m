From: Phil Edworthy <PHIL.EDWORTHY@renesas.com>
Date: Tue, 01 Feb 2011 17:37:36 +0000
Subject: [PATCH] sh: Fix ptrace FPU state initialisation
Message-Id: <AB12B32E73474741A2C5361C433A44DE02911887@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

RFC:

Commit 0ea820cf introduced the PTRACE_GETFPREGS/SETFPREGS cmds,
but gdb-server still accesses the FPU state using the
PTRACE_PEEKUSR/POKEUSR commands. In this case, xstate was not
initialised. The patch below against 2.6.35 fixes this. I'll
rework this for head if it's ok.

However, should we still allow PEEKUSR/POKEUSR for FPU registers,
or should we return an error?

---
 arch/sh/kernel/ptrace_32.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index 6c4bbba..df0144c 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -363,9 +363,13 @@ long arch_ptrace(struct task_struct *child, long
request, long addr, long data)
 					tmp = FPSCR_INIT;
 				else
 					tmp = 0;
-			} else
+			} else {
+				ret = init_fpu(child);
+				if (ret)
+					break;
 				tmp = ((long *)child->thread.xstate)
 					[(addr - (long)&dummy->fpu) >> 2];
+			}
 		} else if (addr = (long) &dummy->u_fpvalid)
 			tmp = !!tsk_used_math(child);
 		else if (addr = PT_TEXT_ADDR)
@@ -392,6 +396,9 @@ long arch_ptrace(struct task_struct *child, long
request, long addr, long data)
 			ret = put_stack_long(child, addr, data);
 		else if (addr >= (long) &dummy->fpu &&
 			 addr < (long) &dummy->u_fpvalid) {
+			ret = init_fpu(child);
+			if (ret)
+				break;
 			set_stopped_child_used_math(child);
 			((long *)child->thread.xstate)
 				[(addr - (long)&dummy->fpu) >> 2] = data;
-- 
1.7.1
