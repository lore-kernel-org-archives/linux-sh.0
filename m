From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Date: Fri, 09 Jan 2015 15:43:50 +0000
Subject: [PATCH v4 6/7] ARM: zynq: DT: Add pinctrl information
Message-Id: <1420818231-13451-7-git-send-email-soren.brinkmann@xilinx.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1420818231-13451-1-git-send-email-soren.brinkmann@xilinx.com>
In-Reply-To: <1420818231-13451-1-git-send-email-soren.brinkmann@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Add pinctrl descriptions to the zc702 and zc706 device trees.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
Tested-by: Andreas F=C3=A4rber <afaerber@suse.de>
---
Changes since v1:
 - remove 'pinctrl-' prefix for pinctrl sub-nodes
 - separate config and mux nodes

Changes since RFC v2:
 - add pinconf properties to zc702 mdio node
 - remove arguments from bias-related props

Changes since RFC v1:
 - separate DT changes into their own patch
---
 arch/arm/boot/dts/zynq-7000.dtsi |   8 +-
 arch/arm/boot/dts/zynq-zc702.dts | 181 +++++++++++++++++++++++++++++++++++=
++++
 arch/arm/boot/dts/zynq-zc706.dts | 152 ++++++++++++++++++++++++++++++++
 3 files changed, 340 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000=
.dtsi
index ee3e5d675b05..9a19a319b0f1 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -237,7 +237,7 @@
 		slcr: slcr@f8000000 {
 			#address-cells =3D <1>;
 			#size-cells =3D <1>;
-			compatible =3D "xlnx,zynq-slcr", "syscon";
+			compatible =3D "xlnx,zynq-slcr", "syscon", "simple-bus";
 			reg =3D <0xF8000000 0x1000>;
 			ranges;
 			clkc: clkc@100 {
@@ -257,6 +257,12 @@
 						"dbg_trc", "dbg_apb";
 				reg =3D <0x100 0x100>;
 			};
+
+			pinctrl0: pinctrl@700 {
+				compatible =3D "xlnx,pinctrl-zynq";
+				reg =3D <0x700 0x200>;
+				syscon =3D <&slcr>;
+			};
 		};
=20
 		dmac_s: dmac@f8003000 {
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc70=
2.dts
index 280f02dd4ddc..4995412f116f 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -40,6 +40,8 @@
=20
 &can0 {
 	status =3D "okay";
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_can0_default>;
 };
=20
 &clkc {
@@ -50,15 +52,24 @@
 	status =3D "okay";
 	phy-mode =3D "rgmii-id";
 	phy-handle =3D <&ethernet_phy>;
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_gem0_default>;
=20
 	ethernet_phy: ethernet-phy@7 {
 		reg =3D <7>;
 	};
 };
=20
+&gpio0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_gpio0_default>;
+};
+
 &i2c0 {
 	status =3D "okay";
 	clock-frequency =3D <400000>;
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_i2c0_default>;
=20
 	i2cswitch@74 {
 		compatible =3D "nxp,pca9548";
@@ -132,10 +143,180 @@
 	};
 };
