From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 05 Feb 2014 10:19:10 +0000
Subject: [PATCH 07/11] ARM: shmobile: r8a7790.dtsi: add usbphy node
Message-Id: <1391595554-20640-8-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add node for USB PHY driver to the base R8A7790 device tree include file.
It is up to the board file to enable and configure it as necessary.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
---
Cc: devicetree@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Simon Horman <horms@verge.net.au>
Cc: linux-sh@vger.kernel.org
---
 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index d52d32e..c758ebc 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -782,4 +782,12 @@
 		interrupts = <0 113 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
+
+	usbphy: usbphy@e6590100 {
+		compatible = "renesas,usb-phy-r8a7790";
+		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
+		clock-names = "usbhs";
+		reg = < 0x0 0xe6590100 0x0 0x100>;
+		status = "disabled";
+	};
 };
-- 
1.8.5.3

