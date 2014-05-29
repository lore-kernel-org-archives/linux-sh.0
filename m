From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 29 May 2014 11:00:08 +0000
Subject: [PATCH 2/2] arm: shmobile: r8a7790: add USB3.0 node to r8a7790.dtsi
Message-Id: <53871338.8050606@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <c223d986b953a4686f2540091f82e44030a50daa.1377652063.git.horms+renesas@verge.net.au>
In-Reply-To: <c223d986b953a4686f2540091f82e44030a50daa.1377652063.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/arm/boot/dts/r8a7790.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index e06c486..e6b04f2 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -902,4 +902,14 @@
 		#size-cells = <0>;
 		status = "disabled";
 	};
+
+	xhci: xhci@ee000000 {
+		compatible = "renesas,xhci-r8a7790";
+		reg = <0 0xee000000 0 0xc00>;
+		interrupts = <0 101 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks R8A7790_CLK_SSUSB>;
+		phys = <&usbphy 1 1>;
+		phy-names = "usb";
+		status = "disabled";
+	};
 };
-- 
1.7.9.5

