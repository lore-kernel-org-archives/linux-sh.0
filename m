From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 07 Oct 2015 01:57:44 +0000
Subject: [PATCH 07/28] ARM: shmobile: kzm9g dts: Use adxl345-specific compatible property
Message-Id: <755252d0e502627df6ddabbb2d628705bc256497.1444182812.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1444182812.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1444182812.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Replace the deprecated generic "adi,adxl34x" compatible value by the
adxl345-specific "adi,adxl345" value, cfr. commit e465bf6fc55d5ce2 ("DT:
i2c: Deprecate adi,adxl34x compatible string").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index 24b4cd24dceb..7fc5602810ad 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -206,7 +206,7 @@
 	};
 
 	accelerometer@1d {
-		compatible = "adi,adxl34x";
+		compatible = "adi,adxl345";
 		reg = <0x1d>;
 		interrupt-parent = <&irqpin3>;
 		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.1.4

