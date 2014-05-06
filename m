From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Tue, 06 May 2014 14:23:51 +0000
Subject: [PATCH 4/6] ARM: shmobile: kzm9g: require ZB1 clock for Ethernet controller
Message-Id: <1399386233-11928-5-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Unlike the legacy stuff, CCF disables the ethernet controller's clock
unless it is used somewhere.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 708a50c..9d9f6e9 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -86,6 +86,7 @@
 		interrupt-parent = <&irqpin0>;
 		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
 		reg-io-width = <4>;
+		clocks = <&zb1_clk>;
 		smsc,irq-push-pull;
 		smsc,save-mac-address;
 		vddvario-supply = <&reg_1p8v>;
-- 
1.8.4.5

