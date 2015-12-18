From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 18 Dec 2015 02:11:43 +0000
Subject: [PATCH 1/3] ARM: shmobile: r8a7790: use fallback usbhs compatibility string
Message-Id: <1450404705-5449-2-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1450404705-5449-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1450404705-5449-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use recently added fallback compatibility string in r8a7790 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 7dfd393bfc7e..d5f79ed17caf 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -746,7 +746,7 @@
 	};
 
 	hsusb: usb@e6590000 {
-		compatible = "renesas,usbhs-r8a7790";
+		compatible = "renesas,usbhs-r8a7790", "renesas,usbhs";
 		reg = <0 0xe6590000 0 0x100>;
 		interrupts = <0 107 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&mstp7_clks R8A7790_CLK_HSUSB>;
-- 
2.1.4

