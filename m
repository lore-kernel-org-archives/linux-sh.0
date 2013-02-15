From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 15 Feb 2013 13:01:00 +0000
Subject: [PATCH 4/5] ARM: shmobile: sh73a0: Add smp ops to DT_MACHINE_START
Message-Id: <1360933261-6359-5-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360933261-6359-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1360933261-6359-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This a board to be brought up with SMP enabled
without a board file present.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh73a0.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/setup-sh73a0.c b/arch/arm/mach-shmobile/setup-sh73a0.c
index fc0c73c..8f00f3a 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -863,6 +863,7 @@ static const char *sh73a0_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
+	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_add_early_devices_dt,
 	.nr_irqs	= NR_IRQS_LEGACY,
-- 
1.7.10.4

