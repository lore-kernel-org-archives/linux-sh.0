From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 29 Oct 2014 04:59:14 +0000
Subject: [PATCH 08/19] ARM: shmobile: emev2 dtsi: Add uart* labels for easier referencing
Message-Id: <e87aabaf24d660e3d4c68cfbd6aae0814b573375.1414556944.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1414556943.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1414556943.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index 5fe9212..cc7bfe0 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -137,7 +137,7 @@
 		clock-names = "sclk";
 	};
 
-	serial@e1020000 {
+	uart0: serial@e1020000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1020000 0x38>;
 		interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
@@ -145,7 +145,7 @@
 		clock-names = "sclk";
 	};
 
-	serial@e1030000 {
+	uart1: serial@e1030000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1030000 0x38>;
 		interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
@@ -153,7 +153,7 @@
 		clock-names = "sclk";
 	};
 
-	serial@e1040000 {
+	uart2: serial@e1040000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1040000 0x38>;
 		interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
@@ -161,7 +161,7 @@
 		clock-names = "sclk";
 	};
 
-	serial@e1050000 {
+	uart3: serial@e1050000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1050000 0x38>;
 		interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.1

