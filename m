From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 03 Oct 2014 15:11:33 +0000
Subject: [PATCH v2 02/13] ARM: shmobile: emev2 dtsi: Add uart* labels for easier referencing
Message-Id: <1412349104-18724-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1412349104-18724-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1412349104-18724-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes
---
 arch/arm/boot/dts/emev2.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index 5fe9212b6bc5e50b..cc7bfe0ba40af9a9 100644
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
1.9.1

