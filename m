From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Thu, 10 Jan 2013 10:16:44 +0000
Subject: [PATCH 2/2] ARM: mach-shmobile: sh73a0: allow unplugging of CPU0
Message-Id: <1357813004-9549-3-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh73a0 deals fine with disabling any core, so we should permit it.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
---
 arch/arm/mach-shmobile/smp-sh73a0.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index 624f00f..2d4fe08 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -141,6 +141,6 @@ struct smp_operations sh73a0_smp_ops __initdata = {
 #ifdef CONFIG_HOTPLUG_CPU
 	.cpu_kill		= sh73a0_cpu_kill,
 	.cpu_die		= shmobile_cpu_die,
-	.cpu_disable		= shmobile_cpu_disable,
+	.cpu_disable		= shmobile_cpu_disable_any,
 #endif
 };
-- 
1.7.10.4

