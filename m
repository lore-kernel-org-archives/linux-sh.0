From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 31 Oct 2008 11:24:01 +0000
Subject: [PATCH] sh: remove old sh_mobile mstpc clocks
Message-Id: <20081031112401.2996.78791.sendpatchset@rx1.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Remove the old sh_mobile mstpcr clocks.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   52 --------------------------------
 arch/sh/kernel/cpu/sh4a/setup-sh7343.c |   14 ++------
 arch/sh/kernel/cpu/sh4a/setup-sh7366.c |   16 +++------
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |   14 +++-----
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   16 +++------
 5 files changed, 19 insertions(+), 93 deletions(-)

--- 0010/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2008-10-31 20:10:09.000000000 +0900
@@ -632,53 +632,6 @@ static struct clk_ops sh7722_mstpcr_clk_
 	.recalc = sh7722_mstpcr_recalc,
 };
 
-#define DECLARE_MSTPCRN(regnr, bitnr, bitstr)		\
-{							\
-	.name = "mstp" __stringify(regnr) bitstr,	\
-	.arch_flags = MSTPCR_ARCH_FLAGS(regnr, bitnr),	\
-	.ops = &sh7722_mstpcr_clk_ops,	\
-}
-
-#define DECLARE_MSTPCR(regnr) \
-	DECLARE_MSTPCRN(regnr, 31, "31"), \
-	DECLARE_MSTPCRN(regnr, 30, "30"), \
-	DECLARE_MSTPCRN(regnr, 29, "29"), \
-	DECLARE_MSTPCRN(regnr, 28, "28"), \
-	DECLARE_MSTPCRN(regnr, 27, "27"), \
-	DECLARE_MSTPCRN(regnr, 26, "26"), \
-	DECLARE_MSTPCRN(regnr, 25, "25"), \
-	DECLARE_MSTPCRN(regnr, 24, "24"), \
-	DECLARE_MSTPCRN(regnr, 23, "23"), \
-	DECLARE_MSTPCRN(regnr, 22, "22"), \
-	DECLARE_MSTPCRN(regnr, 21, "21"), \
-	DECLARE_MSTPCRN(regnr, 20, "20"), \
-	DECLARE_MSTPCRN(regnr, 19, "19"), \
-	DECLARE_MSTPCRN(regnr, 18, "18"), \
-	DECLARE_MSTPCRN(regnr, 17, "17"), \
-	DECLARE_MSTPCRN(regnr, 16, "16"), \
-	DECLARE_MSTPCRN(regnr, 15, "15"), \
-	DECLARE_MSTPCRN(regnr, 14, "14"), \
-	DECLARE_MSTPCRN(regnr, 13, "13"), \
-	DECLARE_MSTPCRN(regnr, 12, "12"), \
-	DECLARE_MSTPCRN(regnr, 11, "11"), \
-	DECLARE_MSTPCRN(regnr, 10, "10"), \
-	DECLARE_MSTPCRN(regnr, 9, "09"), \
-	DECLARE_MSTPCRN(regnr, 8, "08"), \
-	DECLARE_MSTPCRN(regnr, 7, "07"), \
-	DECLARE_MSTPCRN(regnr, 6, "06"), \
-	DECLARE_MSTPCRN(regnr, 5, "05"), \
-	DECLARE_MSTPCRN(regnr, 4, "04"), \
-	DECLARE_MSTPCRN(regnr, 3, "03"), \
-	DECLARE_MSTPCRN(regnr, 2, "02"), \
-	DECLARE_MSTPCRN(regnr, 1, "01"), \
-	DECLARE_MSTPCRN(regnr, 0, "00")
-
-static struct clk sh7722_mstpcr[] = {
-	DECLARE_MSTPCR(0),
-	DECLARE_MSTPCR(1),
-	DECLARE_MSTPCR(2),
-};
-
 #define MSTPCR(_name, _parent, regnr, bitnr) \
 {						\
 	.name = _name,				\
@@ -885,10 +838,5 @@ int __init arch_clk_init(void)
 		clk_put(clk);
 	}
 
-	for (i = 0; i < ARRAY_SIZE(sh7722_mstpcr); i++) {
-		pr_debug( "Registering mstpcr '%s'\n", sh7722_mstpcr[i].name);
-		clk_register(&sh7722_mstpcr[i]);
-	}
-
 	return 0;
 }
