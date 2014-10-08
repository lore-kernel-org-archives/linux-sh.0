From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 08 Oct 2014 06:24:30 +0000
Subject: [PATCH 2/2] ARM: shmobile: lager: enable USB3.0
Message-Id: <1412749470-6028-3-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412749470-6028-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1412749470-6028-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au, magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk
Cc: devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Since the PHY of USB3.0 and EHCI/OHCI ch2 are the same, the USB3.0
driver cannot use the phy driver when the EHCI/OHCI ch2 already used it:

phy phy-e6590100.usb-phy.3: phy init failed --> -16
xhci-hcd: probe of ee000000.usb failed with error -16

If so, we have to unbind the EHCI/OHCI ch2, and then we have to bind
the USB3.0 driver as the following:

  echo 0000:02:02.0 > /sys/bus/pci/drivers/ehci-pci/unbind
  echo 0000:02:01.0 > /sys/bus/pci/drivers/ohci-pci/unbind
  echo ee000000.usb > /sys/bus/platform/drivers/xhci-hcd/bind

Note that there will be pinctrl-related error messages if both
internal PCI and USB3.0 are enabled but they should be just ignored:

sh-pfc e6060000.pfc: pin GP_5_22 already requested by ee0d0000.pci; cannot claim for ee000000.usb
sh-pfc e6060000.pfc: pin-182 (ee000000.usb) status -22
ata1: SATA link down (SStatus 0 SControl 300)
sh-pfc e6060000.pfc: could not request pin 182 (GP_5_22) from group usb2  on device sh-pfc

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 719979e..3f51be1 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -419,6 +419,12 @@
 	pinctrl-names = "default";
 };
 
+&xhci {
+	status = "okay";
+	pinctrl-0 = <&usb2_pins>;
+	pinctrl-names = "default";
+};
+
 &pci2 {
 	status = "okay";
 	pinctrl-0 = <&usb2_pins>;
-- 
1.7.9.5

