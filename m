From: Roel Kluin <roel.kluin@gmail.com>
Date: Wed, 21 Jan 2009 14:48:26 +0000
Subject: [PATCH] SH: fix user_stack_pointer macros
Message-Id: <497735BA.4060201@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When these macros aren't called with regs, e.g. with foo
this will incorectly expand to foo->foo[*].

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/arch/sh/include/asm/kprobes.h b/arch/sh/include/asm/kprobes.h
index 6078d8e..a90b6df 100644
--- a/arch/sh/include/asm/kprobes.h
+++ b/arch/sh/include/asm/kprobes.h
@@ -16,7 +16,7 @@ typedef u16 kprobe_opcode_t;
 	? (MAX_STACK_SIZE) \
 	: (((unsigned long)current_thread_info()) + THREAD_SIZE - (ADDR)))
 
-#define regs_return_value(regs)		((regs)->regs[0])
+#define regs_return_value(x)		((x)->regs[0])
 #define flush_insn_slot(p)		do { } while (0)
 #define kretprobe_blacklist_size	0
 
diff --git a/arch/sh/include/asm/processor_32.h b/arch/sh/include/asm/processor_32.h
index d79063c..5d7d4e3 100644
--- a/arch/sh/include/asm/processor_32.h
+++ b/arch/sh/include/asm/processor_32.h
@@ -189,7 +189,7 @@ extern unsigned long get_wchan(struct task_struct *p);
 #define KSTK_EIP(tsk)  (task_pt_regs(tsk)->pc)
 #define KSTK_ESP(tsk)  (task_pt_regs(tsk)->regs[15])
 
-#define user_stack_pointer(regs)	((regs)->regs[15])
+#define user_stack_pointer(x)	((x)->regs[15])
 
 #if defined(CONFIG_CPU_SH2A) || defined(CONFIG_CPU_SH3) || \
     defined(CONFIG_CPU_SH4)
diff --git a/arch/sh/include/asm/processor_64.h b/arch/sh/include/asm/processor_64.h
index 803177f..beb62ea 100644
--- a/arch/sh/include/asm/processor_64.h
+++ b/arch/sh/include/asm/processor_64.h
@@ -226,7 +226,7 @@ extern unsigned long get_wchan(struct task_struct *p);
 #define KSTK_EIP(tsk)  ((tsk)->thread.pc)
 #define KSTK_ESP(tsk)  ((tsk)->thread.sp)
 
-#define user_stack_pointer(regs)	((regs)->regs[15])
+#define user_stack_pointer(x)	((x)->regs[15])
 
 #endif	/* __ASSEMBLY__ */
 #endif /* __ASM_SH_PROCESSOR_64_H */
