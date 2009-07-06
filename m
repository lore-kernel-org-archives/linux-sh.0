From: Matt Fleming <matt@console-pimps.org>
Date: Mon, 06 Jul 2009 10:32:41 +0000
Subject: [PATCH 1/3] sh: Fix the value of MCOUNT_INSN_OFFSET
Message-Id: <441c5c048cf9a9884e0b0d0af90a6f17f846a3bb.1246875978.git.matt@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It seems that MCOUNT_INSN_OFFSET was calculating the distance between
the wrong functions. The value that should have actually been computed
is the distance between ftrace_call and ftrace_stub. I discovered this
when I added some code to ftrace_caller.

Signed-off-by: Matt Fleming <matt@console-pimps.org>
---
 arch/sh/include/asm/ftrace.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/ftrace.h b/arch/sh/include/asm/ftrace.h
index 8fea7d8..b09311a 100644
--- a/arch/sh/include/asm/ftrace.h
+++ b/arch/sh/include/asm/ftrace.h
@@ -11,10 +11,10 @@ extern void mcount(void);
 #define MCOUNT_ADDR		((long)(mcount))
 
 #ifdef CONFIG_DYNAMIC_FTRACE
-#define CALLER_ADDR		((long)(ftrace_caller))
+#define CALL_ADDR		((long)(ftrace_call))
 #define STUB_ADDR		((long)(ftrace_stub))
 
-#define MCOUNT_INSN_OFFSET	((STUB_ADDR - CALLER_ADDR) >> 1)
+#define MCOUNT_INSN_OFFSET	((STUB_ADDR - CALL_ADDR) - 4)
 
 struct dyn_arch_ftrace {
 	/* No extra data needed on sh */
-- 
1.6.3.2.316.gda4e

