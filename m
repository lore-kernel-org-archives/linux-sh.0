From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Tue, 15 Oct 2019 19:18:05 +0000
Subject: [PATCH 18/34] sh: Use CONFIG_PREEMPTION
Message-Id: <20191015191821.11479-19-bigeasy@linutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the entry code over to use CONFIG_PREEMPTION.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: +Kconfig]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/sh/Kconfig                | 2 +-
 arch/sh/kernel/cpu/sh5/entry.S | 4 ++--
 arch/sh/kernel/entry-common.S  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index f356ee674d89b..9ece111b02548 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -108,7 +108,7 @@ config GENERIC_CALIBRATE_DELAY
 
 config GENERIC_LOCKBREAK
 	def_bool y
-	depends on SMP && PREEMPT
+	depends on SMP && PREEMPTION
 
 config ARCH_SUSPEND_POSSIBLE
 	def_bool n
diff --git a/arch/sh/kernel/cpu/sh5/entry.S b/arch/sh/kernel/cpu/sh5/entry.S
index de68ffdfffbf5..81c8b64b977ff 100644
--- a/arch/sh/kernel/cpu/sh5/entry.S
+++ b/arch/sh/kernel/cpu/sh5/entry.S
@@ -86,7 +86,7 @@
 	andi	r6, ~0xf0, r6;		\
 	putcon	r6, SR;
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 #  define preempt_stop()	CLI()
 #else
 #  define preempt_stop()
@@ -884,7 +884,7 @@ LRESVEC_block_end:			/* Marker. Unused. */
 
 	/* Check softirqs */
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	pta   ret_from_syscall, tr0
 	blink   tr0, ZERO
 
diff --git a/arch/sh/kernel/entry-common.S b/arch/sh/kernel/entry-common.S
index d31f66e82ce51..956a7a03b0c83 100644
--- a/arch/sh/kernel/entry-common.S
+++ b/arch/sh/kernel/entry-common.S
@@ -41,7 +41,7 @@
  */
 #include <asm/dwarf.h>
 
-#if defined(CONFIG_PREEMPT)
+#if defined(CONFIG_PREEMPTION)
 #  define preempt_stop()	cli ; TRACE_IRQS_OFF
 #else
 #  define preempt_stop()
@@ -84,7 +84,7 @@ ENTRY(ret_from_irq)
 	get_current_thread_info r8, r0
 	bt	resume_kernel	! Yes, it's from kernel, go back soon
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	bra	resume_userspace
 	 nop
 ENTRY(resume_kernel)
-- 
2.23.0
