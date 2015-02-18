From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 18 Feb 2015 02:39:03 +0000
Subject: [PATCH 05/05] ARM: shmobile: r8a7779: Remove unused functions
Message-Id: <20150218023903.12588.46543.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Now when the Marzen reference board code is gone we can
remove a few unused function prototypes and funtions.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/r8a7779.h       |    2 --
 arch/arm/mach-shmobile/setup-r8a7779.c |    8 ++------
 2 files changed, 2 insertions(+), 8 deletions(-)

--- 0001/arch/arm/mach-shmobile/r8a7779.h
+++ work/arch/arm/mach-shmobile/r8a7779.h	2015-02-17 02:42:26.766196792 +0900
@@ -11,14 +11,12 @@ enum {
 };
 
 extern void r8a7779_init_irq_extpin(int irlm);
-extern void r8a7779_init_irq_extpin_dt(int irlm);
 extern void r8a7779_init_irq_dt(void);
 extern void r8a7779_map_io(void);
 extern void r8a7779_earlytimer_init(void);
 extern void r8a7779_add_early_devices(void);
 extern void r8a7779_add_standard_devices(void);
 extern void r8a7779_init_late(void);
-extern u32 r8a7779_read_mode_pins(void);
 extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
 extern void r8a7779_pm_init(void);
--- 0004/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2015-02-17 02:42:48.296196715 +0900
@@ -97,7 +97,7 @@ static struct resource irqpin0_resources
 	DEFINE_RES_IRQ(gic_spi(30)), /* IRQ3 */
 };
 
-void __init r8a7779_init_irq_extpin_dt(int irlm)
+void __init r8a7779_init_irq_extpin(int irlm)
 {
 	void __iomem *icr0 = ioremap_nocache(0xfe780000, PAGE_SIZE);
 	u32 tmp;
@@ -115,11 +115,7 @@ void __init r8a7779_init_irq_extpin_dt(i
 	tmp |= (1 << 21); /* LVLMODE = 1 */
 	iowrite32(tmp, icr0);
 	iounmap(icr0);
-}
 
-void __init r8a7779_init_irq_extpin(int irlm)
-{
-	r8a7779_init_irq_extpin_dt(irlm);
 	if (irlm)
 		platform_device_register_resndata(
 			NULL, "renesas_intc_irqpin", -1,
@@ -745,7 +741,7 @@ void __init r8a7779_init_irq_dt(void)
 
 #define MODEMR		0xffcc0020
 
-u32 __init r8a7779_read_mode_pins(void)
+static u32 __init r8a7779_read_mode_pins(void)
 {
 	static u32 mode;
 	static bool mode_valid;
