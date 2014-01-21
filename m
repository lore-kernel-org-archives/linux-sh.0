From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 21 Jan 2014 15:32:37 +0000
Subject: [RFC/PATCH 2/7] ARM: shmobile: r8a7790: Add DU node to device tree
Message-Id: <1390318362-29954-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390318362-29954-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1390318362-29954-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, Magnus Damm <magnus.damm@gmail.com>

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index f2f5394..38632a5 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -418,6 +418,25 @@
 		status = "disabled";
 	};
 
+	du: du@feb00000 {
+		compatible = "renesas,du-r8a7790";
+		reg = <0 0xfeb00000 0 0x70000>,
+		      <0 0xfeb90000 0 0x1c>,
+		      <0 0xfeb94000 0 0x1c>;
+		reg-names = "du", "lvds.0", "lvds.1";
+		interrupt-parent = <&gic>;
+		interrupts = <0 256 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 268 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 269 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7790_CLK_DU0>,
+		         <&mstp7_clks R8A7790_CLK_DU1>,
+		         <&mstp7_clks R8A7790_CLK_DU2>,
+		         <&mstp7_clks R8A7790_CLK_LVDS0>,
+		         <&mstp7_clks R8A7790_CLK_LVDS1>;
+		clock-names = "du.0", "du.1", "du.2", "lvds.0", "lvds.1";
+		status = "disabled";
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
1.8.3.2

