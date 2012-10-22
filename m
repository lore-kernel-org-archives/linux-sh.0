From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 22 Oct 2012 05:15:13 +0000
Subject: [PATCH] ARM: shmobile: r8a7740: fixup DT machine desc name typo
Message-Id: <87sj97rstd.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

r8a7740 machine desc name should be R8A7740,
not SH7372

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/setup-r8a7740.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 11bb1d9..9777e2d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -747,7 +747,7 @@ static const char *r8a7740_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(SH7372_DT, "Generic R8A7740 (Flattened Device Tree)")
+DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
 	.map_io		= r8a7740_map_io,
 	.init_early	= r8a7740_add_early_devices_dt,
 	.init_irq	= r8a7740_init_irq,
-- 
1.7.9.5

