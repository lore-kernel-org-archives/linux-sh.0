From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 16 Sep 2014 16:10:37 +0000
Subject: [PATCH] ARM: shmobile: r8a7790: switch from scif to scifa
Message-Id: <1410883837-5611-1-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

SCIF and SCIFA can be plexed onto the same wires on Lager board. The
datasheet also describes the wires as SCIFA. So, to make use of the
bigger FIFOs switch to SCIFA instead.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Currently, I use this patch to check if the DMA RX issue is the same on SCIF
and SCIFA (yes, it is). However, I still think it makes sense to use the bigger
FIFOs. I will check this next week with Bastian's FIFO patches. Until then, I
send this as RFC to collect opinions speaking for/against this change.

 arch/arm/boot/dts/r8a7790-lager.dts | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 84dcafa7179b..782f0aa938b3 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -19,8 +19,8 @@
 	compatible = "renesas,lager", "renesas,r8a7790";
 
 	aliases {
-		serial6 = &scif0;
-		serial7 = &scif1;
+		serial6 = &scifa0;
+		serial7 = &scifa1;
 	};
 
 	chosen {
@@ -159,9 +159,9 @@
 		renesas,function = "du";
 	};
 
-	scif0_pins: serial0 {
-		renesas,groups = "scif0_data";
-		renesas,function = "scif0";
+	scifa0_pins: serial0 {
+		renesas,groups = "scifa0_data";
+		renesas,function = "scifa0";
 	};
 
 	ether_pins: ether {
@@ -174,9 +174,9 @@
 		renesas,function = "intc";
 	};
 
-	scif1_pins: serial1 {
-		renesas,groups = "scif1_data";
-		renesas,function = "scif1";
+	scifa1_pins: serial1 {
+		renesas,groups = "scifa1_data";
+		renesas,function = "scifa1";
 	};
 
 	sdhi0_pins: sd0 {
@@ -308,15 +308,15 @@
 	};
 };
 
-&scif0 {
-	pinctrl-0 = <&scif0_pins>;
+&scifa0 {
+	pinctrl-0 = <&scifa0_pins>;
 	pinctrl-names = "default";
 
 	status = "okay";
 };
 
-&scif1 {
-	pinctrl-0 = <&scif1_pins>;
+&scifa1 {
+	pinctrl-0 = <&scifa1_pins>;
 	pinctrl-names = "default";
 
 	status = "okay";
-- 
2.0.0

