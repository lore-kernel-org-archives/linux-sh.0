From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 17 Aug 2009 09:41:40 +0000
Subject: [PATCH] sh: SuperH Mobile Software Standby support for cpuidle
Message-Id: <20090817094140.9319.29113.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

This patch adds "SuperH Mobile Standby Mode [SF]" to the list
of cpuidle sleep modes. If the software latency requirements
from cpuidle are met together with fulfilled hardware
requirements then deep sleep modes can be entered.

Tested on sh7722 and sh7724 with "Sleep Mode", "Sleep Mode + SF"
and "Software Standby Mode + SF" together with a multimedia
work load and flood ping without packet drop.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/shmobile/cpuidle.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- 0003/arch/sh/kernel/cpu/shmobile/cpuidle.c
+++ work/arch/sh/kernel/cpu/shmobile/cpuidle.c	2009-07-01 16:25:32.000000000 +0900
@@ -21,6 +21,7 @@
 static unsigned long cpuidle_mode[] = {
 	SUSP_SH_SLEEP, /* regular sleep mode */
 	SUSP_SH_SLEEP | SUSP_SH_SF, /* sleep mode + self refresh */
+	SUSP_SH_STANDBY | SUSP_SH_SF, /* software standby mode + self refresh */
 };
 
 static int cpuidle_sleep_enter(struct cpuidle_device *dev,
@@ -96,6 +97,16 @@ void sh_mobile_setup_cpuidle(void)
 	state->flags |= CPUIDLE_FLAG_TIME_VALID;
 	state->enter = cpuidle_sleep_enter;
 
+	state = &dev->states[i++];
+	snprintf(state->name, CPUIDLE_NAME_LEN, "C2");
+	strncpy(state->desc, "SuperH Mobile Standby Mode [SF]", CPUIDLE_DESC_LEN);
+	state->exit_latency = 2300;
+	state->target_residency = 1 * 2;
+	state->power_usage = 1;
+	state->flags = 0;
+	state->flags |= CPUIDLE_FLAG_TIME_VALID;
+	state->enter = cpuidle_sleep_enter;
+
 	dev->state_count = i;
 
 	cpuidle_register_device(dev);
