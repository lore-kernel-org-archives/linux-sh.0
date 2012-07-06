From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 06 Jul 2012 08:20:05 +0000
Subject: [PATCH] ARM: mach-shmobile: fix platsmp.c build when ARCH_SH73A0=n
Message-Id: <20120706082005.30495.53308.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Fix build error in the case of SMP=y but ARCH_SH73A0=n
introduced by:

9601e87 ARM: shmobile: fix smp build

The use of of_machine_is_compatible() will link in the
the SoC-specific symbols:
"sh73a0_get_core_count", "sh73a0_smp_prepare_cpus",
"sh73a0_secondary_init" and "sh73a0_boot_secondary".

This patch adds an ugly #ifdef wrapper as a stop-gap
solution.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/platsmp.c |    5 +++++
 1 file changed, 5 insertions(+)

--- 0001/arch/arm/mach-shmobile/platsmp.c
+++ work/arch/arm/mach-shmobile/platsmp.c	2012-07-06 16:37:30.000000000 +0900
@@ -22,8 +22,13 @@
 #include <mach/common.h>
 #include <mach/emev2.h>
 
+#ifdef CONFIG_ARCH_SH73A0
 #define is_sh73a0() (machine_is_ag5evm() || machine_is_kota2() || \
 			of_machine_is_compatible("renesas,sh73a0"))
+#else
+#define is_sh73a0() (0)
+#endif
+
 #define is_r8a7779() machine_is_marzen()
 
 #ifdef CONFIG_ARCH_EMEV2
