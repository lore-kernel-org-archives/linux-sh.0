From: Thomas Renninger <trenn@suse.de>
Date: Sun, 27 Feb 2011 21:36:42 +0000
Subject: [PATCH] shmobile: Rename cpuidle states to fit to general conventions
Message-Id: <1298842606-55712-2-git-send-email-trenn@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1298842606-55712-1-git-send-email-trenn@suse.de>
In-Reply-To: <1298842606-55712-1-git-send-email-trenn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: trenn@suse.de, lenb@kernel.org, mingo@elte.hu, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

C0 is known as "busy", "not idle" state.
X86 "busy polling" state also got renamed from C0
to "POLL" recently.
Let's stay consistent with naming to avoid confusions.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Acked-by: Magnus Damm <damm@opensource.se>
CC: linux-sh@vger.kernel.org
---
 arch/sh/kernel/cpu/shmobile/cpuidle.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/cpu/shmobile/cpuidle.c b/arch/sh/kernel/cpu/shmobile/cpuidle.c
index c19e2a9..e4469e72 100644
--- a/arch/sh/kernel/cpu/shmobile/cpuidle.c
+++ b/arch/sh/kernel/cpu/shmobile/cpuidle.c
@@ -75,7 +75,7 @@ void sh_mobile_setup_cpuidle(void)
 	i = CPUIDLE_DRIVER_STATE_START;
 
 	state = &dev->states[i++];
-	snprintf(state->name, CPUIDLE_NAME_LEN, "C0");
+	snprintf(state->name, CPUIDLE_NAME_LEN, "C1");
 	strncpy(state->desc, "SuperH Sleep Mode", CPUIDLE_DESC_LEN);
 	state->exit_latency = 1;
 	state->target_residency = 1 * 2;
@@ -88,7 +88,7 @@ void sh_mobile_setup_cpuidle(void)
 
 	if (sh_mobile_sleep_supported & SUSP_SH_SF) {
 		state = &dev->states[i++];
-		snprintf(state->name, CPUIDLE_NAME_LEN, "C1");
+		snprintf(state->name, CPUIDLE_NAME_LEN, "C2");
 		strncpy(state->desc, "SuperH Sleep Mode [SF]",
 			CPUIDLE_DESC_LEN);
 		state->exit_latency = 100;
@@ -101,7 +101,7 @@ void sh_mobile_setup_cpuidle(void)
 
 	if (sh_mobile_sleep_supported & SUSP_SH_STANDBY) {
 		state = &dev->states[i++];
-		snprintf(state->name, CPUIDLE_NAME_LEN, "C2");
+		snprintf(state->name, CPUIDLE_NAME_LEN, "C3");
 		strncpy(state->desc, "SuperH Mobile Standby Mode [SF]",
 			CPUIDLE_DESC_LEN);
 		state->exit_latency = 2300;
-- 
1.7.3.4

