From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 19 Jul 2013 15:30:20 +0000
Subject: [PATCH 1/2] ARM: shmobile: ape6evm-reference: switch PFC to DT
Message-Id: <Pine.LNX.4.64.1307191723470.26183@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

PFC pinctrl configuration can now be performed via DT. Update
ape6evm-reference to use this.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts  |   10 ++++++++++
 arch/arm/mach-shmobile/board-ape6evm-reference.c |    9 ---------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
index 6f4506e..bbd09d8 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
@@ -53,3 +53,13 @@
 	>;
 	voltage-tolerance = <1>; /* 1% */
 };
+
+&pfc {
+	pinctrl-0 = <&scifa0_pins>;
+	pinctrl-names = "default";
+
+	scifa0_pins: scifa0 {
+		renesas,groups = "scifa0_data";
+		renesas,function = "scifa0";
+	};
+};
diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
index 46b41de..52cc5fa 100644
--- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
@@ -29,12 +29,6 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-static const struct pinctrl_map ape6evm_pinctrl_map[] = {
-	/* SCIFA0 console */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a73a4",
-				  "scifa0_data", "scifa0"),
-};
-
 static void __init ape6evm_add_standard_devices(void)
 {
 
@@ -52,9 +46,6 @@ static void __init ape6evm_add_standard_devices(void)
 	clk_put(parent);
 	clk_put(mp);
 
-	pinctrl_register_mappings(ape6evm_pinctrl_map,
-				  ARRAY_SIZE(ape6evm_pinctrl_map));
-	r8a73a4_pinmux_init();
 	r8a73a4_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
-- 
1.7.2.5

