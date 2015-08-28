From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Aug 2015 21:37:17 +0000
Subject: [PATCH 3/3] ARM: shmobile: Remove legacy clock support leftovers
Message-Id: <1440797837-25516-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The shmobile_clk_init() function has been removed and the linux/sh_clk.h
header doesn't need to be included anymore.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/common.h  | 2 --
 arch/arm/mach-shmobile/r8a7779.h | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/common.h b/arch/arm/mach-shmobile/common.h
index 65d6ddef0f50..dc5748bcdbe1 100644
--- a/arch/arm/mach-shmobile/common.h
+++ b/arch/arm/mach-shmobile/common.h
@@ -15,8 +15,6 @@ extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
 extern void shmobile_smp_scu_cpu_die(unsigned int cpu);
 extern int shmobile_smp_scu_cpu_kill(unsigned int cpu);
-struct clk;
-extern int shmobile_clk_init(void);
 extern struct platform_suspend_ops shmobile_suspend_ops;
 
 #ifdef CONFIG_SUSPEND
diff --git a/arch/arm/mach-shmobile/r8a7779.h b/arch/arm/mach-shmobile/r8a7779.h
index db303f76704e..aad833a8f0b8 100644
--- a/arch/arm/mach-shmobile/r8a7779.h
+++ b/arch/arm/mach-shmobile/r8a7779.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_R8A7779_H__
 #define __ASM_R8A7779_H__
 
-#include <linux/sh_clk.h>
-
 extern void r8a7779_pm_init(void);
 
 #ifdef CONFIG_PM
-- 
2.4.6

