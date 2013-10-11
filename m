From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Oct 2013 06:35:06 +0000
Subject: [PATCH 03/10] ARM: shmobile: bockw: fixup FPGA ioremap area
Message-Id: <87haco1fjc.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Don't keep FPGA ioremap area.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-bockw-reference.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-bockw-reference.c b/arch/arm/mach-shmobile/board-bockw-reference.c
index 875cf3f..fac95a4 100644
--- a/arch/arm/mach-shmobile/board-bockw-reference.c
+++ b/arch/arm/mach-shmobile/board-bockw-reference.c
@@ -32,7 +32,7 @@
 #define COMCTLR	0x101c
 static void __init bockw_init(void)
 {
-	static void __iomem *fpga;
+	void __iomem *fpga;
 
 	r8a7778_clock_init();
 	r8a7778_init_irq_extpin_dt(1);
@@ -50,6 +50,8 @@ static void __init bockw_init(void)
 		u16 val = ioread16(fpga + IRQ0MR);
 		val &= ~(1 << 4); /* enable SMSC911x */
 		iowrite16(val, fpga + IRQ0MR);
+
+		iounmap(fpga);
 	}
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-- 
1.7.9.5

