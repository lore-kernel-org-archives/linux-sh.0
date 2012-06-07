From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Thu, 07 Jun 2012 01:40:55 +0000
Subject: [PATCH] ARM: mach-shmobile: Fix build when SMP is enabled and EMEV2 is not enabled
Message-Id: <1339033256-12415-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Build failed, when SMP is enabled and EMEV2 is not enabled.

-----
arch/arm/mach-shmobile/built-in.o: In function `shmobile_platform_cpu_kill':
/home/iwamatsu/work/kernel/sh-2.6-devel/arch/arm/mach-shmobile/platsmp.c:62: undefined reference to `emev2_platform_cpu_kill'
arch/arm/mach-shmobile/built-in.o: In function `shmobile_smp_get_core_count':
/home/iwamatsu/work/kernel/sh-2.6-devel/arch/arm/mach-shmobile/platsmp.c:39: undefined reference to `emev2_get_core_count'
arch/arm/mach-shmobile/built-in.o: In function `shmobile_smp_prepare_cpus':
/home/iwamatsu/work/kernel/sh-2.6-devel/arch/arm/mach-shmobile/platsmp.c:53: undefined reference to `emev2_smp_prepare_cpus'
arch/arm/mach-shmobile/built-in.o: In function `platform_secondary_init':
/home/iwamatsu/work/kernel/sh-2.6-devel/arch/arm/mach-shmobile/platsmp.c:78: undefined reference to `emev2_secondary_init'
arch/arm/mach-shmobile/built-in.o: In function `boot_secondary':
/home/iwamatsu/work/kernel/sh-2.6-devel/arch/arm/mach-shmobile/platsmp.c:90: undefined reference to `emev2_boot_secondary
-----

This is the cause by when EMEV2 is disabled, that the check by OF of EMEV2 is
performed in platsmp.c.
This patch revise what the function about EMEV2 may not be used in this file,
when EMEV2 is not enabled.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 arch/arm/mach-shmobile/platsmp.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/platsmp.c b/arch/arm/mach-shmobile/platsmp.c
index bacdd66..e859fcd 100644
--- a/arch/arm/mach-shmobile/platsmp.c
+++ b/arch/arm/mach-shmobile/platsmp.c
@@ -25,7 +25,12 @@
 #define is_sh73a0() (machine_is_ag5evm() || machine_is_kota2() || \
 			of_machine_is_compatible("renesas,sh73a0"))
 #define is_r8a7779() machine_is_marzen()
+
+#ifdef CONFIG_ARCH_EMEV2
 #define is_emev2() of_machine_is_compatible("renesas,emev2")
+#else
+#define is_emev2() (0)
+#endif
 
 static unsigned int __init shmobile_smp_get_core_count(void)
 {
-- 
1.7.10

