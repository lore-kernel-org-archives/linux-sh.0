From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 07 Apr 2014 06:34:26 +0000
Subject: [PATCH 05/05] ARM: shmobile: Koelsch DT reference USB pinmux setup
Message-Id: <20140407063426.26152.24164.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Configure the pinmux on Koelsch for USB ports via the default
setting. This allows support for USB function on USB0 and
USB Host for USB1. Not for upstream merge.

Not-yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7791-koelsch.dts |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

--- 0001/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ work/arch/arm/boot/dts/r8a7791-koelsch.dts	2014-04-07 14:16:57.000000000 +0900
@@ -230,7 +230,7 @@
 };
 
 &pfc {
-	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins>;
+	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins &usb0_pins &usb1_pins>;
 	pinctrl-names = "default";
 
 	i2c2_pins: i2c2 {
@@ -288,6 +288,16 @@
 				 "msiof0_tx";
 		renesas,function = "msiof0";
 	};
+
+	usb0_pins: usb0 {
+		renesas,groups = "usb0";
+		renesas,function = "usb0";
+	};
+
+	usb1_pins: usb1 {
+		renesas,groups = "usb1";
+		renesas,function = "usb1";
+	};
 };
 
 &ether {
