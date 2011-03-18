From: Phil Edworthy <PHIL.EDWORTHY@renesas.com>
Date: Fri, 18 Mar 2011 14:16:31 +0000
Subject: [PATCH] sh: Fix ptrace fpu state initialisation
Message-Id: <1300457791-11485-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <AB12B32E73474741A2C5361C433A44DE02911887@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
In-Reply-To: <AB12B32E73474741A2C5361C433A44DE02911887@rte-ben-exch.RTE.ADWIN.RENESAS.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Commit 0ea820cf introduced the PTRACE_GETFPREGS/SETFPREGS cmds,
but gdb-server still accesses the FPU state using the
PTRACE_PEEKUSR/POKEUSR commands. In this case, xstate was not
initialised.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 arch/sh/kernel/ptrace_32.c |    6 ++++++
 arch/sh/kernel/ptrace_64.c |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index 90a15d2..b53664e 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -392,6 +392,9 @@ long arch_ptrace(struct task_struct *child, long request,
 					tmp = 0;
 			} else {
 				unsigned long index;
+				ret = init_fpu(child);
+				if (ret)
+					break;
 				index = addr - offsetof(struct user, fpu);
 				tmp = ((unsigned long *)child->thread.xstate)
 					[index >> 2];
@@ -423,6 +426,9 @@ long arch_ptrace(struct task_struct *child, long request,
 		else if (addr >= offsetof(struct user, fpu) &&
 			 addr < offsetof(struct user, u_fpvalid)) {
 			unsigned long index;
+			ret = init_fpu(child);
+			if (ret)
+				break;
 			index = addr - offsetof(struct user, fpu);
 			set_stopped_child_used_math(child);
 			((unsigned long *)child->thread.xstate)
diff --git a/arch/sh/kernel/ptrace_64.c b/arch/sh/kernel/ptrace_64.c
index 4436eac..c8f9764 100644
--- a/arch/sh/kernel/ptrace_64.c
+++ b/arch/sh/kernel/ptrace_64.c
@@ -403,6 +403,9 @@ long arch_ptrace(struct task_struct *child, long request,
 		else if ((addr >= offsetof(struct user, fpu)) &&
 			 (addr <  offsetof(struct user, u_fpvalid))) {
 			unsigned long index;
+			ret = init_fpu(child);
+			if (ret)
+				break;
 			index = addr - offsetof(struct user, fpu);
 			tmp = get_fpu_long(child, index);
 		} else if (addr = offsetof(struct user, u_fpvalid)) {
@@ -442,6 +445,9 @@ long arch_ptrace(struct task_struct *child, long request,
 		else if ((addr >= offsetof(struct user, fpu)) &&
 			 (addr <  offsetof(struct user, u_fpvalid))) {
 			unsigned long index;
+			ret = init_fpu(child);
+			if (ret)
+				break;
 			index = addr - offsetof(struct user, fpu);
 			ret = put_fpu_long(child, index, data);
 		}
-- 
1.7.1

