From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 17 Jul 2015 08:26:05 +0000
Subject: [PATCH 3/5] ARM: shmobile: r8a7794: Add DU0 clock
Message-Id: <1437121567-18467-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1437121567-18467-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1437121567-18467-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Magnus Damm <magnus.damm@gmail.com>

The DU0 clock is an MSTP clock, child of the CPG ZX clock.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7794.dtsi            | 7 ++++---
 include/dt-bindings/clock/r8a7794-clock.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index b73819423311..2a0d375e45b3 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -675,19 +675,20 @@
 			reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
 			clocks = <&mp_clk>, <&mp_clk>,
 				 <&zs_clk>, <&p_clk>, <&p_clk>, <&zs_clk>,
-				 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>;
+				 <&zs_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
+				 <&zx_clk>;
 			#clock-cells = <1>;
 			clock-indices = <
 				R8A7794_CLK_EHCI R8A7794_CLK_HSUSB
 				R8A7794_CLK_HSCIF2 R8A7794_CLK_SCIF5
 				R8A7794_CLK_SCIF4 R8A7794_CLK_HSCIF1 R8A7794_CLK_HSCIF0
 				R8A7794_CLK_SCIF3 R8A7794_CLK_SCIF2 R8A7794_CLK_SCIF1
-				R8A7794_CLK_SCIF0
+				R8A7794_CLK_SCIF0 R8A7794_CLK_DU0
 			>;
 			clock-output-names  				"ehci", "hsusb",
 				"hscif2", "scif5", "scif4", "hscif1", "hscif0",
-				"scif3", "scif2", "scif1", "scif0";
+				"scif3", "scif2", "scif1", "scif0", "du0";
 		};
 		mstp8_clks: mstp8_clks@e6150990 {
 			compatible = "renesas,r8a7794-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7794-clock.h b/include/dt-bindings/clock/r8a7794-clock.h
index 09da38a58776..a7a7e0370968 100644
--- a/include/dt-bindings/clock/r8a7794-clock.h
+++ b/include/dt-bindings/clock/r8a7794-clock.h
@@ -79,6 +79,7 @@
 #define R8A7794_CLK_SCIF2		19
 #define R8A7794_CLK_SCIF1		20
 #define R8A7794_CLK_SCIF0		21
+#define R8A7794_CLK_DU0			24
 
 /* MSTP8 */
 #define R8A7794_CLK_VIN1		10
-- 
2.3.6

