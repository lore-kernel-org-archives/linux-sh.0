From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 18 Mar 2013 11:47:11 +0000
Subject: [PATCH 19/43] ARM: shmobile: sh73a0: Add smp ops to DT_MACHINE_START
Message-Id: <1363607255-6385-20-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1363607255-6385-1-git-send-email-horms+renesas@verge.net.au>
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
index 49483f4..c7630aa 100644
--- a/arch/arm/mach-shmobile/setup-sh73a0.c
+++ b/arch/arm/mach-shmobile/setup-sh73a0.c
@@ -919,6 +919,7 @@ static const char *sh73a0_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(SH73A0_DT, "Generic SH73A0 (Flattened Device Tree)")
+	.smp		= smp_ops(sh73a0_smp_ops),
 	.map_io		= sh73a0_map_io,
 	.init_early	= sh73a0_add_early_devices_dt,
 	.nr_irqs	= NR_IRQS_LEGACY,
-- 
1.7.10.4

