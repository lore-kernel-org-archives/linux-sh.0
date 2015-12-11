From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 11 Dec 2015 02:59:38 +0000
Subject: [PATCH] ARM: shmobile: r8a779x: use SoC-specific usb-dac compatibility strings
Message-Id: <1449802778-11777-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Use recently SoC-specific compatibility strings in r8a779[01] device trees.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
Based on renesas-devel-20151211-v4.4-rc4
---
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++--
 arch/arm/boot/dts/r8a7791.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 9f3036b80c0e..c6f083c9345d 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -386,7 +386,7 @@
 	};
 
 	usb_dmac0: dma-controller@e65a0000 {
-		compatible = "renesas,usb-dmac";
+		compatible = "renesas,r8a7790-usb-dmac", "renesas,usb-dmac";
 		reg = <0 0xe65a0000 0 0x100>;
 		interrupts = <0 109 IRQ_TYPE_LEVEL_HIGH
 			      0 109 IRQ_TYPE_LEVEL_HIGH>;
@@ -398,7 +398,7 @@
 	};
 
 	usb_dmac1: dma-controller@e65b0000 {
-		compatible = "renesas,usb-dmac";
+		compatible = "renesas,r8a7790-usb-dmac", "renesas,usb-dmac";
 		reg = <0 0xe65b0000 0 0x100>;
 		interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH
 			      0 110 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 36559cb0eb6b..ae1dda181624 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -375,7 +375,7 @@
 	};
 
 	usb_dmac0: dma-controller@e65a0000 {
-		compatible = "renesas,usb-dmac";
+		compatible = "renesas,r8a7791-usb-dmac", "renesas,usb-dmac";
 		reg = <0 0xe65a0000 0 0x100>;
 		interrupts = <0 109 IRQ_TYPE_LEVEL_HIGH
 			      0 109 IRQ_TYPE_LEVEL_HIGH>;
@@ -387,7 +387,7 @@
 	};
 
 	usb_dmac1: dma-controller@e65b0000 {
-		compatible = "renesas,usb-dmac";
+		compatible = "renesas,r8a7791-usb-dmac", "renesas,usb-dmac";
 		reg = <0 0xe65b0000 0 0x100>;
 		interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH
 			      0 110 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.4

