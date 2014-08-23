From: Simon Horman <horms+renesas@verge.net.au>
Date: Sat, 23 Aug 2014 01:44:12 +0000
Subject: [PATCH 02/11] ARM: shmobile: sh73a0: Add shmobile_init_late()
Message-Id: <e604d80971e65c7ae895a4b38caed3838cf07554.1408671240.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1408671240.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1408671240.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Extend sh73a0 SoC machine vector to include shmobile_init_late()
so Suspend-to-RAM and CPUIdle are setup as expected.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index 2c802ae..0022918 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -799,6 +799,7 @@ DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
 	.init_early	= sh73a0_init_delay,
 	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_machine	= sh73a0_add_standard_devices_dt,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= sh73a0_boards_compat_dt,
 MACHINE_END
 #endif /* CONFIG_USE_OF */
-- 
2.0.1

