From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 08 Oct 2014 18:00:53 +0000
Subject: [PATCH v3 1/3] ARM: shmobile: r8a7791: add HS-USB device node
Message-Id: <1732319.urzcOrRf7a@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1511869.4ca9KHmSFr@wasted.cogentembedded.com>
In-Reply-To: <1511869.4ca9KHmSFr@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Define the R8A7791 generic part of the HS-USB device node. It is up to the board
file to enable the device.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
[Sergei: fixed summary, added changelog]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- uppercased "arm" in the summary;
- added changelog.

 arch/arm/boot/dts/r8a7791.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791.dtsi
=================================--- renesas.orig/arch/arm/boot/dts/r8a7791.dtsi
+++ renesas/arch/arm/boot/dts/r8a7791.dtsi
@@ -637,6 +637,17 @@
 		status = "disabled";
 	};
 
+	hsusb: usb@e6590000 {
+		compatible = "renesas,usbhs-r8a7791";
+		reg = <0 0xe6590000 0 0x100>;
+		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7791_CLK_HSUSB>;
+		renesas,buswait = <4>;
+		phys = <&usb0 1>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
 	usbphy: usb-phy@e6590100 {
 		compatible = "renesas,usb-phy-r8a7791";
 		reg = <0 0xe6590100 0 0x100>;

