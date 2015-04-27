From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 27 Apr 2015 12:55:34 +0000
Subject: [PATCH 10/10] ARM: shmobile: marzen dts: Use generic names for device nodes
Message-Id: <1430139334-15272-11-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

lan0 -> ethernet

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index 540756cdf3914a2a..20afea6f06ef6735 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -42,10 +42,10 @@
 		regulator-always-on;
 	};
 
-	lan0@18000000 {
+	ethernet@18000000 {
 		compatible = "smsc,lan9220", "smsc,lan9115";
 		reg = <0x18000000 0x100>;
-		pinctrl-0 = <&lan0_pins>;
+		pinctrl-0 = <&ethernet_pins>;
 		pinctrl-names = "default";
 
 		phy-mode = "mii";
@@ -176,7 +176,7 @@
 		};
 	};
 
-	lan0_pins: lan0 {
+	ethernet_pins: ethernet {
 		intc {
 			renesas,groups = "intc_irq1_b";
 			renesas,function = "intc";
-- 
1.9.1

