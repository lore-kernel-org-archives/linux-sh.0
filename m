From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 17 May 2013 14:55:18 +0000
Subject: [PATCH 7/9] ARM: shmobile: APE6EVM: add MMCIF and SDHI DT nodes
Message-Id: <1368802520-16378-8-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This patch adds all MMCIF and SDHI devices to r8a73a4.dtsi in the "disabled"
state, those of them, available on APE6EVM, are then added to the board DT.
This version assignes fixed regulators to all the interfaces, in future
versions support for regulators should be added.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts |   46 +++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a73a4.dtsi        |   45 ++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index b5b24eb..63eaf5a 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -53,6 +53,37 @@
 	};
 };
 
+&mmcif0 {
+	pinctrl-0 = <&mmcif0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&ape6evm_fixed_3v3>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&ape6evm_fixed_3v3>;
+	bus-width = <4>;
+	toshiba,mmc-wrprotect-disable;
+	status = "okay";
+};
+
+&sdhi1 {
+	pinctrl-0 = <&sdhi1_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&ape6evm_fixed_3v3>;
+	bus-width = <4>;
+	broken-cd;
+	toshiba,mmc-wrprotect-disable;
+	status = "okay";
+};
+
 &pfc {
 	pinctrl-0 = <&scifa0_pins>;
 	pinctrl-names = "default";
@@ -61,4 +92,19 @@
 		renesas,groups = "scifa0_data";
 		renesas,function = "scifa0";
 	};
+
+	mmcif0_pins: mmcif0 {
+		renesas,groups = "mmc0_data8", "mmc0_ctrl";
+		renesas,function = "mmc0";
+	};
+
+	sdhi0_pins: sdhi0 {
+		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd", "sdhi0_wp";
+		renesas,function = "sdhi0";
+	};
+
+	sdhi1_pins: sdhi1 {
+		renesas,groups = "sdhi1_data4", "sdhi1_ctrl";
+		renesas,function = "sdhi1";
+	};
 };
diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 6e73367..33c9bac 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -98,4 +98,49 @@
 		gpio-controller;
 		#gpio-cells = <2>;
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
-- 
1.7.2.5

