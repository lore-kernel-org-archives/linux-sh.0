From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Jun 2015 08:58:23 +0000
Subject: [PATCH v2 06/06] ARM: shmobile: r8a7779: Cleanup header file
Message-Id: <20150625085823.24543.23737.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Remove unused function prototypes from r8a7779.h and
make the functions static.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---

 Changes since V1:
 - left r8a7779_read_mode_pins() since it used by legacy clock code
 - removed r8a7779_clock_init() from the header file

 arch/arm/mach-shmobile/clock-r8a7779.c |    2 +-
 arch/arm/mach-shmobile/r8a7779.h       |    2 --
 arch/arm/mach-shmobile/setup-r8a7779.c |    2 +-
 3 files changed, 2 insertions(+), 4 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-r8a7779.c
+++ work/arch/arm/mach-shmobile/clock-r8a7779.c	2015-06-25 17:18:28.972366518 +0900
@@ -201,7 +201,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("rcar-du-r8a7779", &mstp_clks[MSTP103]), /* DU */
 };
 
-void __init r8a7779_clock_init(void)
+static void __init r8a7779_clock_init(void)
 {
 	u32 mode = r8a7779_read_mode_pins();
 	int k, ret = 0;
--- 0001/arch/arm/mach-shmobile/r8a7779.h
+++ work/arch/arm/mach-shmobile/r8a7779.h	2015-06-25 17:18:28.972366518 +0900
@@ -11,7 +11,6 @@ enum {
 };
 
 extern void r8a7779_init_irq_extpin(int irlm);
-extern void r8a7779_init_irq_extpin_dt(int irlm);
 extern void r8a7779_init_irq_dt(void);
 extern void r8a7779_map_io(void);
 extern void r8a7779_earlytimer_init(void);
@@ -19,7 +18,6 @@ extern void r8a7779_add_early_devices(vo
 extern void r8a7779_add_standard_devices(void);
 extern void r8a7779_init_late(void);
 extern u32 r8a7779_read_mode_pins(void);
-extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
 extern void r8a7779_pm_init(void);
 extern void r8a7779_register_twd(void);
--- 0004/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2015-06-25 17:18:28.972366518 +0900
@@ -99,7 +99,7 @@ static struct resource irqpin0_resources
 	DEFINE_RES_IRQ(gic_spi(30)), /* IRQ3 */
 };
 
-void __init r8a7779_init_irq_extpin_dt(int irlm)
+static void __init r8a7779_init_irq_extpin_dt(int irlm)
 {
 	void __iomem *icr0 = ioremap_nocache(0xfe780000, PAGE_SIZE);
 	u32 tmp;
