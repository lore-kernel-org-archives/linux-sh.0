From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 30 Apr 2014 00:31:45 +0000
Subject: [RFC/PATCH 5/6] ARM: shmobile: lager: Enable SCIF0 and SCIF1 serial ports in DT
Message-Id: <1398817906-6023-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SCIF0 and SCIF1 are used as debug serial ports. Enable them and
configure pinmuxing appropriately. We can now remove the clkdev
registration hack for SCIF devices from the Lager reference board file.

As a side effect of switching to DT-based serial port instantiation,
ttySC6 and ttySC7 get renamed to ttySC0 and ttySC1. As the device tree
source if now shared between lager and lager-reference, we need to
update the serial ports in C code as well.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts            | 21 ++++++++++++++++++++-
 arch/arm/mach-shmobile/board-lager-reference.c | 10 ----------
 arch/arm/mach-shmobile/setup-r8a7790.c         | 10 +++++-----
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 86d676f..4913b75 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -18,6 +18,11 @@
 	model = "Lager";
 	compatible = "renesas,lager", "renesas,r8a7790";
 
+	aliases {
+		serial6 = &scif0;
+		serial7 = &scif1;
+	};
+
 	chosen {
 		bootargs = "console=ttySC6,115200 ignore_loglevel rw root=/dev/nfs ip=dhcp";
 	};
@@ -146,7 +151,7 @@
 };
 
 &pfc {
-	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins>;
+	pinctrl-0 = <&du_pins>;
 	pinctrl-names = "default";
 
 	du_pins: du {
@@ -280,6 +285,20 @@
 
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
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 1eb48cf..013c42b 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -91,16 +91,6 @@ static void __init lager_add_du_device(void)
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
-	{ "hscif0", NULL, "sh-sci.8" },
-	{ "hscif1", NULL, "sh-sci.9" },
 	{ "du0", "du.0", "rcar-du-r8a7790" },
 	{ "du1", "du.1", "rcar-du-r8a7790" },
 	{ "du2", "du.2", "rcar-du-r8a7790" },
diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index a901d9e..b22afb2 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -284,6 +284,11 @@ static const struct resource cmt00_resources[] __initconst = {
 
 void __init r8a7790_add_dt_devices(void)
 {
+	r8a7790_register_cmt(00);
+}
+
+void __init r8a7790_add_standard_devices(void)
+{
 	r8a7790_register_scif(0);
 	r8a7790_register_scif(1);
 	r8a7790_register_scif(2);
@@ -294,11 +299,6 @@ void __init r8a7790_add_dt_devices(void)
 	r8a7790_register_scif(7);
 	r8a7790_register_scif(8);
 	r8a7790_register_scif(9);
-	r8a7790_register_cmt(00);
-}
-
-void __init r8a7790_add_standard_devices(void)
-{
 	r8a7790_add_dt_devices();
 	r8a7790_register_irqc(0);
 	r8a7790_register_thermal();
-- 
1.8.3.2

