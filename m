From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 30 Apr 2014 00:31:46 +0000
Subject: [RFC/PATCH 6/6] ARM: shmobile: koelsch: Enable SCIF0 and SCIF1 serial ports in DT
Message-Id: <1398817906-6023-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SCIF0 and SCIF1 are used as debug serial ports. Enable them and
configure pinmuxing appropriately. We can now remove the clkdev
registration hack for SCIF devices from the Koelsch reference board
file.

As a side effect of switching to DT-based serial port instantiation,
ttySC6 and ttySC7 get renamed to ttySC0 and ttySC1. As the device tree
source if now shared between koelsch and koelsch-reference, we need to
update the serial ports in C code as well.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts            | 16 +++++++++++++++-
 arch/arm/mach-shmobile/board-koelsch-reference.c | 15 ---------------
 arch/arm/mach-shmobile/setup-r8a7791.c           | 10 +++++-----
 3 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 0d69813..99a4452 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -230,7 +230,7 @@
 };
 
 &pfc {
-	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins>;
+	pinctrl-0 = <&du_pins>;
 	pinctrl-names = "default";
 
 	i2c2_pins: i2c2 {
@@ -310,6 +310,20 @@
 	status = "okay";
 };
 
+&scif0 {
+	pinctrl-0 = <&scif0_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&scif1 {
+	pinctrl-0 = <&scif1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
 &sdhi0 {
 	pinctrl-0 = <&sdhi0_pins>;
 	pinctrl-names = "default";
diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index 941f8b3..2edeb64 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -87,21 +87,6 @@ static void __init koelsch_add_du_device(void)
  */
 static const struct clk_name clk_names[] __initconst = {
 	{ "cmt0", NULL, "sh_cmt.0" },
-	{ "scifa0", NULL, "sh-sci.0" },
-	{ "scifa1", NULL, "sh-sci.1" },
-	{ "scifb0", NULL, "sh-sci.2" },
-	{ "scifb1", NULL, "sh-sci.3" },
-	{ "scifb2", NULL, "sh-sci.4" },
-	{ "scifa2", NULL, "sh-sci.5" },
-	{ "scif0", NULL, "sh-sci.6" },
-	{ "scif1", NULL, "sh-sci.7" },
-	{ "scif2", NULL, "sh-sci.8" },
-	{ "scif3", NULL, "sh-sci.9" },
-	{ "scif4", NULL, "sh-sci.10" },
-	{ "scif5", NULL, "sh-sci.11" },
-	{ "scifa3", NULL, "sh-sci.12" },
-	{ "scifa4", NULL, "sh-sci.13" },
-	{ "scifa5", NULL, "sh-sci.14" },
 	{ "du0", "du.0", "rcar-du-r8a7791" },
 	{ "du1", "du.1", "rcar-du-r8a7791" },
 	{ "lvds0", "lvds.0", "rcar-du-r8a7791" },
diff --git a/arch/arm/mach-shmobile/setup-r8a7791.c b/arch/arm/mach-shmobile/setup-r8a7791.c
index a7e4966..51b0f77 100644
--- a/arch/arm/mach-shmobile/setup-r8a7791.c
+++ b/arch/arm/mach-shmobile/setup-r8a7791.c
@@ -185,6 +185,11 @@ static const struct resource thermal_resources[] __initconst = {
 
 void __init r8a7791_add_dt_devices(void)
 {
+	r8a7791_register_cmt(00);
+}
+
+void __init r8a7791_add_standard_devices(void)
+{
 	r8a7791_register_scif(0);
 	r8a7791_register_scif(1);
 	r8a7791_register_scif(2);
@@ -200,11 +205,6 @@ void __init r8a7791_add_dt_devices(void)
 	r8a7791_register_scif(12);
 	r8a7791_register_scif(13);
 	r8a7791_register_scif(14);
-	r8a7791_register_cmt(00);
-}
-
-void __init r8a7791_add_standard_devices(void)
-{
 	r8a7791_add_dt_devices();
 	r8a7791_register_irqc(0);
 	r8a7791_register_thermal();
-- 
1.8.3.2

