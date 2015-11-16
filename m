From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 16 Nov 2015 08:57:20 +0000
Subject: [PATCH v2 02/03] ARM: shmobile: r8a7794: Add DU node to device tree
Message-Id: <20151116085720.7119.57488.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add the DU device with a disabled state. Boards that want to enable the
DU need to specify the output topology.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

Previously part of the following series:
 [PATCH 0/5] R-Car DU: Add support for R8A7793 and R8A7794

 Changes since V1:
 - None

arch/arm/boot/dts/r8a7794.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 2a0d375e45b3..409f6c4b1044 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -401,6 +401,34 @@
 		status = "disabled";
 	};
 
+	du: display@feb00000 {
+		compatible = "renesas,du-r8a7794";
+		reg = <0 0xfeb00000 0 0x40000>;
+		reg-names = "du";
+		interrupts = <0 256 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 268 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7794_CLK_DU0>,
+			 <&mstp7_clks R8A7794_CLK_DU0>;
+		clock-names = "du.0", "du.1";
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				du_out_rgb0: endpoint {
+				};
+			};
+			port@1 {
+				reg = <1>;
+				du_out_rgb1: endpoint {
+				};
+			};
+		};
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;

