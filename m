From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Wed, 17 Dec 2014 16:18:15 +0000
Subject: [PATCH v3 3/9] ARM: shmobile: ape6evm: Add LEDs to the device tree
Message-Id: <1418833101-7774-4-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index c98cd14..b939a37 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -82,6 +82,34 @@
 			vddvario-supply = <&ape6evm_fixed_3v3>;
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led1 {
+			gpios = <&pfc 28 GPIO_ACTIVE_LOW>;
+			label = "GNSS_EN";
+		};
+		led2 {
+			gpios = <&pfc 126 GPIO_ACTIVE_LOW>;
+			label = "NFC_NRST";
+		};
+		led3 {
+			gpios = <&pfc 132 GPIO_ACTIVE_LOW>;
+			label = "GNSS_NRST";
+		};
+		led4 {
+			gpios = <&pfc 232 GPIO_ACTIVE_LOW>;
+			label = "BT_WAKEUP";
+		};
+		led5 {
+			gpios = <&pfc 250 GPIO_ACTIVE_LOW>;
+			label = "STROBE";
+		};
+		led6 {
+			gpios = <&pfc 288 GPIO_ACTIVE_LOW>;
+			label = "BBRESETOUT";
+		};
+	};
 };
 
 &i2c5 {
-- 
1.8.4.5

