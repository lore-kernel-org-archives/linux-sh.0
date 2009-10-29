From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 29 Oct 2009 10:51:48 +0000
Subject: [PATCH 02/07] sh: Add notifiers chains for cpu/board code
Message-Id: <20091029105148.29078.19112.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

This patch adds atomic notifier chains for pre/post
sleep events. Useful for cpu code and boards that
need to save and restore register state before and
after entering a sleep mode.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/suspend.h    |   11 +++++++++++
 arch/sh/kernel/cpu/shmobile/pm.c |   12 ++++++++++++
 2 files changed, 23 insertions(+)

--- 0001/arch/sh/include/asm/suspend.h
+++ work/arch/sh/include/asm/suspend.h	2009-10-28 12:19:48.000000000 +0900
@@ -2,6 +2,7 @@
 #define _ASM_SH_SUSPEND_H
 
 #ifndef __ASSEMBLY__
+#include <linux/notifier.h>
 static inline int arch_prepare_suspend(void) { return 0; }
 
 #include <asm/ptrace.h>
@@ -19,6 +20,16 @@ void sh_mobile_setup_cpuidle(void);
 static inline void sh_mobile_setup_cpuidle(void) {}
 #endif
 
+/* notifier chains for pre/post sleep hooks */
+extern struct atomic_notifier_head sh_mobile_pre_sleep_notifier_list;
+extern struct atomic_notifier_head sh_mobile_post_sleep_notifier_list;
+
+/* priority levels for notifiers */
+#define SH_MOBILE_SLEEP_BOARD	0
+#define SH_MOBILE_SLEEP_CPU	1
+#define SH_MOBILE_PRE(x)	(x)
+#define SH_MOBILE_POST(x)	(-(x))
+
 #endif
 
 /* flags passed to assembly suspend code */
--- 0001/arch/sh/kernel/cpu/shmobile/pm.c
+++ work/arch/sh/kernel/cpu/shmobile/pm.c	2009-10-28 12:18:47.000000000 +0900
@@ -17,6 +17,12 @@
 #include <asm/uaccess.h>
 
 /*
+ * Notifier lists for pre/post sleep notification
+ */
+ATOMIC_NOTIFIER_HEAD(sh_mobile_pre_sleep_notifier_list);
+ATOMIC_NOTIFIER_HEAD(sh_mobile_post_sleep_notifier_list);
+
+/*
  * Sleep modes available on SuperH Mobile:
  *
  * Sleep mode is just plain "sleep" instruction
@@ -44,8 +50,14 @@ void sh_mobile_call_standby(unsigned lon
 	void *onchip_mem = (void *)ILRAM_BASE;
 	void (*standby_onchip_mem)(unsigned long, unsigned long) = onchip_mem;
 
+	atomic_notifier_call_chain(&sh_mobile_pre_sleep_notifier_list,
+				   mode, NULL);
+
 	/* Let assembly snippet in on-chip memory handle the rest */
 	standby_onchip_mem(mode, ILRAM_BASE);
+
+	atomic_notifier_call_chain(&sh_mobile_post_sleep_notifier_list,
+				   mode, NULL);
 }
 
 static int sh_pm_enter(suspend_state_t state)
