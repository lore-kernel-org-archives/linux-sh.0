From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Wed, 17 Dec 2014 16:18:13 +0000
Subject: [PATCH v3 1/9] ARM: shmobile: ape6evm: fix compatible string for Ethernet controller
Message-Id: <1418833101-7774-2-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It's a 9220, not a 9118.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
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
1.8.4.5

