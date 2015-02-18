From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 18 Feb 2015 02:38:22 +0000
Subject: [PATCH 01/05] ARM: shmobile: r8a7779: Configure IRLM mode via DT
Message-Id: <20150218023822.12588.71014.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the r8a7779 SoC DTS and the Marzen Reference
C board code to use DTS only for INTC-IRQPIN IRLM setup.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Initially written on top of renesas-devel-20141202-v3.18-rc7 and
 [PATCH] ARM: shmobile: r8a7779 CCF DTS update
 however applies cleanly to renesas-devel-20150215-v3.19

 Has a runtime dependency on:
 [PATCH 01/02] irqchip: renesas-intc-irqpin: r8a7779 IRLM setup support

 arch/arm/boot/dts/r8a7779.dtsi                  |    5 +++--
 arch/arm/mach-shmobile/board-marzen-reference.c |    7 -------
 2 files changed, 3 insertions(+), 9 deletions(-)

--- 0002/arch/arm/boot/dts/r8a7779.dtsi
+++ work/arch/arm/boot/dts/r8a7779.dtsi	2014-12-03 20:27:49.000000000 +0900
@@ -139,7 +139,7 @@
 		interrupt-controller;
 	};
 
-	irqpin0: irqpin@fe780010 {
+	irqpin0: irqpin@fe780000 {
 		compatible = "renesas,intc-irqpin-r8a7779", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		status = "disabled";
@@ -148,7 +148,8 @@
 			<0xfe780010 4>,
 			<0xfe780024 4>,
 			<0xfe780044 4>,
-			<0xfe780064 4>;
+			<0xfe780064 4>,
+			<0xfe780000 4>;
 		interrupts = <0 27 IRQ_TYPE_LEVEL_HIGH
 			      0 28 IRQ_TYPE_LEVEL_HIGH
 			      0 29 IRQ_TYPE_LEVEL_HIGH
--- 0001/arch/arm/mach-shmobile/board-marzen-reference.c
+++ work/arch/arm/mach-shmobile/board-marzen-reference.c	2014-12-03 20:28:37.000000000 +0900
@@ -32,12 +32,6 @@ static void __init marzen_init_timer(voi
 	clocksource_of_init();
 }
 
-static void __init marzen_init(void)
-{
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-	r8a7779_init_irq_extpin_dt(1); /* IRQ1 as individual interrupt */
-}
-
 static const char *marzen_boards_compat_dt[] __initdata = {
 	"renesas,marzen",
 	"renesas,marzen-reference",
@@ -50,7 +44,6 @@ DT_MACHINE_START(MARZEN, "marzen")
 	.init_early	= shmobile_init_delay,
 	.init_time	= marzen_init_timer,
 	.init_irq	= r8a7779_init_irq_dt,
-	.init_machine	= marzen_init,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= marzen_boards_compat_dt,
 MACHINE_END
