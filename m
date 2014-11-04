From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 04 Nov 2014 16:21:24 +0000
Subject: [PATCH] ARM: shmobile: r8a73a4: fix scifb* naming
Message-Id: <1415118084-25911-1-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Ports are named scifb0-3, not scifb2-5.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a73a4.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index b5ead84..7f57dc7 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -274,14 +274,14 @@
 		status = "disabled";
 	};
 
-	scifb2: serial@e6c20000 {
+	scifb0: serial@e6c20000 {
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6c20000 0 0x100>;
 		interrupts = <0 148 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
 
-	scifb3: serial@e6c30000 {
+	scifb1: serial@e6c30000 {
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6c30000 0 0x100>;
 		interrupts = <0 149 IRQ_TYPE_LEVEL_HIGH>;
@@ -302,14 +302,14 @@
 		status = "disabled";
 	};
 
-	scifb4: serial@e6ce0000 {
+	scifb2: serial@e6ce0000 {
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6ce0000 0 0x100>;
 		interrupts = <0 150 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
 	};
 
-	scifb5: serial@e6cf0000 {
+	scifb3: serial@e6cf0000 {
 		compatible = "renesas,scifb-r8a73a4", "renesas,scifb";
 		reg = <0 0xe6cf0000 0 0x100>;
 		interrupts = <0 151 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.8.4.5

