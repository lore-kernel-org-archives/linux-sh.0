From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Oct 2013 05:58:20 +0000
Subject: [PATCH 2/7] ARM: shmobile: ape6evm: don't use named resource for SDHI
Message-Id: <874n8sxq13.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh_mobile_sdhi driver doesn't care resource name.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ape6evm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 94adf61..fe071a91 100644
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
1.7.9.5

