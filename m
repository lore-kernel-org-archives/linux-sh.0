From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Fri, 13 Nov 2015 16:22:23 +0000
Subject: [PATCH 2/2] ARM: shmobile: r8a7790: switch console back to scif0
Message-Id: <1447431743-16376-3-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The boot loader uses scif0, and so must we if we want earlycon to work.

Partially reverts 7c0558941 ("ARM: shmobile: r8a7790: switch from scif
to scifa").

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index e2174d8..79f1411 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -47,13 +47,13 @@
 	compatible = "renesas,lager", "renesas,r8a7790";
 
 	aliases {
-		serial0 = &scifa0;
+		serial0 = &scif0;
 		serial1 = &scifa1;
 	};
 
 	chosen {
 		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
-		stdout-path = &scifa0;
+		stdout-path = &scif0;
 	};
 
 	memory@40000000 {
@@ -296,9 +296,9 @@
 		renesas,function = "du";
 	};
 
-	scifa0_pins: serial0 {
-		renesas,groups = "scifa0_data";
-		renesas,function = "scifa0";
+	scif0_pins: serial0 {
+		renesas,groups = "scif0_data";
+		renesas,function = "scif0";
 	};
 
 	ether_pins: ether {
@@ -467,8 +467,8 @@
 	};
 };
 
-&scifa0 {
-	pinctrl-0 = <&scifa0_pins>;
+&scif0 {
+	pinctrl-0 = <&scif0_pins>;
 	pinctrl-names = "default";
 
 	status = "okay";
-- 
2.6.1

