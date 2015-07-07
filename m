From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Tue, 07 Jul 2015 12:16:34 +0000
Subject: [PATCH v4] ARM: shmobile: koelsch: make USB0 perform Host/Function switching
Message-Id: <1436271394-25964-1-git-send-email-phil.edworthy@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150703001430.GB20396@verge.net.au>
In-Reply-To: <20150703001430.GB20396@verge.net.au>
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

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

---
Not for upstream until the following patches have been accepted:
"usb: renesas_usbhs: Allow an OTG PHY driver to provide VBUS"
"phy: rcar-gen2 usb: Add Host/Function switching for USB0"
Hence, not signed off.

v4:
  - Changed prefix in title.

v3:
  - Remove "pinctrl-names" as well as "pinctrl-0" props.

v2:
  - Added -gpio to dts prop names of GPIO pins.
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index cffe33f..21c2fdc 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -615,8 +615,6 @@
 
 &pci0 {
 	status = "okay";
-	pinctrl-0 = <&usb0_pins>;
-	pinctrl-names = "default";
 };
 
 &pci1 {
@@ -627,13 +625,14 @@
 
 &hsusb {
 	status = "okay";
-	pinctrl-0 = <&usb0_pins>;
-	pinctrl-names = "default";
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

