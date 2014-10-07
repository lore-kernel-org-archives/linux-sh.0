From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Tue, 07 Oct 2014 11:10:19 +0000
Subject: [PATCH v2 1/2] arm: shmobile: r8a7790: add HS-USB device node
Message-Id: <1412680220-4552-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412680220-4552-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1412680220-4552-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au, magnus.damm@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk
Cc: devicetree@vger.kernel.org, linux-usb@vger.kernel.org, linux-sh@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/arm/boot/dts/r8a7790.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 2380fd5..63a75f2 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -600,6 +600,17 @@
 		status = "disabled";
 	};
 
+	hsusb: usb@e6590000 {
+		compatible = "renesas,usbhs-r8a7790";
+		reg = <0 0xe6590000 0 0x100>;
+		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
+		renesas,buswait = <4>;
+		phys = <&usb0 1>;
+		phy-names = "usb";
+		status = "disabled";
+	};
+
 	usbphy: usb-phy@e6590100 {
 		compatible = "renesas,usb-phy-r8a7790";
 		reg = <0 0xe6590100 0 0x100>;
-- 
1.7.9.5

