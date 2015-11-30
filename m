From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 30 Nov 2015 14:16:52 +0000
Subject: [PATCH 2/2] ARM: shmobile: sh73a0: Add MSIOF device nodes
Message-Id: <1448893012-8465-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1448893012-8465-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448893012-8465-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The sh73a0 has 4 MSIOF devices, located in the A3SP power area.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0.dtsi | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index c55b09e640f0b7d3..866ee5de09454d14 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -273,6 +273,50 @@
 		status = "disabled";
 	};
 
+	msiof0: spi@e6e20000 {
+		compatible = "renesas,msiof-sh73a0", "renesas,sh-mobile-msiof";
+		reg = <0xe6e20000 0x0064>;
+		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp0_clks SH73A0_CLK_MSIOF0>;
+		power-domains = <&pd_a3sp>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	msiof1: spi@e6e10000 {
+		compatible = "renesas,msiof-sh73a0", "renesas,sh-mobile-msiof";
+		reg = <0xe6e10000 0x0064>;
+		interrupts = <0 77 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_MSIOF1>;
+		power-domains = <&pd_a3sp>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	msiof2: spi@e6e00000 {
+		compatible = "renesas,msiof-sh73a0", "renesas,sh-mobile-msiof";
+		reg = <0xe6e00000 0x0064>;
+		interrupts = <0 76 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_MSIOF2>;
+		power-domains = <&pd_a3sp>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
+	msiof3: spi@e6c90000 {
+		compatible = "renesas,msiof-sh73a0", "renesas,sh-mobile-msiof";
+		reg = <0xe6c90000 0x0064>;
+		interrupts = <0 59 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_MSIOF3>;
+		power-domains = <&pd_a3sp>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	sdhi0: sd@ee100000 {
 		compatible = "renesas,sdhi-sh73a0";
 		reg = <0xee100000 0x100>;
-- 
1.9.1

