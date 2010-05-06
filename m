From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 06 May 2010 07:17:05 +0000
Subject: [PATCH] sh: balance recently added call to local_irq_disable() for
Message-Id: <Pine.LNX.4.64.1005060908110.4557@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Commit f533c3d340536198a4889a42a68d6c0d79a504e7
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Fri Oct 16 17:20:58 2009 +0900

    sh: Idle loop chainsawing for SMP-based light sleep.

added a call to local_irq_disable() to cpu_idle(), which, if the cpuidle driver
is used, now stays unbalanced. This patch re-adds the missing
local_irq_enable().

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Unfortunately, even after this patch CPU_IDLE is still broken on sh, due 
to some later PM changes, so, I'll remove it from all defconfigs with the 
following patch.

 arch/sh/kernel/cpu/shmobile/pm.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/shmobile/pm.c b/arch/sh/kernel/cpu/shmobile/pm.c
index e559687..874035f 100644
--- a/arch/sh/kernel/cpu/shmobile/pm.c
+++ b/arch/sh/kernel/cpu/shmobile/pm.c
@@ -61,6 +61,7 @@ void sh_mobile_call_standby(unsigned long mode)
 	if (mode & SUSP_SH_MMU)
 		flush_cache_all();
 
+	local_irq_enable();
 	/* Let assembly snippet in on-chip memory handle the rest */
 	standby_onchip_mem(mode, RAM_BASE);
 
-- 
1.6.2.4

