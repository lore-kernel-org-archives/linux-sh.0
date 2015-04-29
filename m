From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 29 Apr 2015 13:55:43 +0000
Subject: [PATCH] ARM: shmobile: koelsch: Fix adv7511 IRQ sensing
Message-Id: <1430315743-8521-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The adv7511 IRQ is low level triggered, not falling edge triggered. The
wrong sense configuration results in no interrupt being triggered at
all, breaking hotplug detection. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 74c3212f1f11..824ddab9c3ad 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -545,7 +545,7 @@
 		compatible = "adi,adv7511w";
 		reg = <0x39>;
 		interrupt-parent = <&gpio3>;
-		interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
+		interrupts = <29 IRQ_TYPE_LEVEL_LOW>;
 
 		adi,input-depth = <8>;
 		adi,input-colorspace = "rgb";
-- 
Regards,

Laurent Pinchart

