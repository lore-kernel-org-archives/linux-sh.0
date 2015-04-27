From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 27 Apr 2015 12:55:33 +0000
Subject: [PATCH 09/10] ARM: shmobile: kzm9d dts: Use generic names for device nodes
Message-Id: <1430139334-15272-10-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430139334-15272-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

lan9220 -> ethernet
uart -> serial

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index 19446273e4a7f832..1dee0aa4f40cc351 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -81,7 +81,7 @@
 		regulator-boot-on;
 	};
 
-	lan9220@20000000 {
+	ethernet@20000000 {
 		compatible = "smsc,lan9220", "smsc,lan9115";
 		reg = <0x20000000 0x10000>;
 		phy-mode = "mii";
@@ -96,7 +96,7 @@
 };
 
 &pfc {
-	uart1_pins: uart@e1030000 {
+	uart1_pins: serial@e1030000 {
 		renesas,groups = "uart1_ctrl", "uart1_data";
 		renesas,function = "uart1";
 	};
-- 
1.9.1

