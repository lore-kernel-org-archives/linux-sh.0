From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 01 Sep 2015 15:12:37 +0000
Subject: [PATCH 2/6] clk: shmobile: rcar-gen3: Document renesas,modemr
Message-Id: <1441120361-1232-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Document the "renesas,modemr" property, which allows the Clock Pulse
Generator driver to obtain the values of the mode pin using syscon and
regmap.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 .../devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt        | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt
index d282f6441eea5d22..0d50af9be51b3fa3 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt
@@ -17,6 +17,9 @@ Required Properties:
   - #clock-cells: Must be 1
   - clock-indices: Indices of the exported clocks
   - #power-domain-cells: Must be 0
+  - renesas,modemr: Reference to the RST module node, and register offset of
+		    the Mode Monitor Register (MODEMR) inside the RST module
+		    register block.
 
 SoC devices that are part of the CPG/MSTP Clock Domain and can be power-managed
 through an MSTP clock should refer to the CPG device node in their
@@ -40,6 +43,7 @@ Examples
                              R8A7795_CLK_PLL3 R8A7795_CLK_PLL4
                 >;
 		#power-domain-cells = <0>;
+		renesas,modemr = <&rst 0x60>;
 	};
 
   - CPG/MSTP Clock Domain member device node:
-- 
1.9.1

