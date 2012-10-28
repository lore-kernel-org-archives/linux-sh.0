From: Simon Horman <horms@verge.net.au>
Date: Sun, 28 Oct 2012 02:26:12 +0000
Subject: [PATCH 11/12] ARM: shmobile: r8a7740: fixup DT machine desc name typo
Message-Id: <1351391173-32379-12-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1351391173-32379-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1351391173-32379-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

r8a7740 machine desc name should be R8A7740,
not SH7372

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7740.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index 1e032cb..6649a77 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -763,7 +763,7 @@ static const char *r8a7740_boards_compat_dt[] __initdata = {
 	NULL,
 };
 
-DT_MACHINE_START(SH7372_DT, "Generic R8A7740 (Flattened Device Tree)")
+DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
 	.map_io		= r8a7740_map_io,
 	.init_early	= r8a7740_add_early_devices_dt,
 	.init_irq	= r8a7740_init_irq,
-- 
1.7.10.4

