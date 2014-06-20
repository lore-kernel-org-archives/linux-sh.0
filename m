From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 20 Jun 2014 20:51:27 +0000
Subject: [PATCH v3 3/3] ARM: shmobile: henninger: enable internal PCI
Message-Id: <201406210051.28040.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201406210044.51620.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201406210044.51620.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Enable internal AHB-PCI bridges for the USB EHCI/OHCI controllers attached to
them.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 3:
- refreshed the patch.

 arch/arm/boot/dts/r8a7791-henninger.dts |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-henninger.dts
=================================--- renesas.orig/arch/arm/boot/dts/r8a7791-henninger.dts
+++ renesas/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -120,6 +120,16 @@
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
 
 &scif0 {
@@ -217,3 +227,15 @@
 		spi-cpha;
 	};
 };
+
+&pci0 {
+	status = "okay";
+	pinctrl-0 = <&usb0_pins>;
+	pinctrl-names = "default";
+};
+
+&pci1 {
+	status = "okay";
+	pinctrl-0 = <&usb1_pins>;
+	pinctrl-names = "default";
+};
