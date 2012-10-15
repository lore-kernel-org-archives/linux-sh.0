From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Oct 2012 06:35:24 +0000
Subject: [PATCH] ARM: shmobile: r8a7779: I/O address abuse cleanup
Message-Id: <874nlwckev.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

a2a47ca36642e3995e982957bc42678cf11ca6ac
(ARM: __io abuse cleanup) cleanuped __io() -> IOMEM(),
but setup-r8a7779.c was out of target,
since it directly used (void __iomem __force *) instead of __io().
This patch cleanup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Simon

Original a2a47ca36642e3995e982957bc42678cf11ca6ac was in v3.7,
so, this should go to v3.7 ?
But this is not bug fix patch, v3.8 is enough ?

 arch/arm/mach-shmobile/setup-r8a7779.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 2917668..ebbffc2 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -247,7 +247,7 @@ void __init r8a7779_add_standard_devices(void)
 {
 #ifdef CONFIG_CACHE_L2X0
 	/* Early BRESP enable, Shared attribute override enable, 64K*16way */
-	l2x0_init((void __iomem __force *)(0xf0100000), 0x40470000, 0x82000fff);
+	l2x0_init(IOMEM(0xf0100000), 0x40470000, 0x82000fff);
 #endif
 	r8a7779_pm_init();
 
-- 
1.7.9.5

