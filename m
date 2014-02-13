From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 13 Feb 2014 04:30:27 +0000
Subject: [PATCH 2/2 v3] ARM: shmobile: lager: add SDHI0/2 support on DTS
Message-Id: <87d2ird47z.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - based on topic/r-car-sdhi
 - it is using cd-gpios to avoid pm-runtime issue

 arch/arm/boot/dts/r8a7790-lager.dts |   86 +++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 1081c5e..d66f073 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -56,6 +56,54 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	vcc_sdhi0: regulator@1 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI0 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio5 24 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhi0: regulator@2 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI0 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio5 29 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1
+			  1800000 0>;
+	};
+
+	vcc_sdhi2: regulator@3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "SDHI2 Vcc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&gpio5 25 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+
+	vccq_sdhi2: regulator@4 {
+		compatible = "regulator-gpio";
+
+		regulator-name = "SDHI2 VccQ";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpios = <&gpio5 30 GPIO_ACTIVE_HIGH>;
+		gpios-states = <1>;
+		states = <3300000 1
+			  1800000 0>;
+	};
 };
 
 &extal_clk {
@@ -76,6 +124,16 @@
 		renesas,function = "scif1";
 	};
 
+	sdhi0_pins: sd0 {
+		renesas,gpios = "sdhi0_data4", "sdhi0_ctrl";
+		renesas,function = "sdhi0";
+	};
+
+	sdhi2_pins: sd2 {
+		renesas,gpios = "sdhi2_data4", "sdhi2_ctrl";
+		renesas,function = "sdhi2";
+	};
+
 	mmc1_pins: mmc1 {
 		renesas,groups = "mmc1_data8", "mmc1_ctrl";
 		renesas,function = "mmc1";
@@ -95,3 +153,31 @@
 &sata1 {
 	status = "okay";
 };
+
+&sdhi0 {
+	pinctrl-0 = <&sdhi0_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&vcc_sdhi0>;
+	vqmmc-supply = <&vccq_sdhi0>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	cap-power-off-card;
+	toshiba,mmc-wrprotect-disable;
+	cd-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&sdhi2 {
+	pinctrl-0 = <&sdhi2_pins>;
+	pinctrl-names = "default";
+
+	vmmc-supply = <&vcc_sdhi2>;
+	vqmmc-supply = <&vccq_sdhi2>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	cap-power-off-card;
+	toshiba,mmc-wrprotect-disable;
+	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
-- 
1.7.9.5

