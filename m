From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 21 Jun 2015 08:10:22 +0000
Subject: [PATCH 07/08] devicetree: bindings: Deprecate property, update example
Message-Id: <20150621081022.10187.18366.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150621080903.10187.20998.sendpatchset@little-apple>
In-Reply-To: <20150621080903.10187.20998.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, daniel.lezcano@linaro.org, horms+renesas@verge.net.au, Magnus Damm <magnus.damm@gmail.com>, tglx@linutronix.de

From: Magnus Damm <damm+renesas@opensource.se>

Deprecate "renesas,channels-mask" and update the r8a7790 CMT example.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Documentation/devicetree/bindings/timer/renesas,cmt.txt |   24 ++++++++++-----
 1 file changed, 17 insertions(+), 7 deletions(-)

--- 0006/Documentation/devicetree/bindings/timer/renesas,cmt.txt
+++ work/Documentation/devicetree/bindings/timer/renesas,cmt.txt	2015-06-20 15:13:32.752366518 +0900
@@ -60,21 +60,31 @@ Required Properties:
     in clock-names.
   - clock-names: must contain "fck" for the functional clock.
 
-  - renesas,channels-mask: bitmask of the available channels.
+  - renesas,channels-mask: <deprecated>, information kept in device driver.
 
 
-Example: R8A7790 (R-Car H2) CMT0 node
-
-	CMT0 on R8A7790 implements hardware channels 5 and 6 only and names
-	them channels 0 and 1 in the documentation.
+Example: R8A7790 (R-Car H2) CMT0 and CMT1 nodes
 
 	cmt0: timer@ffca0000 {
-		compatible = "renesas,cmt-48-r8a7790", "renesas,cmt-48-gen2";
+		compatible = "renesas,cmt0-r8a7790", "renesas,cmt0-rcar-gen2";
 		reg = <0 0xffca0000 0 0x1004>;
 		interrupts = <0 142 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 142 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp1_clks R8A7790_CLK_CMT0>;
 		clock-names = "fck";
+	};
 
-		renesas,channels-mask = <0x60>;
+	cmt1: timer@e6130000 {
+		compatible = "renesas,cmt1-r8a7790", "renesas,cmt1-rcar-gen2";
+		reg = <0 0xe6130000 0 0x1004>;
+		interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 121 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 122 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 123 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 124 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 125 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 126 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 127 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_CMT1>;
+		clock-names = "fck";
 	};
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
