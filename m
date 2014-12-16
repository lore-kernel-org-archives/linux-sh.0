From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 16 Dec 2014 23:17:25 +0000
Subject: [PATCH] ARM: shmobile: ape6evm: Fix LAN9220 VDDVARIO voltage
Message-Id: <1418771845-12191-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The LAN9220 VDDVARIO supply is powered by a 1.8V source, not 3.3V. Fix
it in the device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

This patch is based on top of Ulrich's "[PATCH v2 0/7] ARM: shmobile: ape6evm:
multiplatform support" series, but it could easily be rebased to apply without
that dependency.

diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
index 6b7bc1fb842e..0d50bef01234 100644
--- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
+++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
@@ -55,8 +55,16 @@
 		enable-active-high;
 	};
 
-	/* Common 3.3V rail, used by several devices on APE6EVM */
-	ape6evm_fixed_3v3: regulator@2 {
+	/* Common 1.8V and 3.3V rails, used by several devices on APE6EVM */
+	ape6evm_fixed_1v8: regulator@2 {
+		compatible = "regulator-fixed";
+		regulator-name = "1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	ape6evm_fixed_3v3: regulator@3 {
 		compatible = "regulator-fixed";
 		regulator-name = "3V3";
 		regulator-min-microvolt = <3300000>;
@@ -80,7 +88,7 @@
 			smsc,irq-active-high;
 			smsc,irq-push-pull;
 			vdd33a-supply = <&ape6evm_fixed_3v3>;
-			vddvario-supply = <&ape6evm_fixed_3v3>;
+			vddvario-supply = <&ape6evm_fixed_1v8>;
 		};
 	};
 
-- 
Regards,

Laurent Pinchart

