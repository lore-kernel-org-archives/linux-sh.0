From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 03 Jul 2014 19:40:15 +0000
Subject: [PATCH v2 2/2] ARM: shmobile: henninger: add CAN0 DT support
Message-Id: <201407032340.16445.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201407032337.03509.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201407032337.03509.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Define the Henninger board dependent part of the CAN0 device node.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/boot/dts/r8a7791-henninger.dts |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-henninger.dts
=================================--- renesas.orig/arch/arm/boot/dts/r8a7791-henninger.dts
+++ renesas/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -125,6 +125,11 @@
 				 "msiof0_tx";
 		renesas,function = "msiof0";
 	};
+
+	can0_pins: can0 {
+		renesas,groups = "can0_data_a", "can_clk_d";
+		renesas,function = "can0";
+	};
 };
 
 &scif0 {
@@ -175,6 +180,12 @@
 	status = "okay";
 };
 
+&can0 {
+	pinctrl-0 = <&can0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
+
 &i2c2 {
 	pinctrl-0 = <&i2c2_pins>;
 	pinctrl-names = "default";

