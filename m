From: Benoit Cousson <bcousson@baylibre.com>
Date: Wed, 26 Feb 2014 23:09:47 +0000
Subject: [RFC 1/4] ARM: dts: r8a7790-lager: Add VDD MPU regulator for DVFS
Message-Id: <1393456190-7870-2-git-send-email-bcousson@baylibre.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The CA15 cluster is capable of voltage scaling. Add the regulator
in the i2c3 node, to allow the generic CPUFreq driver to use it.

Enable the i2c3 pin mux and the device node as well since the
da9210 is connected to that bus.

Note: Vmin is set to 0.8v to allow experimentation only.
There is no guaranty that the CPUs will still work at this
voltage.

Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 6e99eb2..5f77e3a 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -159,6 +159,11 @@
 		renesas,groups = "qspi_ctrl", "qspi_data4";
 		renesas,function = "qspi";
 	};
+
+	i2c3_pins: i2c3 {
+		renesas,groups = "i2c3";
+		renesas,function = "i2c3";
+	};
 };
 
 &ether {
@@ -240,3 +245,19 @@
 	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3_pins>;
+	status = "okay";
+
+	vdd_dvfs: regulator@68 {
+		compatible = "diasemi,da9210";
+		reg = <0x68>;
+
+		regulator-min-microvolt = <800000>;
+		regulator-max-microvolt = <1000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
-- 
1.8.3.2

