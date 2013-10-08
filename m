From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Oct 2013 05:58:08 +0000
Subject: [PATCH 1/7] ARM: shmobile: ape6evm: don't use named resource for MMCIF
Message-Id: <8761t8xq1f.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh_mmcif driver doesn't care resource name.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-ape6evm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 0fa068e..94adf61 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -168,7 +168,7 @@ static const struct sh_mmcif_plat_data mmcif0_pdata __initconst = {
 };
 
 static const struct resource mmcif0_resources[] __initconst = {
-	DEFINE_RES_MEM_NAMED(0xee200000, 0x100, "MMCIF0"),
+	DEFINE_RES_MEM(0xee200000, 0x100),
 	DEFINE_RES_IRQ(gic_spi(169)),
 };
 
-- 
1.7.9.5

