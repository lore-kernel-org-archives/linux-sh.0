From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 20 May 2010 14:45:03 +0000
Subject: [PATCH] ARM: mach-shmobile: sh7372 clock fixes
Message-Id: <20100520144503.27655.80008.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Fixes for the sh7372 clock framework:
 - remove unused #include <linux/platform_device.h>
 - add sh7372 prefix to user modifiable root clocks
 - put modifiable root clock prototypes in header file
 - fix off-by-one id error on VEU MSTP clocks
 - make arrays static

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/clock-sh7372.c        |   33 ++++++++++++--------------
 arch/arm/mach-shmobile/include/mach/common.h |    4 ++-
 2 files changed, 19 insertions(+), 18 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-sh7372.c
+++ work/arch/arm/mach-shmobile/clock-sh7372.c	2010-05-20 23:17:46.000000000 +0900
@@ -18,7 +18,6 @@
  */
 #include <linux/init.h>
 #include <linux/kernel.h>
-#include <linux/platform_device.h>
 #include <linux/io.h>
 #include <linux/sh_clk.h>
 #include <mach/common.h>
@@ -60,7 +59,7 @@ static struct clk r_clk = {
  * 26MHz default rate for the EXTAL1 root input clock.
  * If needed, reset this with clk_set_rate() from the platform code.
  */
-struct clk extal1_clk = {
+struct clk sh7372_extal1_clk = {
 	.rate		= 26666666,
 };
 
@@ -68,7 +67,7 @@ struct clk extal1_clk = {
  * 48MHz default rate for the EXTAL2 root input clock.
  * If needed, reset this with clk_set_rate() from the platform code.
  */
-struct clk extal2_clk = {
+struct clk sh7372_extal2_clk = {
 	.rate		= 48000000,
 };
 
@@ -85,13 +84,13 @@ static struct clk_ops div2_clk_ops = {
 /* Divide extal1 by two */
 static struct clk extal1_div2_clk = {
 	.ops		= &div2_clk_ops,
-	.parent		= &extal1_clk,
+	.parent		= &sh7372_extal1_clk,
 };
 
 /* Divide extal2 by two */
 static struct clk extal2_div2_clk = {
 	.ops		= &div2_clk_ops,
-	.parent		= &extal2_clk,
+	.parent		= &sh7372_extal2_clk,
 };
 
 /* Divide extal2 by four */
@@ -156,10 +155,10 @@ static struct clk pllc2_clk = {
 	.parent		= &extal1_div2_clk,
 };
 
-struct clk *main_clks[] = {
+static struct clk *main_clks[] = {
 	&r_clk,
-	&extal1_clk,
-	&extal2_clk,
+	&sh7372_extal1_clk,
+	&sh7372_extal2_clk,
 	&extal1_div2_clk,
 	&extal2_div2_clk,
 	&extal2_div4_clk,
@@ -200,7 +199,7 @@ enum { DIV4_I, DIV4_ZG, DIV4_B, DIV4_M1,
 #define DIV4(_reg, _bit, _mask, _flags) \
   SH_CLK_DIV4(&pllc1_clk, _reg, _bit, _mask, _flags)
 
-struct clk div4_clks[DIV4_NR] = {
+static struct clk div4_clks[DIV4_NR] = {
 	[DIV4_I] = DIV4(FRQCRA, 20, 0x6fff, CLK_ENABLE_ON_INIT),
 	[DIV4_ZG] = DIV4(FRQCRA, 16, 0x6fff, CLK_ENABLE_ON_INIT),
 	[DIV4_B] = DIV4(FRQCRA, 8, 0x6fff, CLK_ENABLE_ON_INIT),
@@ -223,7 +222,7 @@ enum { DIV6_VCK1, DIV6_VCK2, DIV6_VCK3, 
        DIV6_VOU, DIV6_HDMI, DIV6_DSIT, DIV6_DSI0P, DIV6_DSI1P,
        DIV6_NR };
 
-struct clk div6_clks[DIV6_NR] = {
+static struct clk div6_clks[DIV6_NR] = {
 	[DIV6_VCK1] = SH_CLK_DIV6(&pllc1_div2_clk, VCLKCR1, 0),
 	[DIV6_VCK2] = SH_CLK_DIV6(&pllc1_div2_clk, VCLKCR2, 0),
 	[DIV6_VCK3] = SH_CLK_DIV6(&pllc1_div2_clk, VCLKCR3, 0),
@@ -231,7 +230,7 @@ struct clk div6_clks[DIV6_NR] = {
 	[DIV6_FMSO] = SH_CLK_DIV6(&pllc1_div2_clk, FMSOCKCR, 0),
 	[DIV6_FSIA] = SH_CLK_DIV6(&pllc1_div2_clk, FSIACKCR, 0),
 	[DIV6_FSIB] = SH_CLK_DIV6(&pllc1_div2_clk, FSIBCKCR, 0),
-	[DIV6_SUB] = SH_CLK_DIV6(&extal2_clk, SUBCKCR, 0),
+	[DIV6_SUB] = SH_CLK_DIV6(&sh7372_extal2_clk, SUBCKCR, 0),
 	[DIV6_SPU] = SH_CLK_DIV6(&pllc1_div2_clk, SPUCKCR, 0),
 	[DIV6_VOU] = SH_CLK_DIV6(&pllc1_div2_clk, VOUCKCR, 0),
 	[DIV6_HDMI] = SH_CLK_DIV6(&pllc1_div2_clk, HDMICKCR, 0),
@@ -286,8 +285,8 @@ static struct clk mstp_clks[MSTP_NR] = {
 static struct clk_lookup lookups[] = {
 	/* main clocks */
 	CLKDEV_CON_ID("r_clk", &r_clk),
-	CLKDEV_CON_ID("extal1", &extal1_clk),
-	CLKDEV_CON_ID("extal2", &extal2_clk),
+	CLKDEV_CON_ID("extal1", &sh7372_extal1_clk),
+	CLKDEV_CON_ID("extal2", &sh7372_extal2_clk),
 	CLKDEV_CON_ID("extal1_div2_clk", &extal1_div2_clk),
 	CLKDEV_CON_ID("extal2_div2_clk", &extal2_div2_clk),
 	CLKDEV_CON_ID("extal2_div4_clk", &extal2_div4_clk),
@@ -331,10 +330,10 @@ static struct clk_lookup lookups[] = {
 
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("i2c-sh_mobile.2", &mstp_clks[MSTP001]), /* IIC2 */
-	CLKDEV_DEV_ID("uio_pdrv_genirq.3", &mstp_clks[MSTP131]), /* VEU3 */
-	CLKDEV_DEV_ID("uio_pdrv_genirq.2", &mstp_clks[MSTP130]), /* VEU2 */
-	CLKDEV_DEV_ID("uio_pdrv_genirq.1", &mstp_clks[MSTP129]), /* VEU1 */
-	CLKDEV_DEV_ID("uio_pdrv_genirq.0", &mstp_clks[MSTP128]), /* VEU0 */
+	CLKDEV_DEV_ID("uio_pdrv_genirq.4", &mstp_clks[MSTP131]), /* VEU3 */
+	CLKDEV_DEV_ID("uio_pdrv_genirq.3", &mstp_clks[MSTP130]), /* VEU2 */
+	CLKDEV_DEV_ID("uio_pdrv_genirq.2", &mstp_clks[MSTP129]), /* VEU1 */
+	CLKDEV_DEV_ID("uio_pdrv_genirq.1", &mstp_clks[MSTP128]), /* VEU0 */
 	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP116]), /* IIC0 */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.5", &mstp_clks[MSTP106]), /* JPU */
 	CLKDEV_DEV_ID("uio_pdrv_genirq.0", &mstp_clks[MSTP101]), /* VPU */
--- 0001/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2010-05-20 23:16:09.000000000 +0900
@@ -3,7 +3,7 @@
 
 extern struct sys_timer shmobile_timer;
 extern void shmobile_setup_console(void);
-
+struct clk;
 extern int clk_init(void);
 
 extern void sh7367_init_irq(void);
@@ -22,5 +22,7 @@ extern void sh7372_add_early_devices(voi
 extern void sh7372_add_standard_devices(void);
 extern void sh7372_clock_init(void);
 extern void sh7372_pinmux_init(void);
+extern struct clk sh7372_extal1_clk;
+extern struct clk sh7372_extal2_clk;
 
 #endif /* __ARCH_MACH_COMMON_H */
