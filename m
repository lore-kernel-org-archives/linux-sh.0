From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 30 Jul 2014 22:05:57 +0000
Subject: [PATCH v3 3/3] ARM: shmobile: henninger: add CAN0 DT support
Message-Id: <201407310205.58686.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201407310158.15446.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201407310158.15446.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Define the Henninger board dependent part of the CAN0 device node.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- changed "can0_data_a" to "can0_data", removed "can_clk_d" in the
  "renesas,groups" property;
- moved CAN0 node to go after all others;
- refreshed the patch.

 arch/arm/boot/dts/r8a7791-henninger.dts |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-henninger.dts
=================================--- renesas.orig/arch/arm/boot/dts/r8a7791-henninger.dts
+++ renesas/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -135,6 +135,11 @@
 		renesas,groups = "usb1";
 		renesas,function = "usb1";
 	};
+
+	can0_pins: can0 {
+		renesas,groups = "can0_data";
+		renesas,function = "can0";
+	};
 };
 
 &scif0 {
@@ -260,3 +265,9 @@
 &pciec {
 	status = "okay";
 };
+
+&can0 {
+	pinctrl-0 = <&can0_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
