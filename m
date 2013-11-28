From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 28 Nov 2013 08:54:26 +0000
Subject: [PATCH 02/16] ARM: shmobile: ape6evm: don't use named resource for SDHI
Message-Id: <e33e6968ccffc50e788a7a98613985410262332f.1385628709.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1385628709.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1385628709.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

sh_mobile_sdhi driver doesn't care resource name.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 94adf61..fe071a9 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -179,7 +179,7 @@ static const struct sh_mobile_sdhi_info sdhi0_pdata __initconst = {
 };
 
 static const struct resource sdhi0_resources[] __initconst = {
-	DEFINE_RES_MEM_NAMED(0xee100000, 0x100, "SDHI0"),
+	DEFINE_RES_MEM(0xee100000, 0x100),
 	DEFINE_RES_IRQ(gic_spi(165)),
 };
 
@@ -191,7 +191,7 @@ static const struct sh_mobile_sdhi_info sdhi1_pdata __initconst = {
 };
 
 static const struct resource sdhi1_resources[] __initconst = {
-	DEFINE_RES_MEM_NAMED(0xee120000, 0x100, "SDHI1"),
+	DEFINE_RES_MEM(0xee120000, 0x100),
 	DEFINE_RES_IRQ(gic_spi(166)),
 };
 
-- 
1.8.4

