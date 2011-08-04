From: David Brown <davidb@codeaurora.org>
Date: Thu, 04 Aug 2011 16:24:31 +0000
Subject: [PATCH] cpuidle: Consistent spelling of cpuidle_idle_call()
Message-Id: <1312475071-22973-1-git-send-email-davidb@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Commit a0bfa1373859e9d11dc92561a8667588803e42d8 mispells
cpuidle_idle_call() on ARM and SH code.  Fix this to be consistent.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: x86@kernel.org
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: David Brown <davidb@codeaurora.org>
---
The referenced commit breaks compilation on ARM, and appears it would
do so on SH as well.

David

 arch/arm/kernel/process.c |    2 +-
 arch/sh/kernel/idle.c     |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index d7ee0d4..1a347f4 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -197,7 +197,7 @@ void cpu_idle(void)
 				cpu_relax();
 			} else {
 				stop_critical_timings();
-				if (cpuidle_call_idle())
+				if (cpuidle_idle_call())
 					pm_idle();
 				start_critical_timings();
 				/*
diff --git a/arch/sh/kernel/idle.c b/arch/sh/kernel/idle.c
index 3c45de1..32114e0 100644
--- a/arch/sh/kernel/idle.c
+++ b/arch/sh/kernel/idle.c
@@ -101,7 +101,7 @@ void cpu_idle(void)
 			local_irq_disable();
 			/* Don't trace irqs off for idle */
 			stop_critical_timings();
-			if (cpuidle_call_idle())
+			if (cpuidle_idle_call())
 				pm_idle();
 			/*
 			 * Sanity check to ensure that pm_idle() returns
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

