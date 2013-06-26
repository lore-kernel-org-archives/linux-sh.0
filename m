From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 26 Jun 2013 14:05:53 +0000
Subject: [PATCH/RFC] ARM: shmobile: Lager: add MMCIF and SDHI support
Message-Id: <Pine.LNX.4.64.1306261603420.8856@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds all SDHI and MMCIF DT nodes to r8a7790. On Lager only
SDHI0, SDHI2 and MMCIF1 are available. For these interfaces DT nodes are
enabled and pinmux settings are activated.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

RFC because it couldn't be tested properly due to hardware access 
restrictions. Similar comments as for APE6EVM apply: dummy regulator and 
no GPIO CD, pinmux in .c due to missing pinctrl DT support on r8a7790

 arch/arm/boot/dts/r8a7790-lager.dts  |   28 +++++++++++++++++
 arch/arm/boot/dts/r8a7790.dtsi       |   56 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/board-lager.c |   23 ++++++++++++++
 3 files changed, 107 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 09a84fc..e6b2c17 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -28,4 +28,32 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 	};
+
+	reg_3p3v: regulator@0 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+};
+
+&mmcif1 {
+	vmmc-supply = <&reg_3p3v>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&sdhi0 {
+	vmmc-supply = <&reg_3p3v>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&sdhi2 {
+	vmmc-supply = <&reg_3p3v>;
+	bus-width = <4>;
+	status = "okay";
 };
diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 339d9b1..18d818f 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -54,4 +54,60 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 0 4>, <0 1 4>, <0 2 4>,	<0 3 4>;
 	};
+
+	/* No MMC_CAP_UHS_DDR50 (dual data rate) capability on r8a7790! */
+	mmcif0: mmcif@ee200000 {
+		compatible = "renesas,sh-mmcif";
+		reg = <0 0xee200000 0 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 169 0x4>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	mmcif1: mmcif@ee220000 {
+		compatible = "renesas,sh-mmcif";
+		reg = <0 0xee220000 0 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 170 0x4>;
+		reg-io-width = <4>;
+		status = "disabled";
+	};
+
+	sdhi0: sdhi@ee100000 {
+		compatible = "renesas,r8a7740-sdhi";
+		reg = <0 0xee100000 0 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 165 4>;
+		cap-sd-highspeed;
+		status = "disabled";
+	};
+
+	sdhi1: sdhi@ee120000 {
+		compatible = "renesas,r8a7740-sdhi";
+		reg = <0 0xee120000 0 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 166 4>;
+		cap-sd-highspeed;
+		status = "disabled";
+	};
+
+	/* What are SDHI2 C2 and SDHI3 C2 controllers? */
+	sdhi2: sdhi@ee140000 {
+		compatible = "renesas,r8a7740-sdhi";
+		reg = <0 0xee140000 0 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 167 4>;
+		cap-sd-highspeed;
+		status = "disabled";
+	};
+
+	sdhi3: sdhi@ee160000 {
+		compatible = "renesas,r8a7740-sdhi";
+		reg = <0 0xee160000 0 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 168 4>;
+		cap-sd-highspeed;
+		status = "disabled";
+	};
 };
diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index d73e21d..2e44479 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -78,6 +78,29 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* SCIF1 (CN20: DEBUG SERIAL1) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.7", "pfc-r8a7790",
 				  "scif1_data", "scif1"),
+	/* SDHI0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("ee100000.sdhi", "pfc-r8a7790",
+				  "sdhi0_data4", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("ee100000.sdhi", "pfc-r8a7790",
+				  "sdhi0_ctrl", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("ee100000.sdhi", "pfc-r8a7790",
+				  "sdhi0_wp", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("ee100000.sdhi", "pfc-r8a7790",
+				  "sdhi0_cd", "sdhi0"),
+	/* SDHI2 */
+	PIN_MAP_MUX_GROUP_DEFAULT("ee140000.sdhi", "pfc-r8a7790",
+				  "sdhi2_data4", "sdhi2"),
+	PIN_MAP_MUX_GROUP_DEFAULT("ee140000.sdhi", "pfc-r8a7790",
+				  "sdhi2_ctrl", "sdhi2"),
+	PIN_MAP_MUX_GROUP_DEFAULT("ee140000.sdhi", "pfc-r8a7790",
+				  "sdhi2_wp", "sdhi2"),
+	PIN_MAP_MUX_GROUP_DEFAULT("ee140000.sdhi", "pfc-r8a7790",
+				  "sdhi2_cd", "sdhi2"),
+	/* MMCIF1 */
+	PIN_MAP_MUX_GROUP_DEFAULT("ee220000.mmcif", "pfc-r8a7790",
+				  "mmc1_data8", "mmc1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("ee220000.mmcif", "pfc-r8a7790",
+				  "mmc1_ctrl", "mmc1"),
 };
 
 static void __init lager_add_standard_devices(void)
-- 
1.7.2.5

