From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Fri, 12 Mar 2010 10:07:55 +0000
Subject: [PATCH] ARM: mach-shmobile: ap4evb: Add SW43, SW3 tiny document
Message-Id: <uzl2dq2dg.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
In-Reply-To: <uhbpex68f.wl%morimoto.kuninori@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
depend on
[PATCH 2/3] ARM: mach-shmobile: ap4evb: Add TouchScreen support

 arch/arm/mach-shmobile/board-ap4evb.c |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index b134902..28a9cde 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -82,12 +82,16 @@
  */
 
 /*
- * KEYSC
+ * LCD / IRQ / KEYSC / IrDA
  *
- * SW43		KEYSC
- * -------------------------
- * ON		enable
- * OFF		disable
+ * IRQ = IRQ26 (TS), IRQ27 (VIO), IRQ28 (TouchScreen)
+ * LCD = 2nd LCDC
+ *
+ * 		|		SW43			|
+ * SW3		|	ON		|	OFF	|
+ * -------------+-----------------------+---------------+
+ * ON		| KEY / IrDA		| LCD		|
+ * OFF		| KEY / IrDA / IRQ	| IRQ		|
  */
 
 /* MTD */
@@ -236,7 +240,7 @@ static struct platform_device *ap4evb_devices[] __initdata = {
 	&sdhi0_device,
 };
 
-/* TouchScreen */
+/* TouchScreen (Needs SW3 set to OFF) */
 #define IRQ28	396
 struct tsc2007_platform_data tsc2007_info = {
 	.model			= 2007,
-- 
1.6.3.3

