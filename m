From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 18 Nov 2015 22:20:35 +0000
Subject: [PATCH 2/2] ARM: shmobile: gose: Add GPIO leds to DT
Message-Id: <1447885235-17858-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1447885235-17858-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1447885235-17858-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Instantiate the GPIO leds in the gose device tree.

Based on similar work for the koelsch board by Magnus Damm.

Cc: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
* Compile Tested Only
---
 arch/arm/boot/dts/r8a7793-gose.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index ff391d2fb767..7e1794736aa9 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -113,6 +113,22 @@
 		        debounce-interval = <20>;
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led6 {
+			gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+			label = "LED6";
+		};
+		led7 {
+			gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
+			label = "LED7";
+		};
+		led8 {
+			gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
+			label = "LED8";
+		};
+	};
 };
 
 &extal_clk {
-- 
2.1.4

