From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Thu, 02 Jul 2015 08:14:29 +0000
Subject: [PATCH v2] arm: koelsch: make USB0 perform Host/Function switching
Message-Id: <1435824869-22784-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Magnus Damm <magnus.damm@gmail.com>, Kishon Vijay Abraham I <kishon@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, Phil Edworthy <phil.edworthy@renesas.com>

Both USB Host (pci0) and Function (USBHS) drivers are enabled.
The USB PHY driver determines which IP block should be connected
based on vbus and id signals read via gpios.

Note that switch SW5 and SW6 on Koelsch board needs to be set to
position 3 for this to work.

---

Not for upstream until the following patches have been accepted:
"usb: renesas_usbhs: Allow an OTG PHY driver to provide VBUS"
"phy: rcar-gen2 usb: Add Host/Function switching for USB0"
Hence, not signed off.

v2:
  - Added -gpio to dts prop names of GPIO pins.
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index cffe33f..1bb34d0 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -615,7 +615,6 @@
 
 &pci0 {
 	status = "okay";
-	pinctrl-0 = <&usb0_pins>;
 	pinctrl-names = "default";
 };
 
@@ -627,13 +626,15 @@
 
 &hsusb {
 	status = "okay";
-	pinctrl-0 = <&usb0_pins>;
 	pinctrl-names = "default";
-	renesas,enable-gpio = <&gpio5 31 GPIO_ACTIVE_HIGH>;
 };
 
 &usbphy {
 	status = "okay";
+	renesas,pwr-gpio = <&gpio2 4 GPIO_ACTIVE_HIGH>;
+	renesas,id-gpio = <&gpio5 31 GPIO_ACTIVE_HIGH>;
+	renesas,vbus-gpio = <&gpio7 24 GPIO_ACTIVE_HIGH>;
+	renesas,vbus-pwr-gpio = <&gpio7 23 GPIO_ACTIVE_HIGH>;
 };
 
 &pcie_bus_clk {
-- 
1.9.1

