From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 27 May 2013 01:42:58 +0000
Subject: [PATCH 2/2 v3] ARM: shmobile: r8a7778: rename device additional function for sdhi
Message-Id: <87ehct8ag0.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Current r8a7778 is using r8a7778_sdhi_init().
Now, we use r8a7778_register_xxx() instead of it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - no change, but become 2nd patch

>> Simon

This patch exchange both board/setup.
Please let me know if you need separated patch

 arch/arm/mach-shmobile/board-bockw.c          |    2 +-
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    2 +-
 arch/arm/mach-shmobile/setup-r8a7778.c        |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 3958910..e70112c 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -131,7 +131,7 @@ static void __init bockw_init(void)
 		iowrite32(ioread32(base + PUPR4) | (3 << 26), base + PUPR4);
 		iounmap(base);
 
-		r8a7778_sdhi_init(0, &sdhi0_info);
+		r8a7778_register_sdhi(0, &sdhi0_info);
 	}
 }
 
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index 695cd76..c24e7eb 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -30,8 +30,8 @@ extern void r8a7778_init_irq_dt(void);
 extern void r8a7778_clock_init(void);
 extern void r8a7778_init_irq_extpin(int irlm);
 extern void r8a7778_pinmux_init(void);
-extern void r8a7778_sdhi_init(int id, struct sh_mobile_sdhi_info *info);
 
 extern void r8a7778_register_sheth(struct sh_eth_plat_data *pdata);
+extern void r8a7778_register_sdhi(int id, struct sh_mobile_sdhi_info *info);
 
 #endif /* __ASM_R8A7778_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 9bff1e1..e44daac 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -162,8 +162,8 @@ static struct resource sdhi_resources[] __initdata = {
 	DEFINE_RES_IRQ(gic_iid(0x76)),
 };
 
-void __init r8a7778_sdhi_init(int id,
-			      struct sh_mobile_sdhi_info *info)
+void __init r8a7778_register_sdhi(int id,
+				  struct sh_mobile_sdhi_info *info)
 {
 	BUG_ON(id < 0 || id > 2);
 
-- 
1.7.9.5

