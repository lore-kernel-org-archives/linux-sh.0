From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 29 Oct 2009 10:52:06 +0000
Subject: [PATCH 04/07] sh: Allow boards to register memory pre/post sleep code
Message-Id: <20091029105206.29078.85084.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add code to allow boards registering self-contained
functions for going to/from self-refresh. At this
point the board code is unused. When all supported
boards have been converted then the new sleep code
will make use of these functions.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/suspend.h    |    4 ++++
 arch/sh/kernel/cpu/shmobile/pm.c |    6 ++++++
 2 files changed, 10 insertions(+)

--- 0008/arch/sh/include/asm/suspend.h
+++ work/arch/sh/include/asm/suspend.h	2009-10-28 18:44:53.000000000 +0900
@@ -30,6 +30,10 @@ extern struct atomic_notifier_head sh_mo
 #define SH_MOBILE_PRE(x)	(x)
 #define SH_MOBILE_POST(x)	(-(x))
 
+/* board code registration function for self-refresh assembly snippets */
+void sh_mobile_register_self_refresh(unsigned long flags,
+				     void *pre_start, void *pre_end,
+				     void *post_start, void *post_end);
 #endif
 
 /* flags passed to assembly suspend code */
--- 0008/arch/sh/kernel/cpu/shmobile/pm.c
+++ work/arch/sh/kernel/cpu/shmobile/pm.c	2009-10-28 18:44:53.000000000 +0900
@@ -60,6 +60,12 @@ void sh_mobile_call_standby(unsigned lon
 				   mode, NULL);
 }
 
+void sh_mobile_register_self_refresh(unsigned long flags,
+				     void *pre_start, void *pre_end,
+				     void *post_start, void *post_end)
+{
+}
+
 static int sh_pm_enter(suspend_state_t state)
 {
 	local_irq_disable();