=20
+&pinctrl0 {
+	pinctrl_can0_default: can0-default {
+		mux {
+			function =3D "can0";
+			groups =3D "can0_9_grp";
+		};
+
+		conf {
+			groups =3D "can0_9_grp";
+			slew-rate =3D <0>;
+			io-standard =3D <1>;
+		};
+
+		conf-rx {
+			pins =3D "MIO46";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins =3D "MIO47";
+			bias-disable;
+		};
+	};
+
+	pinctrl_gem0_default: gem0-default {
+		mux {
+			function =3D "ethernet0";
+			groups =3D "ethernet0_0_grp";
+		};
+
+		conf {
+			groups =3D "ethernet0_0_grp";
+			slew-rate =3D <0>;
+			io-standard =3D <4>;
+		};
+
+		conf-rx {
+			pins =3D "MIO22", "MIO23", "MIO24", "MIO25", "MIO26", "MIO27";
+			bias-high-impedance;
+			low-power-disable;
+		};
+
+		conf-tx {
+			pins =3D "MIO16", "MIO17", "MIO18", "MIO19", "MIO20", "MIO21";
+			bias-disable;
+			low-power-enable;
+		};
+
+		mux-mdio {
+			function =3D "mdio0";
+			groups =3D "mdio0_0_grp";
+		};
+
+		conf-mdio {
+			groups =3D "mdio0_0_grp";
+			slew-rate =3D <0>;
+			io-standard =3D <1>;
+			bias-disable;
+		};
+	};
+
+	pinctrl_gpio0_default: gpio0-default {
+		mux {
+			function =3D "gpio0";
+			groups =3D "gpio0_7_grp", "gpio0_8_grp", "gpio0_9_grp",
+				 "gpio0_10_grp", "gpio0_11_grp", "gpio0_12_grp",
+				 "gpio0_13_grp", "gpio0_14_grp";
+		};
+
+		conf {
+			groups =3D "gpio0_7_grp", "gpio0_8_grp", "gpio0_9_grp",
+				 "gpio0_10_grp", "gpio0_11_grp", "gpio0_12_grp",
+				 "gpio0_13_grp", "gpio0_14_grp";
+			slew-rate =3D <0>;
+			io-standard =3D <1>;
+		};
+
+		conf-pull-up {
+			pins =3D "MIO9", "MIO10", "MIO11", "MIO12", "MIO13", "MIO14";
+			bias-pull-up;
+		};
+
+		conf-pull-none {
+			pins =3D "MIO7", "MIO8";
+			bias-disable;
+		};
+	};
+
+	pinctrl_i2c0_default: i2c0-default {
+		mux {
+			groups =3D "i2c0_10_grp";
+			function =3D "i2c0";
+		};
+
+		conf {
+			groups =3D "i2c0_10_grp";
+			bias-pull-up;
+			slew-rate =3D <0>;
+			io-standard =3D <1>;
+		};
+	};
+
+	pinctrl_sdhci0_default: sdhci0-default {
+		mux {
+			groups =3D "sdio0_2_grp";
+			function =3D "sdio0";
+		};
+
+		conf {
+			groups =3D "sdio0_2_grp";
+			slew-rate =3D <0>;
+			io-standard =3D <1>;
+			bias-disable;
+		};
+
+		mux-cd {
+			groups =3D "gpio0_0_grp";
+			function =3D "sdio0_cd";
+		};
+
+		conf-cd {
+			groups =3D "gpio0_0_grp";
+			bias-high-impedance;
+			bias-pull-up;
+			slew-rate =3D <0>;
+			io-standard =3D <1>;
+		};
+
+		mux-wp {
+			groups =3D "gpio0_15_grp";
+			function =3D "sdio0_wp";
+		};
+
+		conf-wp {
+			groups =3D "gpio0_15_grp";
+			bias-high-impedance;
+			bias-pull-up;
+			slew-rate =3D <0>;
+			io-standard =3D <1>;
+		};
+	};
+
+	pinctrl_uart1_default: uart1-default {
+		mux {
+			groups =3D "uart1_10_grp";
+			function =3D "uart1";
+		};
+
+		conf {
+			groups =3D "uart1_10_grp";
+			slew-rate =3D <0>;
+			io-standard =3D <1>;
+		};
+
+		conf-rx {
+			pins =3D "MIO49";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins =3D "MIO48";
+			bias-disable =3D <0>;
+		};
+	};
+};
+
 &sdhci0 {
 	status =3D "okay";
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_sdhci0_default>;
 };
=20
 &uart1 {
 	status =3D "okay";
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_uart1_default>;
 };
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc70=
6.dts
index 34f7812d2ee8..af590d2bb046 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -37,15 +37,24 @@
 	status =3D "okay";
 	phy-mode =3D "rgmii-id";
 	phy-handle =3D <&ethernet_phy>;
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_gem0_default>;
=20
 	ethernet_phy: ethernet-phy@7 {
 		reg =3D <7>;
 	};
 };
=20
+&gpio0 {
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_gpio0_default>;
+};
+
 &i2c0 {
 	status =3D "okay";
 	clock-frequency =3D <400000>;
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_i2c0_default>;
=20
 	i2cswitch@74 {
 		compatible =3D "nxp,pca9548";
@@ -111,10 +120,153 @@
 	};
 };
