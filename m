From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 08 Oct 2014 18:04:04 +0000
Subject: [PATCH v3 3/3] ARM: shmobile: henninger: enable HS-USB
Message-Id: <2594830.xOnLuo3vQq@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1511869.4ca9KHmSFr@wasted.cogentembedded.com>
In-Reply-To: <1511869.4ca9KHmSFr@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Enable HS-USB device for the Henninger board, defining the GPIO that the driver
should check when probing (which is the ID output from MAX3355 OTG chip).

Note that there will be pinctrl-related error messages if both internal PCI
and HS-USB drivers are enabled but they should be just ignored.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
[Sergei: added pin function/group and prop, moved device node, fixed summary,
added changelog]
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes in version 2:
- added pinctrl-related properties;
- moved the HS-USB node to precede the USB PHY node;
- uppercased "arm" in the summary;
- added changelog.

 arch/arm/boot/dts/r8a7791-henninger.dts |    7 +++++++
 1 file changed, 7 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7791-henninger.dts
=================================--- renesas.orig/arch/arm/boot/dts/r8a7791-henninger.dts
+++ renesas/arch/arm/boot/dts/r8a7791-henninger.dts
@@ -272,6 +272,13 @@
 	pinctrl-names = "default";
 };
 
+&hsusb {
+	status = "okay";
+	pinctrl-0 = <&usb0_pins>;
+	pinctrl-names = "default";
+	renesas,enable-gpio = <&gpio5 31 GPIO_ACTIVE_HIGH>;
+};
+
 &usbphy {
 	status = "okay";
 };

