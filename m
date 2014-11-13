From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 13 Nov 2014 01:20:15 +0000
Subject: [PATCH 24/25] ARM: shmobile: koelsch dts: Add labels for the LEDs
Message-Id: <76eee5ff1fd8ca82809910fc1c89865ee9561a83.1415755881.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415755881.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1415755881.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The LEDs on the koelsch board are labeled using upper-case characters.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index f056e64..a10f534 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -149,12 +149,15 @@
 		compatible = "gpio-leds";
 		led6 {
 			gpios = <&gpio2 19 GPIO_ACTIVE_HIGH>;
+			label = "LED6";
 		};
 		led7 {
 			gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
+			label = "LED7";
 		};
 		led8 {
 			gpios = <&gpio2 21 GPIO_ACTIVE_HIGH>;
+			label = "LED8";
 		};
 	};
 
-- 
2.1.1

