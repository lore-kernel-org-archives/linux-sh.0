From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 13 Sep 2014 23:36:24 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7790: Add VSP1 devices to DT
Message-Id: <1410651385-13090-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1368173119-27345-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add all available VSP1 devices.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 51 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index d0e1773..7f00bec 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -600,6 +600,57 @@
 		status = "disabled";
 	};
 
+	vsp1@fe920000 {
+		compatible = "renesas,vsp1";
+		reg = <0 0xfe920000 0 0x8000>;
+		interrupts = <0 266 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7790_CLK_VSP1_R>;
+
+		renesas,has-sru;
+		renesas,#rpf = <5>;
+		renesas,#uds = <1>;
+		renesas,#wpf = <4>;
+	};
+
+	vsp1@fe928000 {
+		compatible = "renesas,vsp1";
+		reg = <0 0xfe928000 0 0x8000>;
+		interrupts = <0 267 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7790_CLK_VSP1_S>;
+
+		renesas,has-lut;
+		renesas,has-sru;
+		renesas,#rpf = <5>;
+		renesas,#uds = <3>;
+		renesas,#wpf = <4>;
+	};
+
+	vsp1@fe930000 {
+		compatible = "renesas,vsp1";
+		reg = <0 0xfe930000 0 0x8000>;
+		interrupts = <0 246 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7790_CLK_VSP1_DU0>;
+
+		renesas,has-lif;
+		renesas,has-lut;
+		renesas,#rpf = <4>;
+		renesas,#uds = <1>;
+		renesas,#wpf = <4>;
+	};
+
+	vsp1@fe938000 {
+		compatible = "renesas,vsp1";
+		reg = <0 0xfe938000 0 0x8000>;
+		interrupts = <0 247 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7790_CLK_VSP1_DU1>;
+
+		renesas,has-lif;
+		renesas,has-lut;
+		renesas,#rpf = <4>;
+		renesas,#uds = <1>;
+		renesas,#wpf = <4>;
+	};
+
 	clocks {
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
1.8.5.5

