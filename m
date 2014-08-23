From: Simon Horman <horms+renesas@verge.net.au>
Date: Sat, 23 Aug 2014 01:44:19 +0000
Subject: [PATCH 09/11] ARM: shmobile: r8a7779: Remove NR_IRQS_LEGACY
Message-Id: <93f05252514a8c7b6bf5a132f6b20f10215cb59c.1408671240.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1408671240.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1408671240.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove NR_IRQS_LEGACY from the r8a7779 generic machine
vector. The generic r8a7779 machine vector requires use
of Multiplatform, and in such case SPARSE_IRQ is enabled
by default. This in turns means that the default value
of .nr_irqs equals NR_IRQS and NR_IRQS_LEGACY. Because
of this we can simply remove NR_IRQS_LEGACY and move one
step closer to a cruft-free environment.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 6875a9f..6829cd1 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -771,7 +771,6 @@ static const char *r8a7779_compat_dt[] __initdata = {
 DT_MACHINE_START(R8A7779_DT, "Generic R8A7779 (Flattened Device Tree)")
 	.map_io		= r8a7779_map_io,
 	.init_early	= shmobile_init_delay,
-	.nr_irqs	= NR_IRQS_LEGACY,
 	.init_irq	= r8a7779_init_irq_dt,
 	.init_machine	= r8a7779_add_standard_devices_dt,
 	.init_late	= shmobile_init_late,
-- 
2.0.1

