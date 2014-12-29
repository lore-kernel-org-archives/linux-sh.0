From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 29 Dec 2014 01:43:54 +0000
Subject: [PATCH 23/30] ARM: shmobile: ape6evm: fix compatible string for Ethernet controller
Message-Id: <6cdaa63f9e2b3ea0ac57a71a43f96cf626500d35.1419812186.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1419812185.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1419812185.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

It's a 9220, not a 9118.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index ce085fa..baca8f8 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -43,7 +43,7 @@
 		#size-cells = <1>;
 
 		ethernet@8000000 {
-			compatible = "smsc,lan9118", "smsc,lan9115";
+			compatible = "smsc,lan9220", "smsc,lan9115";
 			reg = <0x08000000 0x1000>;
 			interrupt-parent = <&irqc1>;
 			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.3

