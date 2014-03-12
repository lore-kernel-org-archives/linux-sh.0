From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Mar 2014 18:44:50 +0000
Subject: [PATCH 2/2] ARM: shmobile: r8a7791: Use rcar_gen2_read_mode_pins() helper
Message-Id: <1394649890-23485-2-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 arch/arm/mach-shmobile/clock-r8a7791.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index 701383fe3267..36e57508d879 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -25,6 +25,7 @@
 #include <linux/clkdev.h>
 #include <mach/clock.h>
 #include <mach/common.h>
+#include <mach/rcar-gen2.h>
 
 /*
  *   MD		EXTAL		PLL0	PLL1	PLL3
@@ -43,8 +44,6 @@
  *	see "p1 / 2" on R8A7791_CLOCK_ROOT() below
  */
 
-#define MD(nr)	(1 << nr)
-
 #define CPG_BASE 0xe6150000
 #define CPG_LEN 0x1000
 
@@ -68,7 +67,6 @@
 #define MSTPSR9		IOMEM(0xe61509a4)
 #define MSTPSR11	IOMEM(0xe61509ac)
 
-#define MODEMR		0xE6160060
 #define SDCKCR		0xE6150074
 #define SD1CKCR		0xE6150078
 #define SD2CKCR		0xE615026c
@@ -295,14 +293,9 @@ static struct clk_lookup lookups[] = {
 
 void __init r8a7791_clock_init(void)
 {
-	void __iomem *modemr = ioremap_nocache(MODEMR, PAGE_SIZE);
-	u32 mode;
+	u32 mode = rcar_gen2_read_mode_pins();
 	int k, ret = 0;
 
-	BUG_ON(!modemr);
-	mode = ioread32(modemr);
-	iounmap(modemr);
-
 	switch (mode & (MD(14) | MD(13))) {
 	case 0:
 		R8A7791_CLOCK_ROOT(15, &extal_clk, 172, 208, 106, 88);
-- 
1.7.9.5

