From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Oct 2013 06:35:34 +0000
Subject: [PATCH 05/10] ARM: shmobile: bockw: add pin pull-up setting for SDHI
Message-Id: <87eh7s1fik.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SDHI CD/WP pin needs pull-up

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw-reference.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
index fac95a4..027373f 100644
--- a/arch/arm/mach-shmobile/board-bockw-reference.c
+++ b/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -30,9 +30,13 @@
 #define FPGA	0x18200000
 #define IRQ0MR	0x30
 #define COMCTLR	0x101c
+
+#define PFC	0xfffc0000
+#define PUPR4	0x110
 static void __init bockw_init(void)
 {
 	void __iomem *fpga;
+	void __iomem *pfc;
 
 	r8a7778_clock_init();
 	r8a7778_init_irq_extpin_dt(1);
@@ -54,6 +58,17 @@ static void __init bockw_init(void)
 		iounmap(fpga);
 	}
 
+	pfc = ioremap_nocache(PFC, 0x200);
+	if (pfc) {
+		/*
+		 * FIXME
+		 *
+		 * SDHI CD/WP pin needs pull-up
+		 */
+		iowrite32(ioread32(pfc + PUPR4) | (3 << 26), pfc + PUPR4);
+		iounmap(pfc);
+	}
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
1.7.9.5

