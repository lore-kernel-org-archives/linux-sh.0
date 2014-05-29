From: keita kobayashi <keita.kobayashi.ym@renesas.com>
Date: Thu, 29 May 2014 07:24:39 +0000
Subject: [PATCH 2/3] ARM: shmobile: r8a7790: Support Core-Standby for Suspend to RAM
Message-Id: <5386E0B7.6090303@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add r8a7790 Core-Standby state for Suspend to RAM support.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 arch/arm/mach-shmobile/smp-r8a7790.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/smp-r8a7790.c b/arch/arm/mach-shmobile/smp-r8a7790.c
index 5910527..1193f1e 100644
--- a/arch/arm/mach-shmobile/smp-r8a7790.c
+++ b/arch/arm/mach-shmobile/smp-r8a7790.c
@@ -69,6 +69,7 @@ static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
 
 	/* turn on power to SCU */
 	r8a7790_pm_init();
+	shmobile_smp_apmu_suspend_init();
 	rcar_sysc_power_up(&r8a7790_ca15_scu);
 	rcar_sysc_power_up(&r8a7790_ca7_scu);
 }
-- 
1.7.9.5

