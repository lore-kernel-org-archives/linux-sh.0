From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Aug 2014 16:41:06 +0000
Subject: [PATCH 09/16] ARM: shmobile: r8a7779: Add DU node to device tree
Message-Id: <1409157673-4154-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 arch/arm/boot/dts/r8a7779.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 559788b..9689314 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -379,6 +379,30 @@
 		status = "disabled";
 	};
 
+	du: du@fff80000 {
+		compatible = "renesas,du-r8a7779";
+		reg = <0 0xfff80000 0 0x40000>;
+		interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7779_CLK_DU>;
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
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
1.8.5.5

