From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 04 Nov 2014 01:50:55 +0000
Subject: [PATCH 25/34] ARM: shmobile: r8a7791: add HS-USB device node
Message-Id: <1c1fee7cbba99023a11d4d2991b56c99a3174bd4.1415059587.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415059587.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1415059587.git.horms+renesas@verge.net.au>
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
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index d55335e..c815313 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -613,6 +613,17 @@
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
-- 
2.1.1

