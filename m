From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 17 Jul 2015 08:26:07 +0000
Subject: [PATCH 5/5] ARM: shmobile: r8a7794: Add DU node to device tree
Message-Id: <1437121567-18467-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1437121567-18467-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1437121567-18467-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Magnus Damm <magnus.damm@gmail.com>

Add the DU device with a disabled state. Boards that want to enable the
DU need to specify the output topology.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
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
-- 
2.3.6

