From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 07 Apr 2014 06:34:08 +0000
Subject: [PATCH 03/05] ARM: shmobile: Lager DT reference USB pinmux setup
Message-Id: <20140407063408.26152.4799.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Configure the pinmux on Lager for USB ports via the default
setting. This allows support for USB function on USB0 and
USB Host for USB1 and USB2. Not for upstream merge.

Not-yet-Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7790-lager.dts |   18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

--- 0001/arch/arm/boot/dts/r8a7790-lager.dts
+++ work/arch/arm/boot/dts/r8a7790-lager.dts	2014-04-07 13:08:46.000000000 +0900
@@ -146,7 +146,8 @@
 };
 
 &pfc {
-	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins>;
+	pinctrl-0 = <&du_pins &scif0_pins &scif1_pins
+		     &usb0_pins &usb1_pins &usb2_pins>;
 	pinctrl-names = "default";
 
 	du_pins: du {
@@ -199,6 +200,21 @@
 				 "msiof1_tx";
 		renesas,function = "msiof1";
 	};
+
+	usb0_pins: usb0 {
+		renesas,groups = "usb0_ovc_vbus";
+		renesas,function = "usb0";
+	};
+
+	usb1_pins: usb1 {
+		renesas,groups = "usb1";
+		renesas,function = "usb1";
+	};
+
+	usb2_pins: usb2 {
+		renesas,groups = "usb2";
+		renesas,function = "usb2";
+	};
 };
 
 &ether {
