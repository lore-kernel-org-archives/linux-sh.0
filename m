From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 26 Aug 2013 08:52:23 +0000
Subject: [PATCH 3/5 v2] ARM: shmobile: bockw: enable global use of FPGA
Message-Id: <87d2p0vnph.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch enables global use of FPGA,
since it will be used from many devices.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - no change

 arch/arm/mach-shmobile/board-bockw.c |   15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 255e97e..56bc9cc 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -36,6 +36,10 @@
 #include <mach/r8a7778.h>
 #include <asm/mach/arch.h>
 
+#define FPGA	0x18200000
+#define IRQ0MR	0x30
+static void __iomem *fpga;
+
 /*
  *	CN9(Upper side) SCIF/RCAN selection
  *
@@ -194,8 +198,6 @@ static const struct pinctrl_map bockw_pinctrl_map[] = {
 				  "sdhi0_wp", "sdhi0"),
 };
 
-#define FPGA	0x18200000
-#define IRQ0MR	0x30
 #define PFC	0xfffc0000
 #define PUPR4	0x110
 static void __init bockw_init(void)
@@ -229,8 +231,8 @@ static void __init bockw_init(void)
 
 
 	/* for SMSC */
-	base = ioremap_nocache(FPGA, SZ_1M);
-	if (base) {
+	fpga = ioremap_nocache(FPGA, SZ_1M);
+	if (fpga) {
 		/*
 		 * CAUTION
 		 *
@@ -238,10 +240,9 @@ static void __init bockw_init(void)
 		 * it should be cared in the future
 		 * Now, it is assuming IRQ0 was used only from SMSC.
 		 */
-		u16 val = ioread16(base + IRQ0MR);
+		u16 val = ioread16(fpga + IRQ0MR);
 		val &= ~(1 << 4); /* enable SMSC911x */
-		iowrite16(val, base + IRQ0MR);
-		iounmap(base);
+		iowrite16(val, fpga + IRQ0MR);
 
 		regulator_register_fixed(0, dummy_supplies,
 					 ARRAY_SIZE(dummy_supplies));
-- 
1.7.9.5

