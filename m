From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 08 Sep 2015 04:49:57 +0000
Subject: [PATCH][RFC] arm64: renesas: Add EXTAL configuration to Salvator-X
Message-Id: <20150908044957.4919.98690.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Configure EXTAL to 16.666 MHz on Salvator-X.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 This sets the EXTAL frequency for the V9 integration series:
 [PATCH v9 00/07][RFC] Renesas R-Car H3 (r8a7795) integration patches V9

 To be used with the V7 CPG:
 [PATCH v7 00/05] Renesas R-Car Gen3 CPG support V7

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |    4 ++++
 1 file changed, 4 insertions(+)

--- 0007/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ work/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts	2015-09-08 13:44:53.682366518 +0900
@@ -32,6 +32,10 @@
 	};
 };
 
+&extal_clk {
+	clock-frequency = <16666666>;
+};
+
 &pfc {
 	scif1_pins: scif1 {
 		renesas,groups = "scif1_data_a", "scif1_ctrl";
