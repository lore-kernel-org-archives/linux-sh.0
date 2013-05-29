From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 29 May 2013 07:42:29 +0000
Subject: [PATCH] ARM: shmobile: r8a7740: Don't set cpuidle driver en_core_tk_irqen field
Message-Id: <1369813349-949-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The cpuidle_driver structure en_core_tk_irqen field has been removed.
Don't set it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/cpuidle-r8a7740.c | 1 -
 1 file changed, 1 deletion(-)

Simon,

Most of the latest branches in your tree fail to compile when cpuidle and
r8a7740 are enabled. This patch fixes the problem.

diff --git a/arch/arm/mach-shmobile/cpuidle-r8a7740.c b/arch/arm/mach-shmobile/cpuidle-r8a7740.c
index 48c7a6c..8990de2 100644
--- a/arch/arm/mach-shmobile/cpuidle-r8a7740.c
+++ b/arch/arm/mach-shmobile/cpuidle-r8a7740.c
@@ -31,7 +31,6 @@ static int r8a7740_enter_a3sm_pll_off(struct cpuidle_device *dev,
 static struct cpuidle_driver r8a7740_cpuidle_driver = {
 	.name			= "r8a7740_cpuidle",
 	.owner			= THIS_MODULE,
-	.en_core_tk_irqen	= 1,
 	.state_count		= 3,
 	.safe_state_index	= 0, /* C1 */
 	.states[0] = ARM_CPUIDLE_WFI_STATE,
-- 
Regards,

Laurent Pinchart

