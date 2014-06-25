From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 25 Jun 2014 07:35:18 +0000
Subject: [PATCH 06/14] ARM: shmobile: Use shmobile_init_late() on r8a7790 DT-only
Message-Id: <7d95b9ddfb933f94354fa2ff9b1bfccdd6c54653.1403681315.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1403681315.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1403681315.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Tie in shmobile_init_late for the DT-only r8a7790 SoC
Multiplatform support code. This will make sure that
Suspend-to-RAM, CPUIdle and CPUFreq get initialized.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7790.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index 4212c8d..516b4e4 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -326,6 +326,7 @@ DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
 	.smp		= smp_ops(r8a7790_smp_ops),
 	.init_early	= r8a7790_init_early,
 	.init_time	= rcar_gen2_timer_init,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a7790_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
-- 
2.0.0.rc2

