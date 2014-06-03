From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Tue, 03 Jun 2014 12:02:12 +0000
Subject: [PATCH v2 1/8] ARM: shmobile: lager: Add VDD MPU regulator for DVFS
Message-Id: <538DB944.4060000@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Benoit Cousson <bcousson@baylibre.com>

The CA15 cluster is capable of voltage scaling. Add the regulator
in the i2c3 node, to allow the generic CPUFreq driver to use it.

Enable the i2c3 pin mux and the device node as well since the
da9210 is connected to that bus.

Note: In R-CAR Gen2, each frequency is using the same voltage,
and DVS control is not used. Therefore, this patch set the
voltage(Vmin/Vmax) to 1000mv.

Signed-off-by: Benoit Cousson <bcousson@baylibre.com>
[gaku.inami.xw@bp.renesas.com: Changes Vmin for disabling DVS]
Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
---

Changes since version 1:
- added this patch for enabling da9210 regulator.
- fixed subject.

 arch/arm/boot/dts/r8a7790-lager.dts |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 9becef7..8428204 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -204,6 +204,11 @@
 				 "msiof1_tx";
 		renesas,function = "msiof1";
 	};
+
+	i2c3_pins: i2c3 {
+		renesas,groups = "i2c3";
+		renesas,function = "i2c3";
+	};
 };
 
 &ether {
@@ -317,3 +322,19 @@
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
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <1000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+};
-- 
1.7.9.5

