From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 26 Feb 2015 16:42:14 +0000
Subject: [PATCH v4 9/9] ARM: shmobile: bockw dts: Remove leftover Ethernet node
Message-Id: <1424968934-30577-10-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The previous commit "ARM: shmobile: bockw dts: Move Ethernet node to BSC"
neglected to remove the old entry.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 9b9a5eb..cbb206b 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -46,17 +46,6 @@
 		regulator-always-on;
 	};
 
-	ethernet@18300000 {
-		compatible = "smsc,lan9220", "smsc,lan9115";
-		reg = <0x18300000 0x1000>;
-
-		phy-mode = "mii";
-		interrupt-parent = <&irqpin>;
-		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
-		reg-io-width = <4>;
-		vddvario-supply = <&fixedregulator3v3>;
-		vdd33a-supply = <&fixedregulator3v3>;
-	};
 
 	sound {
 		compatible = "simple-audio-card";
-- 
2.2.2

