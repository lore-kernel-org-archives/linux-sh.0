From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Oct 2013 05:58:30 +0000
Subject: [PATCH 3/7] ARM: shmobile: lager: don't use named resource for MMCIF
Message-Id: <8738ocxq0t.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh_mmcif driver doesn't care resource name.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-lager.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index a8d3ce6..78a31b6 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -148,7 +148,7 @@ static const struct sh_mmcif_plat_data mmcif1_pdata __initconst = {
 };
 
 static const struct resource mmcif1_resources[] __initconst = {
-	DEFINE_RES_MEM_NAMED(0xee220000, 0x80, "MMCIF1"),
+	DEFINE_RES_MEM(0xee220000, 0x80),
 	DEFINE_RES_IRQ(gic_spi(170)),
 };
 
-- 
1.7.9.5

