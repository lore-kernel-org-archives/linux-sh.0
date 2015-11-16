From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 16 Nov 2015 08:57:29 +0000
Subject: [PATCH v2 03/03] ARM: shmobile: r8a7794: alt: Enable VGA port
Message-Id: <20151116085729.7119.93398.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Enable the DU device and the VGA port available on the r8a7794
ALT board. The VGA portion of the ALT board is somewhat similar
to the Lager board but in case of ALT the DU1 pins are used
and the X2 clock has a reduced frequency.

This patch does not include any pinctrl (PFC) settings due to lack
of PFC DT integration on r8a7794. At this point the default state
of the boot loader is enough to keep the VGA port working without
changing any pinctrl settings.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V1:
 - Updated to fit on r8a7794 DU patches from Laurent

 arch/arm/boot/dts/r8a7794-alt.dts |   61 +++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7794-alt.dts
+++ work/arch/arm/boot/dts/r8a7794-alt.dts	2015-11-16 11:24:24.350513000 +0900
@@ -33,6 +33,67 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 	};
+
+	vga-encoder {
+		compatible = "adi,adv7123";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				adv7123_in: endpoint {
+					remote-endpoint = <&du_out_rgb1>;
+				};
+			};
+			port@1 {
+				reg = <1>;
+				adv7123_out: endpoint {
+					remote-endpoint = <&vga_in>;
+				};
+			};
+		};
+	};
+
+	vga {
+		compatible = "vga-connector";
+
+		port {
+			vga_in: endpoint {
+				remote-endpoint = <&adv7123_out>;
+			};
+		};
+	};
+
+	x2_clk: x2-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <74250000>;
+	};
+
+	x13_clk: x13-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <148500000>;
+	};
+};
+
+&du {
+	status = "okay";
+
+	clocks = <&mstp7_clks R8A7794_CLK_DU0>,
+		 <&mstp7_clks R8A7794_CLK_DU0>,
+		 <&x13_clk>, <&x2_clk>;
+	clock-names = "du.0", "du.1", "dclkin.0", "dclkin.1";
+
+	ports {
+		port@1 {
+			endpoint {
+				remote-endpoint = <&adv7123_in>;
+			};
+		};
+	};
 };
 
 &extal_clk {
