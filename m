From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Sat, 18 Jan 2014 15:03:39 +0000
Subject: [PATCH 5/6] ARM: shmobile: r8a7790.dtsi: add usbphy node
Message-Id: <1390057420-13226-6-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390057420-13226-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390057420-13226-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@lists.codethink.co.uk
Cc: linux-sh@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>, "open list:OPEN FIRMWARE AND..." <devicetree@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

Add node for USB PHY driver to the base R8A7790 device tree include file.
It is up to the board file to enable and configure it as necessary.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
---
Cc: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND...)
Cc: Magnus Damm <magnus.damm@gmail.com> (supporter:ARM/SHMOBILE ARM...)
Cc: Simon Horman <horms@verge.net.au> (supporter:ARM/SHMOBILE ARM...)
Cc: linux-sh@vger.kernel.org (open list:ARM/SHMOBILE ARM...)
---
 arch/arm/boot/dts/r8a7790.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index c5e9783..ea180a5 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -758,4 +758,12 @@
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
1.8.5.2

