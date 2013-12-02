From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 02 Dec 2013 02:19:22 +0000
Subject: [PATCH 16/28] ARM: shmobile: Use ->init_late() in shared EMEV2 case
Message-Id: <26532aff60c8a008ccc48685a42b78145d6bd31b.1385950394.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1385950394.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1385950394.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Hook up shmobile_init_late() to enable various
code such as suspend-to-RAM and CPUIdle.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-emev2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/setup-emev2.c b/arch/arm/mach-shmobile/setup-emev2.c
index 2d64b95..4d39bf4 100644
--- a/arch/arm/mach-shmobile/setup-emev2.c
+++ b/arch/arm/mach-shmobile/setup-emev2.c
@@ -218,6 +218,7 @@ DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
 	.map_io		= emev2_map_io,
 	.init_early	= emev2_init_delay,
 	.init_machine	= emev2_add_standard_devices_dt,
+	.init_late	= shmobile_init_late,
 	.dt_compat	= emev2_boards_compat_dt,
 MACHINE_END
 
-- 
1.8.4

