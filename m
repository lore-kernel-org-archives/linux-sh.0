From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Thu, 06 Mar 2014 18:01:25 +0000
Subject: [PATCH 7/9] ARM: shmobile: r8a7790.dtsi: add usbphy node
Message-Id: <1394128887-4197-8-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1394128887-4197-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-usb@vger.kernel.org
Cc: linux-kernel@lists.codethink.co.uk, sergei.shtylyov@cogentembedded.com, magnus.damn@opensource.se, horms@verge.net.au, Ben Dooks <ben.dooks@codethink.co.uk>, devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

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
index 7325fee..4c03c46 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -802,4 +802,12 @@
 		#address-cells = <3>;
 		#size-cells = <2>;
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
1.9.0

