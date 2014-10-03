From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 03 Oct 2014 15:11:32 +0000
Subject: [PATCH v2 01/13] ARM: shmobile: emev2 dtsi: Use generic names for device nodes
Message-Id: <1412349104-18724-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1412349104-18724-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1412349104-18724-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

smu -> clocks
sti -> timer
uart -> serial

All but "clocks" are defined in ePAPR v1.1.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes
---
 arch/arm/boot/dts/emev2.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/emev2.dtsi b/arch/arm/boot/dts/emev2.dtsi
index 00eeed3721b63bfe..5fe9212b6bc5e50b 100644
--- a/arch/arm/boot/dts/emev2.dtsi
+++ b/arch/arm/boot/dts/emev2.dtsi
@@ -55,7 +55,7 @@
 			     <0 121 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
-	smu@e0110000 {
+	clocks@e0110000 {
 		compatible = "renesas,emev2-smu";
 		reg = <0xe0110000 0x10000>;
 		#address-cells = <2>;
@@ -129,7 +129,7 @@
 		};
 	};
 
-	sti@e0180000 {
+	timer@e0180000 {
 		compatible = "renesas,em-sti";
 		reg = <0xe0180000 0x54>;
 		interrupts = <0 125 IRQ_TYPE_LEVEL_HIGH>;
@@ -137,7 +137,7 @@
 		clock-names = "sclk";
 	};
 
-	uart@e1020000 {
+	serial@e1020000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1020000 0x38>;
 		interrupts = <0 8 IRQ_TYPE_LEVEL_HIGH>;
@@ -145,7 +145,7 @@
 		clock-names = "sclk";
 	};
 
-	uart@e1030000 {
+	serial@e1030000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1030000 0x38>;
 		interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
@@ -153,7 +153,7 @@
 		clock-names = "sclk";
 	};
 
-	uart@e1040000 {
+	serial@e1040000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1040000 0x38>;
 		interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
@@ -161,7 +161,7 @@
 		clock-names = "sclk";
 	};
 
-	uart@e1050000 {
+	serial@e1050000 {
 		compatible = "renesas,em-uart";
 		reg = <0xe1050000 0x38>;
 		interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.9.1

