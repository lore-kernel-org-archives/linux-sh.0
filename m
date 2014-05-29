From: keita kobayashi <keita.kobayashi.ym@renesas.com>
Date: Thu, 29 May 2014 07:24:52 +0000
Subject: [PATCH 3/3] ARM: shmobile: r8a7791: Support Core-Standby for Suspend to RAM
Message-Id: <5386E0C4.1090208@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add r8a7791 Core-Standby state for Suspend to RAM support.

Signed-off-by: Keita Kobayashi <keita.kobayashi.ym@renesas.com>
---
 arch/arm/mach-shmobile/smp-r8a7791.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/smp-r8a7791.c b/arch/arm/mach-shmobile/smp-r8a7791.c
index ddccef6..6b42c16 100644
--- a/arch/arm/mach-shmobile/smp-r8a7791.c
+++ b/arch/arm/mach-shmobile/smp-r8a7791.c
@@ -52,6 +52,7 @@ static void __init r8a7791_smp_prepare_cpus(unsigned int max_cpus)
 	iounmap(p);
 
 	r8a7791_pm_init();
+	shmobile_smp_apmu_suspend_init();
 }
 
 static int r8a7791_smp_boot_secondary(unsigned int cpu,
-- 
1.7.9.5

