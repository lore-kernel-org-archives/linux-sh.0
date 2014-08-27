From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Aug 2014 16:41:08 +0000
Subject: [PATCH 11/16] ARM: shmobile: r8a7791: Add DU node to device tree
Message-Id: <1409157673-4154-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1409157673-4154-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1409157673-4154-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org
Cc: linux-sh@vger.kernel.org

Add the DU device with a disabled state. Boards that want to enable the
DU need to specify the output topology

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 8a07505..d5f9ae06 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -637,6 +637,36 @@
 		status = "disabled";
 	};
 
+	du: du@feb00000 {
+		compatible = "renesas,du-r8a7791";
+		reg = <0 0xfeb00000 0 0x40000>,
+		      <0 0xfeb90000 0 0x1c>;
+		reg-names = "du", "lvds.0";
+		interrupts = <0 256 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 268 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7791_CLK_DU0>,
+		         <&mstp7_clks R8A7791_CLK_DU1>,
+		         <&mstp7_clks R8A7791_CLK_LVDS0>;
+		clock-names = "du.0", "du.1", "lvds.0";
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				du_out_rgb: endpoint {
+				};
+			};
+			port@1 {
+				reg = <1>;
+				du_out_lvds0: endpoint {
+				};
+			};
+		};
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
1.8.5.5

