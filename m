From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 18 Dec 2015 02:11:44 +0000
Subject: [PATCH 2/3] ARM: shmobile: r8a7791: use fallback usbhs compatibility string
Message-Id: <1450404705-5449-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1450404705-5449-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1450404705-5449-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use recently added fallback compatibility string in r8a7791 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 2a369ddcb6fd..e2ffbfae6c5c 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -822,7 +822,7 @@
 	};
 
 	hsusb: usb@e6590000 {
-		compatible = "renesas,usbhs-r8a7791";
+		compatible = "renesas,usbhs-r8a7791", "renesas,usbhs";
 		reg = <0 0xe6590000 0 0x100>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7791_CLK_HSUSB>;
-- 
2.1.4

