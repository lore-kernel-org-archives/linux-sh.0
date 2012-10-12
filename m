From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 12 Oct 2012 04:59:17 +0000
Subject: [PATCH 1/2 v2] ARM: shmobile: armadillo800eva: __io abuse cleanup
Message-Id: <87lifcb80v.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

a2a47ca36642e3995e982957bc42678cf11ca6ac
(ARM: __io abuse cleanup) cleanuped __io() -> IOMEM(),
but armadillo800eva was a outside of a target,
since "merge window" timing issue.
This patch cleanup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Simon

I guess this patch should go to v3.7 fixup branch

 arch/arm/mach-shmobile/board-armadillo800eva.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index fe27d7e..499e6e3 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1196,7 +1196,7 @@ static void __init eva_init(void)
 
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 32K*8way */
-	l2x0_init(__io(0xf0002000), 0x40440000, 0x82000fff);
+	l2x0_init(IOMEM(0xf0002000), 0x40440000, 0x82000fff);
 #endif
 
 	i2c_register_board_info(0, i2c0_devices, ARRAY_SIZE(i2c0_devices));
-- 
1.7.9.5

