From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 31 Oct 2014 15:01:36 +0000
Subject: [PATCH 2/2] clk: shmobile: document DIV6 clock parent bindings
Message-Id: <1414767696-23211-3-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414767696-23211-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1414767696-23211-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au, mturquette@linaro.org, laurent.pinchart+renesas@ideasonboard.com
Cc: linux-sh@vger.kernel.org, magnus.damm@gmail.com, geert@linux-m68k.org, devicetree@vger.kernel.org, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Adds properties renesas,src-shift and renesas,src-width, and describes
how to specify the available parent clocks.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 .../bindings/clock/renesas,cpg-div6-clocks.txt     | 28 +++++++++++++++++-----
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
index 952e373..348954b 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
@@ -7,22 +7,38 @@ to 64.
 Required Properties:
 
   - compatible: Must be one of the following
+    - "renesas,r8a73a4-div6-clock" for R8A73A4 (R-Mobile APE6) DIV6 clocks
+    - "renesas,r8a7740-div6-clock" for R8A7740 (R-Mobile A1) DIV6 clocks
     - "renesas,r8a7790-div6-clock" for R8A7790 (R-Car H2) DIV6 clocks
     - "renesas,r8a7791-div6-clock" for R8A7791 (R-Car M2) DIV6 clocks
+    - "renesas,sh73a0-div6-clock" for SH73A0 (SH-MobileAG5) DIV6 clocks
     - "renesas,cpg-div6-clock" for generic DIV6 clocks
   - reg: Base address and length of the memory resource used by the DIV6 clock
-  - clocks: Reference to the parent clock
+  - clocks: Reference to the parent clock(s); if there are multiple parent
+    clocks, one must be specified for each possible parent clock setting
+    in the clock register. Invalid settings must be specified as "<0>".
+    Trailing invalid settings may be omitted.
   - #clock-cells: Must be 0
   - clock-output-names: The name of the clock as a free-form string
 
+Optional Properties:
+
+  - renesas,src-shift: Bit position of the input clock selector (default:
+    fixed input clock; requires renesas,src-width)
+  - renesas,src-width: Bit width of the input clock selector (default: fixed
+    input clock; requires renesas,src-shift)
+
 
 Example
 -------
 
-	sd2_clk: sd2_clk@e6150078 {
-		compatible = "renesas,r8a7790-div6-clock", "renesas,cpg-div6-clock";
-		reg = <0 0xe6150078 0 4>;
-		clocks = <&pll1_div2_clk>;
+	sdhi2_clk: sdhi2_clk@e615007c {
+		compatible = "renesas,r8a73a4-div6-clock", "renesas,cpg-div6-clock";
+		reg = <0 0xe615007c 0 4>;
+		clocks = <&pll1_div2_clk>, <&cpg_clocks R8A73A4_CLK_PLL2S>,
+			 <0>, <&extal2_clk>;
+		renesas,src-shift = <6>;
+		renesas,src-width = <2>;
 		#clock-cells = <0>;
-		clock-output-names = "sd2";
+		clock-output-names = "sdhi2ck";
 	};
-- 
1.8.4.5

