From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Jun 2014 05:15:44 +0000
Subject: [PATCH 05/08] ARM: shmobile: Use __init for APMU suspend init function
Message-Id: <20140605051544.18075.12659.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

The function shmobile_smp_apmu_suspend_init() should
be put into the init section to not trigger section
mismatch warnings.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/platsmp-apmu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0003/arch/arm/mach-shmobile/platsmp-apmu.c
+++ work/arch/arm/mach-shmobile/platsmp-apmu.c	2014-06-05 12:51:33.000000000 +0900
@@ -240,7 +240,7 @@ static int shmobile_smp_apmu_enter_suspe
 	return 0;
 }
 
-void shmobile_smp_apmu_suspend_init(void)
+void __init shmobile_smp_apmu_suspend_init(void)
 {
 	shmobile_suspend_ops.enter = shmobile_smp_apmu_enter_suspend;
 }