=20
+&pinctrl0 {
+	pinctrl_gem0_default: gem0-default {
+		mux {
+			function =3D "ethernet0";
+			groups =3D "ethernet0_0_grp";
+		};
+
+		conf {
+			groups =3D "ethernet0_0_grp";
+			slew-rate =3D <0>;
+			io-standard =3D <4>;
+		};
+
+		conf-rx {
+			pins =3D "MIO22", "MIO23", "MIO24", "MIO25", "MIO26", "MIO27";
+			bias-high-impedance;
+			low-power-disable;
+		};
+
+		conf-tx {
+			pins =3D "MIO16", "MIO17", "MIO18", "MIO19", "MIO20", "MIO21";
+			low-power-enable;
+			bias-disable;
+		};
+
+		mux-mdio {
+			function =3D "mdio0";
+			groups =3D "mdio0_0_grp";
+		};
+
+		conf-mdio {
+			groups =3D "mdio0_0_grp";
+			slew-rate =3D <0>;
+			io-standard =3D <1>;
+			bias-disable;
+		};
+	};
+
+	pinctrl_gpio0_default: gpio0-default {
+		mux {
+			function =3D "gpio0";
+			groups =3D "gpio0_7_grp", "gpio0_46_grp", "gpio0_47_grp";
+		};
+
+		conf {
+			groups =3D "gpio0_7_grp", "gpio0_46_grp", "gpio0_47_grp";
+			slew-rate =3D <0>;
+			io-standard =3D <1>;
+		};
+
+		conf-pull-up {
+			pins =3D "MIO46", "MIO47";
+			bias-pull-up;
+		};
+
+		conf-pull-none {
+			pins =3D "MIO7";
+			bias-disable;
+		};
+	};
+
+	pinctrl_i2c0_default: i2c0-default {
+		mux {
+			groups =3D "i2c0_10_grp";
+			function =3D "i2c0";
+		};
+
+		conf {
+			groups =3D "i2c0_10_grp";
+			bias-pull-up;
+			slew-rate =3D <0>;
+			io-standard =3D <1>;
+		};
+	};
+
+	pinctrl_sdhci0_default: sdhci0-default {
+		mux {
+			groups =3D "sdio0_2_grp";
+			function =3D "sdio0";
+		};
+
+		conf {
+			groups =3D "sdio0_2_grp";
+			slew-rate =3D <0>;
+			io-standard =3D <1>;
+			bias-disable;
+		};
+
+		mux-cd {
+			groups =3D "gpio0_14_grp";
+			function =3D "sdio0_cd";
+		};
+
+		conf-cd {
+			groups =3D "gpio0_14_grp";
+			bias-high-impedance;
+			bias-pull-up;
+			slew-rate =3D <0>;
+			io-standard =3D <1>;
+		};
+
+		mux-wp {
+			groups =3D "gpio0_15_grp";
+			function =3D "sdio0_wp";
+		};
+
+		conf-wp {
+			groups =3D "gpio0_15_grp";
+			bias-high-impedance;
+			bias-pull-up;
+			slew-rate =3D <0>;
+			io-standard =3D <1>;
+		};
+	};
+
+	pinctrl_uart1_default: uart1-default {
+		mux {
+			groups =3D "uart1_10_grp";
+			function =3D "uart1";
+		};
+
+		conf {
+			groups =3D "uart1_10_grp";
+			slew-rate =3D <0>;
+			io-standard =3D <1>;
+		};
+
+		conf-rx {
+			pins =3D "MIO49";
+			bias-high-impedance;
+		};
+
+		conf-tx {
+			pins =3D "MIO48";
+			bias-disable;
+		};
+	};
+};
+
 &sdhci0 {
 	status =3D "okay";
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_sdhci0_default>;
 };
=20
 &uart1 {
 	status =3D "okay";
+	pinctrl-names =3D "default";
+	pinctrl-0 =3D <&pinctrl_uart1_default>;
 };
--=20
2.2.1.1.gb42cc81

