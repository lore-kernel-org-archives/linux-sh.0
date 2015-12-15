From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Dec 2015 13:26:43 +0000
Subject: [PATCH/RFC 01/03] ARM: shmobile: External Salvator-X SCIF3/HSCIF3 loop
Message-Id: <20151215132643.15356.92444.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add SCIF3 and HSCIF3 as two new serial ports to the r8a7795
Salvator-X DT file. 

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   28 ++++++++++++++++++++
 1 file changed, 28 insertions(+)

--- 0001/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ work/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts	2015-11-06 14:21:56.640513000 +0900
@@ -41,6 +41,8 @@
 	aliases {
 		serial0 = &scif2;
 		serial1 = &scif1;
+		serial2 = &scif3;
+		serial3 = &hscif3;
 		ethernet0 = &avb;
 	};
 
@@ -135,6 +137,16 @@
 		renesas,groups = "scif2_data_a";
 		renesas,function = "scif2";
 	};
+	
+	scif3_pins: scif3 { /* TX: 1_11, RX: 1_8 */
+		renesas,groups = "scif3_data_b";
+		renesas,function = "scif3";
+	};
+
+	hscif3_pins: hscif3 { /* TX: 2_8, RX: 2_7 */
+		renesas,groups = "hscif3_data_d";
+		renesas,function = "hscif3";
+	};
 
 	i2c2_pins: i2c2 {
 		renesas,groups = "i2c2_a";
@@ -169,6 +181,22 @@
 	pinctrl-names = "default";
 
 	status = "okay";
+};
+
+&scif3 {
+	pinctrl-0 = <&scif3_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+/* SCIF3 TX -> HSCIF3 RX, HSCIF3 TX -> SCIF3 RX */
+
+&hscif3 {
+	pinctrl-0 = <&hscif3_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
 };
 
 &i2c2 {
