From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 07 Nov 2014 15:51:08 +0000
Subject: [PATCH v7 2/2] clk: shmobile: document DIV6 clock parent bindings
Message-Id: <1415375468-15378-3-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415375468-15378-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1415375468-15378-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au, mturquette@linaro.org, geert@linux-m68k.org, laurent.pinchart+renesas@ideasonboard.com
Cc: linux-sh@vger.kernel.org, magnus.damm@gmail.com, devicetree@vger.kernel.org, mark.rutland@arm.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Describes how to specify the parents for clocks with EXSRC bits.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 .../bindings/clock/renesas,cpg-div6-clocks.txt         | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
index 952e373..054f65f 100644
--- a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
@@ -7,11 +7,16 @@ to 64.
 Required Properties:
 
   - compatible: Must be one of the following
+    - "renesas,r8a73a4-div6-clock" for R8A73A4 (R-Mobile APE6) DIV6 clocks
+    - "renesas,r8a7740-div6-clock" for R8A7740 (R-Mobile A1) DIV6 clocks
     - "renesas,r8a7790-div6-clock" for R8A7790 (R-Car H2) DIV6 clocks
     - "renesas,r8a7791-div6-clock" for R8A7791 (R-Car M2) DIV6 clocks
+    - "renesas,sh73a0-div6-clock" for SH73A0 (SH-Mobile AG5) DIV6 clocks
     - "renesas,cpg-div6-clock" for generic DIV6 clocks
   - reg: Base address and length of the memory resource used by the DIV6 clock
-  - clocks: Reference to the parent clock
+  - clocks: Reference to the parent clock(s); either one, four, or eight
+    clocks must be specified.  For clocks with multiple parents, invalid
+    settings must be specified as "<0>".
   - #clock-cells: Must be 0
   - clock-output-names: The name of the clock as a free-form string
 
@@ -19,10 +24,11 @@ Required Properties:
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
 		#clock-cells = <0>;
-		clock-output-names = "sd2";
+		clock-output-names = "sdhi2ck";
 	};
-- 
1.8.4.5

