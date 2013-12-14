From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 14 Dec 2013 15:25:26 +0000
Subject: [PATCH v5 02/17] ARM: shmobile: Sync Koelsch DTS with Koelsch reference DTS
Message-Id: <1387034741-3852-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Copy the device nodes from Koelsch reference into the Koeslch device
tree file. This will allow us to use a single DTS file regarless of
kernel configuration. In case of legacy C board code the device nodes
may or may not be used, but in the multiplatform case all the DT device
nodes are used.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 83 +++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index c4e8b3a..58ed169 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 #include "r8a7791.dtsi"
+#include <dt-bindings/gpio/gpio.h>
 
 / {
 	model = "Koelsch";
@@ -29,4 +30,86 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		key-a {
+			gpios = <&gpio7 0 GPIO_ACTIVE_LOW>;
+			linux,code = <30>;
+			label = "SW30";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+		key-b {
+			gpios = <&gpio7 1 GPIO_ACTIVE_LOW>;
+			linux,code = <48>;
+			label = "SW31";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+		key-c {
+			gpios = <&gpio7 2 GPIO_ACTIVE_LOW>;
+			linux,code = <46>;
+			label = "SW32";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+		key-d {
+			gpios = <&gpio7 3 GPIO_ACTIVE_LOW>;
+			linux,code = <32>;
+			label = "SW33";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+		key-e {
+			gpios = <&gpio7 4 GPIO_ACTIVE_LOW>;
+			linux,code = <18>;
+			label = "SW34";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+		key-f {
+			gpios = <&gpio7 5 GPIO_ACTIVE_LOW>;
+			linux,code = <33>;
+			label = "SW35";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+		key-g {
+			gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
+			linux,code = <34>;
+			label = "SW36";
+			gpio-key,wakeup;
+			debounce-interval = <20>;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led6 {
+			gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+		};
+		led7 {
+			gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
+		};
+		led8 {
+			gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
+		};
+	};
+};
+
+&pfc {
+	pinctrl-0 = <&scif0_pins &scif1_pins>;
+	pinctrl-names = "default";
+
+	scif0_pins: serial0 {
+		renesas,groups = "scif0_data_d";
+		renesas,function = "scif0";
+	};
+
+	scif1_pins: serial1 {
+		renesas,groups = "scif1_data_d";
+		renesas,function = "scif1";
+	};
 };
-- 
1.8.3.2

