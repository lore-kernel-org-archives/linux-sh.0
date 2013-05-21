From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 21 May 2013 12:14:42 +0000
Subject: [PATCH v4 21/21] ARM: shmobile: marzen-reference: Add LED2-LED4 to the device tree
Message-Id: <1369138482-5871-22-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

LED2 to LED4 are GPIO LEDs. Add corresponding DT nodes.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7779-marzen-reference.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
index 596e313..48e254b 100644
--- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -48,6 +48,19 @@
 		vddvario-supply = <&fixedregulator3v3>;
 		vdd33a-supply = <&fixedregulator3v3>;
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		led2 {
+			gpios = <&gpio4 29 0>;
+		};
+		led3 {
+			gpios = <&gpio4 30 0>;
+		};
+		led4 {
+			gpios = <&gpio4 31 0>;
+		};
+	};
 };
 
 &pfc {
-- 
1.8.1.5

