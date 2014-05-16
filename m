From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 16 May 2014 00:58:14 +0000
Subject: [PATCH 05/11] ARM: shmobile: r8a7740 dtsi: Add Ethernet support
Message-Id: <08ec67b50db7ca8c9077e67ca23850cdc5bfc716.1400200395.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1400200395.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1400200395.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 9f65986..f014789 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -123,6 +123,19 @@
 			      0 149 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	ether: ethernet@e9a00000 {
+		compatible = "renesas,gether-r8a7740";
+		reg = <0xe9a00000 0x800>,
+		      <0xe9a01800 0x800>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
+		/* clocks = <&mstp3_clks R8A7740_CLK_GETHER>; */
+		phy-mode = "mii";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "disabled";
+	};
+
 	i2c0: i2c@fff20000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.8.5.2

