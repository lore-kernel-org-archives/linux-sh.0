From: Bastian Hecht <hechtb@googlemail.com>
Date: Thu, 26 Apr 2012 14:00:59 +0000
Subject: [RFC DT style 1/4] ARM: sh-mobile: Add sh_flctl to sh7372-mackerel device tree
Message-Id: <1335448862-5201-2-git-send-email-hechtb@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add the flash controller flctl to the device tree of the mackerel board.
---
 arch/arm/boot/dts/sh7372-mackerel.dts |   36 +++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sh7372-mackerel.dts b/arch/arm/boot/dts/sh7372-mackerel.dts
index 1acbf28..eef01cf 100644
--- a/arch/arm/boot/dts/sh7372-mackerel.dts
+++ b/arch/arm/boot/dts/sh7372-mackerel.dts
@@ -28,6 +28,43 @@
 		smsc,irq-push-pull;
 	};
 
+	flctl@e6a30000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "renesas,shmobile-flctl";
+		interrupt-parent = <&intca>;
+		reg = <0xe6a30000 0x100>;
+		interrupts = <0x0d80>;
+
+		ext-bus-con;
+		use-holden;
+		clk-scheme = <0x20200>;
+
+		nand@0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			nand-ecc-mode = "hw";
+			nand-bus-width = <16>;
+			flctl-snand;
+
+			system@0 {
+				label = "system";
+				reg = <0x0 0x8000000>;
+			};
+
+			userdata@8000000 {
+				label = "userdata";
+				reg = <0x8000000 0x10000000>;
+			};
+
+			cache@18000000 {
+				label = "cache";
+				reg = <0x18000000 0x8000000>;
+			};
+		};
+	};
+
 	i2c0: i2c@fff20000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.7.5.4

