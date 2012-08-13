From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Mon, 13 Aug 2012 22:22:11 +0000
Subject: [PATCH 2/3] PM / cpuidle: Make ladder governor use the "disabled" state flag
Message-Id: <201208140022.12197.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <201208140019.19288.rjw@sisk.pl>
In-Reply-To: <201208140019.19288.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>


For the mechanism introduced by commit cbc9ef0 (PM / Domains: Add
preliminary support for cpuidle, v2) to work with the ladder
governor, that governor should respect the "disabled" state flag
added by that commit.  Change the ladder governor accordingly.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/cpuidle/governors/ladder.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Index: linux/drivers/cpuidle/governors/ladder.c
=================================--- linux.orig/drivers/cpuidle/governors/ladder.c
+++ linux/drivers/cpuidle/governors/ladder.c
@@ -88,6 +88,7 @@ static int ladder_select_state(struct cp
 
 	/* consider promotion */
 	if (last_idx < drv->state_count - 1 &&
+	    !drv->states[last_idx + 1].disabled &&
 	    !dev->states_usage[last_idx + 1].disable &&
 	    last_residency > last_state->threshold.promotion_time &&
 	    drv->states[last_idx + 1].exit_latency <= latency_req) {
@@ -101,7 +102,8 @@ static int ladder_select_state(struct cp
 
 	/* consider demotion */
 	if (last_idx > CPUIDLE_DRIVER_STATE_START &&
-	    (dev->states_usage[last_idx].disable ||
+	    (drv->states[last_idx].disabled ||
+	    dev->states_usage[last_idx].disable ||
 	    drv->states[last_idx].exit_latency > latency_req)) {
 		int i;
 

