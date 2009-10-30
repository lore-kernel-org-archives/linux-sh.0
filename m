From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 30 Oct 2009 04:24:15 +0000
Subject: [PATCH 05/09] sh: Keep track of allowed sleep modes
Message-Id: <20091030042415.11783.76330.sendpatchset@rxone.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Add code to keep track of supported sleep modes. This to
only export cpuidle modes that are backed by board support
code. Also, do not allow suspend-to-ram if sdram board code
is missing.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/include/asm/suspend.h         |    3 ++
 arch/sh/kernel/cpu/shmobile/cpuidle.c |   42 ++++++++++++++++++---------------
 arch/sh/kernel/cpu/shmobile/pm.c      |    7 +++++
 3 files changed, 34 insertions(+), 18 deletions(-)

--- 0011/arch/sh/include/asm/suspend.h
+++ work/arch/sh/include/asm/suspend.h	2009-10-28 19:16:48.000000000 +0900
@@ -49,6 +49,9 @@ struct sh_sleep_data {
 	unsigned long sr;
 };
 
+/* a bitmap of supported sleep modes (SUSP_SH..) */
+extern unsigned long sh_mobile_sleep_supported;
+
 #endif
 
 /* flags passed to assembly suspend code */
--- 0001/arch/sh/kernel/cpu/shmobile/cpuidle.c
+++ work/arch/sh/kernel/cpu/shmobile/cpuidle.c	2009-10-28 19:22:28.000000000 +0900
@@ -87,25 +87,31 @@ void sh_mobile_setup_cpuidle(void)
 
 	dev->safe_state = state;
 
-	state = &dev->states[i++];
-	snprintf(state->name, CPUIDLE_NAME_LEN, "C1");
-	strncpy(state->desc, "SuperH Sleep Mode [SF]", CPUIDLE_DESC_LEN);
-	state->exit_latency = 100;
-	state->target_residency = 1 * 2;
-	state->power_usage = 1;
-	state->flags = 0;
-	state->flags |= CPUIDLE_FLAG_TIME_VALID;
-	state->enter = cpuidle_sleep_enter;
+	if (sh_mobile_sleep_supported & SUSP_SH_SF) {
+		state = &dev->states[i++];
+		snprintf(state->name, CPUIDLE_NAME_LEN, "C1");
+		strncpy(state->desc, "SuperH Sleep Mode [SF]",
+			CPUIDLE_DESC_LEN);
+		state->exit_latency = 100;
+		state->target_residency = 1 * 2;
+		state->power_usage = 1;
+		state->flags = 0;
+		state->flags |= CPUIDLE_FLAG_TIME_VALID;
+		state->enter = cpuidle_sleep_enter;
+	}
 
-	state = &dev->states[i++];
-	snprintf(state->name, CPUIDLE_NAME_LEN, "C2");
-	strncpy(state->desc, "SuperH Mobile Standby Mode [SF]", CPUIDLE_DESC_LEN);
-	state->exit_latency = 2300;
-	state->target_residency = 1 * 2;
-	state->power_usage = 1;
-	state->flags = 0;
-	state->flags |= CPUIDLE_FLAG_TIME_VALID;
-	state->enter = cpuidle_sleep_enter;
+	if (sh_mobile_sleep_supported & SUSP_SH_STANDBY) {
+		state = &dev->states[i++];
+		snprintf(state->name, CPUIDLE_NAME_LEN, "C2");
+		strncpy(state->desc, "SuperH Mobile Standby Mode [SF]",
+			CPUIDLE_DESC_LEN);
+		state->exit_latency = 2300;
+		state->target_residency = 1 * 2;
+		state->power_usage = 1;
+		state->flags = 0;
+		state->flags |= CPUIDLE_FLAG_TIME_VALID;
+		state->enter = cpuidle_sleep_enter;
+	}
 
 	dev->state_count = i;
 
--- 0011/arch/sh/kernel/cpu/shmobile/pm.c
+++ work/arch/sh/kernel/cpu/shmobile/pm.c	2009-10-28 19:18:57.000000000 +0900
@@ -70,6 +70,8 @@ extern const char sh_mobile_sleep_enter_
 extern const char sh_mobile_sleep_resume_start;
 extern const char sh_mobile_sleep_resume_end;
 
+unsigned long sh_mobile_sleep_supported = SUSP_SH_SLEEP;
+
 void sh_mobile_register_self_refresh(unsigned long flags,
 				     void *pre_start, void *pre_end,
 				     void *post_start, void *post_end)
@@ -105,10 +107,15 @@ void sh_mobile_register_self_refresh(uns
 	vp = onchip_mem + 0x600; /* located at interrupt vector */
 	n = &sh_mobile_sleep_resume_end - &sh_mobile_sleep_resume_start;
 	memcpy(vp, &sh_mobile_sleep_resume_start, n);
+
+	sh_mobile_sleep_supported |= flags;
 }
 
 static int sh_pm_enter(suspend_state_t state)
 {
+	if (!(sh_mobile_sleep_supported & SUSP_MODE_STANDBY_SF))
+		return -ENXIO;
+
 	local_irq_disable();
 	set_bl_bit();
 	sh_mobile_call_standby(SUSP_MODE_STANDBY_SF);
