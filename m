From: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 04 Apr 2012 02:16:09 +0000
Subject: [PATCH] sh: fix build error in fpu.c
Message-Id: <4F7BAEE9.7020401@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

This patch fixes the following build error:

  CC      arch/sh/kernel/cpu/sh4/fpu.o
arch/sh/kernel/cpu/sh4/fpu.c:405: warning: return type defaults to ‘int’
arch/sh/kernel/cpu/sh4/fpu.c:405: warning: function declaration isn’t a prototype
arch/sh/kernel/cpu/sh4/fpu.c: In function ‘BUILD_TRAP_HANDLER’:
arch/sh/kernel/cpu/sh4/fpu.c:407: error: ‘TRAP_HANDLER_DECL’ undeclared (first use in this function)
arch/sh/kernel/cpu/sh4/fpu.c:407: error: (Each undeclared identifier is reported only once
arch/sh/kernel/cpu/sh4/fpu.c:407: error: for each function it appears in.)
arch/sh/kernel/cpu/sh4/fpu.c:409: error: ‘regs’ undeclared (first use in this function)
arch/sh/kernel/cpu/sh4/fpu.c:423: warning: ‘return’ with no value, in function returning non-void
  CC      arch/sh/kernel/cpu/fpu.o
arch/sh/kernel/cpu/fpu.c:80: warning: return type defaults to ‘int’
arch/sh/kernel/cpu/fpu.c:80: warning: function declaration isn’t a prototype
arch/sh/kernel/cpu/fpu.c: In function ‘BUILD_TRAP_HANDLER’:
arch/sh/kernel/cpu/fpu.c:81: error: ‘TRAP_HANDLER_DECL’ undeclared (first use in this function)
arch/sh/kernel/cpu/fpu.c:81: error: (Each undeclared identifier is reported only once
arch/sh/kernel/cpu/fpu.c:81: error: for each function it appears in.)
arch/sh/kernel/cpu/fpu.c:83: error: ‘regs’ undeclared (first use in this function)
arch/sh/kernel/cpu/fpu.c:83: error: called object ‘fpu_state_restore’ is not a function

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/kernel/cpu/fpu.c     |    1 +
 arch/sh/kernel/cpu/sh4/fpu.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/fpu.c b/arch/sh/kernel/cpu/fpu.c
index 7f1b70c..f8f7af5 100644
--- a/arch/sh/kernel/cpu/fpu.c
+++ b/arch/sh/kernel/cpu/fpu.c
@@ -2,6 +2,7 @@
 #include <linux/slab.h>
 #include <asm/processor.h>
 #include <asm/fpu.h>
+#include <asm/traps.h>

 int init_fpu(struct task_struct *tsk)
 {
diff --git a/arch/sh/kernel/cpu/sh4/fpu.c b/arch/sh/kernel/cpu/sh4/fpu.c
index e74cd6c..69ab4d3 100644
--- a/arch/sh/kernel/cpu/sh4/fpu.c
+++ b/arch/sh/kernel/cpu/sh4/fpu.c
@@ -16,6 +16,7 @@
 #include <cpu/fpu.h>
 #include <asm/processor.h>
 #include <asm/fpu.h>
+#include <asm/traps.h>

 /* The PR (precision) bit in the FP Status Register must be clear when
  * an frchg instruction is executed, otherwise the instruction is undefined.
-- 
1.7.1
