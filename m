From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 28 Aug 2013 01:42:04 +0000
Subject: [PATCH 4/5] ARM: shmobile: Expose shmobile_invalidate_start()
Message-Id: <eb2d656152e3e712c8798f7cc2dd99771c969920.1377651075.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1377651075.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1377651075.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Expose shmobile_invalidate_start() in common.h for
mach-shmobile. This function will be used for boot of
secondary processors on future non-SCU SMP platforms.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/common.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index e64515e..1ffe39c 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -15,6 +15,7 @@ extern void shmobile_smp_sleep(void);
 extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
 			      unsigned long arg);
 extern int shmobile_smp_cpu_disable(unsigned int cpu);
+extern void shmobile_invalidate_start(void);
 extern void shmobile_boot_scu(void);
 extern void shmobile_smp_scu_prepare_cpus(unsigned int max_cpus);
 extern int shmobile_smp_scu_boot_secondary(unsigned int cpu,
-- 
1.8.3.2

