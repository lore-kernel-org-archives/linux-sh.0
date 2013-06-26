From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 26 Jun 2013 13:50:34 +0000
Subject: [PATCH v2] ARM: shmobile: APE6EVM: add MMCIF and SDHI support
Message-Id: <Pine.LNX.4.64.1306261546570.8856@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds all SDHI and MMCIF DT nodes to r8a73a4. On APE6EVM only
SDHI0, SDHI1 and MMCIF0 are available. For these interfaces DT nodes are
enabled and pinmux settings are activated.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---

Pinmux configuration is still done via .c, dummy regulator support, no 
GPIO card detection. All this should be fixed as soon as pinctrl DT is 
available on r8a73a4.

v2: now uses DT.

 arch/arm/boot/dts/r8a73a4-ape6evm.dts  |   22 +++++++++++++++
 arch/arm/boot/dts/r8a73a4.dtsi         |   45 ++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/board-ape6evm.c |   17 ++++++++++++
 3 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 27c5e06..a4553b2 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -74,3 +74,25 @@
 	>;
 	voltage-tolerance = <1>; /* 1% */
 };
+
+&mmcif0 {
+	vmmc-supply = <&ape6evm_fixed_3v3>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&sdhi0 {
+	vmmc-supply = <&ape6evm_fixed_3v3>;
+	bus-width = <4>;
+	toshiba,mmc-wrprotect-disable;
+	status = "okay";
+};
+
+&sdhi1 {
+	vmmc-supply = <&ape6evm_fixed_3v3>;
+	bus-width = <4>;
+	broken-cd;
+	toshiba,mmc-wrprotect-disable;
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 4e1ddf0..064f045 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -166,4 +166,49 @@
 		interrupt-parent = <&gic>;
 		interrupts = <0 173 0x4>;
 	};
+
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
+	sdhi2: sdhi@ee140000 {
+		compatible = "renesas,r8a7740-sdhi";
+		reg = <0 0xee140000 0 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 167 4>;
+		cap-sd-highspeed;
+		status = "disabled";
+	};
 };
diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 5eb0caa..716f2f7 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -62,6 +62,23 @@ static const struct pinctrl_map ape6evm_pinctrl_map[] = {
 	/* SMSC */
 	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-r8a73a4",
 				  "irqc_irq40", "irqc"),
+	/* SDHI0: uSD: no WP */
+	PIN_MAP_MUX_GROUP_DEFAULT("ee100000.sdhi", "pfc-r8a73a4",
+				  "sdhi0_data4", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("ee100000.sdhi", "pfc-r8a73a4",
+				  "sdhi0_ctrl", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("ee100000.sdhi", "pfc-r8a73a4",
+				  "sdhi0_cd", "sdhi0"),
+	/* SDHI1 */
+	PIN_MAP_MUX_GROUP_DEFAULT("ee120000.sdhi", "pfc-r8a73a4",
+				  "sdhi1_data4", "sdhi1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("ee120000.sdhi", "pfc-r8a73a4",
+				  "sdhi1_ctrl", "sdhi1"),
+	/* MMCIF0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("ee200000.mmcif", "pfc-r8a73a4",
+				  "mmc0_data8", "mmc0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("ee200000.mmcif", "pfc-r8a73a4",
+				  "mmc0_ctrl", "mmc0"),
 };
 
 static void __init ape6evm_add_standard_devices(void)
-- 
1.7.2.5

