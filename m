From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Wed, 17 Apr 2013 13:32:55 +0000
Subject: [PATCH 2/4] SH: cpuidle: remove CPUIDLE_DRIVER_STATE_START usage
Message-Id: <1366205577-11632-2-git-send-email-daniel.lezcano@linaro.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1366205577-11632-1-git-send-email-daniel.lezcano@linaro.org>
In-Reply-To: <1366205577-11632-1-git-send-email-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lethal@linux-sh.org, rjw@sisk.pl
Cc: linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, patches@linaro.org

From: Daniel Lezcano <daniel.lezcano@linaro.or>

The CPUIDLE_DRIVER_STATE_START constant is only set when the kernel compilation
option CONFIG_ARCH_HAS_CPU_RELAX is set, but this is only relatated to x86, so
it is always zero.

Remove the reference to this constant in the code.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/sh/kernel/cpu/shmobile/cpuidle.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/shmobile/cpuidle.c
index 5b44af9..36374cc 100644
--- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
+++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
@@ -62,9 +62,7 @@ void sh_mobile_setup_cpuidle(void)
 	struct cpuidle_device *dev = &cpuidle_dev;
 	struct cpuidle_driver *drv = &cpuidle_driver;
 	struct cpuidle_state *state;
-	int i;
-
-	i = CPUIDLE_DRIVER_STATE_START;
+	int i = 0;
 
 	state = &drv->states[i++];
 	snprintf(state->name, CPUIDLE_NAME_LEN, "C1");
@@ -76,7 +74,7 @@ void sh_mobile_setup_cpuidle(void)
 	state->flags |= CPUIDLE_FLAG_TIME_VALID;
 	state->enter = cpuidle_sleep_enter;
 
-	drv->safe_state_index = i-1;
+	drv->safe_state_index = 0;
 
 	if (sh_mobile_sleep_supported & SUSP_SH_SF) {
 		state = &drv->states[i++];
-- 
1.7.9.5