--- 0011/arch/sh/kernel/cpu/sh4a/setup-sh7343.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7343.c	2008-10-31 20:10:09.000000000 +0900
@@ -141,16 +141,10 @@ static struct platform_device *sh7343_de
 
 static int __init sh7343_devices_setup(void)
 {
-	clk_always_enable("mstp031"); /* TLB */
-	clk_always_enable("mstp030"); /* IC */
-	clk_always_enable("mstp029"); /* OC */
-	clk_always_enable("mstp028"); /* URAM */
-	clk_always_enable("mstp026"); /* XYMEM */
-	clk_always_enable("mstp023"); /* INTC3 */
-	clk_always_enable("mstp022"); /* INTC */
-	clk_always_enable("mstp020"); /* SuperHyway */
-	clk_always_enable("mstp202"); /* VEU */
-	clk_always_enable("mstp201"); /* VPU */
+	clk_always_enable("uram0"); /* URAM */
+	clk_always_enable("xymem0"); /* XYMEM */
+	clk_always_enable("veu0"); /* VEU */
+	clk_always_enable("vpu0"); /* VPU */
 
 	platform_resource_setup_memory(&vpu_device, "vpu", 1 << 20);
 	platform_resource_setup_memory(&veu_device, "veu", 2 << 20);
--- 0015/arch/sh/kernel/cpu/sh4a/setup-sh7366.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7366.c	2008-10-31 20:10:09.000000000 +0900
@@ -177,17 +177,11 @@ static struct platform_device *sh7366_de
 
 static int __init sh7366_devices_setup(void)
 {
-	clk_always_enable("mstp031"); /* TLB */
-	clk_always_enable("mstp030"); /* IC */
-	clk_always_enable("mstp029"); /* OC */
-	clk_always_enable("mstp028"); /* RSMEM */
-	clk_always_enable("mstp026"); /* XYMEM */
-	clk_always_enable("mstp023"); /* INTC3 */
-	clk_always_enable("mstp022"); /* INTC */
-	clk_always_enable("mstp020"); /* SuperHyway */
-	clk_always_enable("mstp207"); /* VEU-2 */
-	clk_always_enable("mstp202"); /* VEU-1 */
-	clk_always_enable("mstp201"); /* VPU */
+	clk_always_enable("rsmem0"); /* RSMEM */
+	clk_always_enable("xymem0"); /* XYMEM */
+	clk_always_enable("veu1"); /* VEU-2 */
+	clk_always_enable("veu0"); /* VEU-1 */
+	clk_always_enable("vpu0"); /* VPU */
 
 	platform_resource_setup_memory(&vpu_device, "vpu", 2 << 20);
 	platform_resource_setup_memory(&veu0_device, "veu0", 2 << 20);
--- 0014/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7722.c	2008-10-31 20:11:06.000000000 +0900
@@ -191,15 +191,11 @@ static struct platform_device *sh7722_de
 
 static int __init sh7722_devices_setup(void)
 {
-	clk_always_enable("mstp031"); /* TLB */
-	clk_always_enable("mstp030"); /* IC */
-	clk_always_enable("mstp029"); /* OC */
-	clk_always_enable("mstp028"); /* URAM */
-	clk_always_enable("mstp026"); /* XYMEM */
-	clk_always_enable("mstp022"); /* INTC */
-	clk_always_enable("mstp020"); /* SuperHyway */
-	clk_always_enable("mstp202"); /* VEU */
-	clk_always_enable("mstp201"); /* VPU */
+	clk_always_enable("uram0"); /* URAM */
+	clk_always_enable("xymem0"); /* XYMEM */
+	clk_always_enable("rtc0"); /* RTC */
+	clk_always_enable("veu0"); /* VEU */
+	clk_always_enable("vpu0"); /* VPU */
 
 	platform_resource_setup_memory(&vpu_device, "vpu", 1 << 20);
 	platform_resource_setup_memory(&veu_device, "veu", 2 << 20);
--- 0015/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/setup-sh7723.c	2008-10-31 20:10:51.000000000 +0900
@@ -232,17 +232,11 @@ static struct platform_device *sh7723_de
 
 static int __init sh7723_devices_setup(void)
 {
-	clk_always_enable("mstp031"); /* TLB */
-	clk_always_enable("mstp030"); /* IC */
-	clk_always_enable("mstp029"); /* OC */
-	clk_always_enable("mstp024"); /* FPU */
-	clk_always_enable("mstp022"); /* INTC */
-	clk_always_enable("mstp020"); /* SuperHyway */
-	clk_always_enable("mstp000"); /* MERAM */
-	clk_always_enable("mstp108"); /* RTC */
-	clk_always_enable("mstp206"); /* VEU2H1 */
-	clk_always_enable("mstp202"); /* VEU2H0 */
-	clk_always_enable("mstp201"); /* VPU */
+	clk_always_enable("meram0"); /* MERAM */
+	clk_always_enable("rtc0"); /* RTC */
+	clk_always_enable("veu1"); /* VEU2H1 */
+	clk_always_enable("veu0"); /* VEU2H0 */
+	clk_always_enable("vpu0"); /* VPU */
 
 	platform_resource_setup_memory(&vpu_device, "vpu", 2 << 20);
 	platform_resource_setup_memory(&veu0_device, "veu0", 2 << 20);
