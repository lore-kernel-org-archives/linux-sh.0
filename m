From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 28 Nov 2013 08:54:27 +0000
Subject: [PATCH 03/16] ARM: shmobile: lager: don't use named resource for MMCIF
Message-Id: <b7b42df6c9400ae09453f894b06d9e7719058948.1385628709.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1385628709.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1385628709.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

sh_mmcif driver doesn't care resource name.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 2 +-
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
1.8.4

