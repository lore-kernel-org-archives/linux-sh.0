From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Tue, 02 Dec 2014 08:37:06 +0000
Subject: [PATCH 2/3] ARM: shmobile: ape6evm-reference: Add LEDs to the device tree
Message-Id: <1417509427-31690-3-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
---
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts | 28 +++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
index a218c26..a2c73c4 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
@@ -82,6 +82,34 @@
 			vdd33a-supply = <&ape6evm_fixed_3v3>;
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			gpios = <&pfc 28 GPIO_ACTIVE_LOW>;
+			label = "gnss-en";
+		};
+		led2 {
+			gpios = <&pfc 126 GPIO_ACTIVE_LOW>;
+			label = "nfc-nrst";
+		};
+		led3 {
+			gpios = <&pfc 132 GPIO_ACTIVE_LOW>;
+			label = "gnss-nrst";
+		};
+		led4 {
+			gpios = <&pfc 232 GPIO_ACTIVE_LOW>;
+			label = "bt-wakeup";
+		};
+		led5 {
+			gpios = <&pfc 250 GPIO_ACTIVE_LOW>;
+			label = "strobe";
+		};
+		led6 {
+			gpios = <&pfc 288 GPIO_ACTIVE_LOW>;
+			label = "bbresetout";
+		};
+	};
 };
 
 &i2c5 {
-- 
1.8.4.5

