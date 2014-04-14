From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 14 Apr 2014 10:36:38 +0000
Subject: [PATCH v3 3/7] r8a7790.dtsi: add vin[0-3] nodes
Message-Id: <1397471802-27216-4-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add nodes for the four video input channels on the R8A7790.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/dts/r8a7790.dtsi | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index a1e7c39..de0e53e 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -23,6 +23,10 @@
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
 		i2c3 = &i2c3;
+		vin0 = &vin0;
+		vin1 = &vin1;
+		vin2 = &vin2;
+		vin3 = &vin3;
 	};
 
 	cpus {
@@ -395,6 +399,38 @@
 		status = "disabled";
 	};
 
+	vin0: vin@0xe6ef0000 {
+		compatible = "renesas,vin-r8a7790";
+		clocks = <&mstp8_clks R8A7790_CLK_VIN0>;
+		reg = <0 0xe6ef0000 0 0x1000>;
+		interrupts = <0 188 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	vin1: vin@0xe6ef1000 {
+		compatible = "renesas,vin-r8a7790";
+		clocks = <&mstp8_clks R8A7790_CLK_VIN1>;
+		reg = <0 0xe6ef1000 0 0x1000>;
+		interrupts = <0 189 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	vin2: vin@0xe6ef2000 {
+		compatible = "renesas,vin-r8a7790";
+		clocks = <&mstp8_clks R8A7790_CLK_VIN2>;
+		reg = <0 0xe6ef2000 0 0x1000>;
+		interrupts = <0 190 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	vin3: vin@0xe6ef3000 {
+		compatible = "renesas,vin-r8a7790";
+		clocks = <&mstp8_clks R8A7790_CLK_VIN3>;
+		reg = <0 0xe6ef3000 0 0x1000>;
+		interrupts = <0 191 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
1.9.1

