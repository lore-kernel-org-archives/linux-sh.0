From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 19 Sep 2014 04:14:20 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7794: Reserve memory as other R-Car Gen2 SoCs
Message-Id: <299e14734c22994e69c913e66ab1f4bb56423f5d.1411100007.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1411100007.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1411100007.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Other R-Car Gen2 SoCs such as r8a7790 and r8a7791 reserve
the top 256 MiB of memory for use with CMA. Adjust the
board-less r8a7794 code to do the same.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7794.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/setup-r8a7794.c b/arch/arm/mach-shmobile/setup-r8a7794.c
index c10acd1..d2b0930 100644
--- a/arch/arm/mach-shmobile/setup-r8a7794.c
+++ b/arch/arm/mach-shmobile/setup-r8a7794.c
@@ -28,5 +28,6 @@ DT_MACHINE_START(R8A7794_DT, "Generic R8A7794 (Flattened Device Tree)")
 	.init_early	= shmobile_init_delay,
 	.init_late	= shmobile_init_late,
 	.init_time	= rcar_gen2_timer_init,
+	.reserve	= rcar_gen2_reserve,
 	.dt_compat	= r8a7794_boards_compat_dt,
 MACHINE_END
-- 
2.0.1

