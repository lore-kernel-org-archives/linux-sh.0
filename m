From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 28 Aug 2014 08:21:56 +0000
Subject: [PATCH 2/2] ARM: shmobile: kzm9g-reference dts: Use tabs for indentation
Message-Id: <1409214116-6016-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1409214116-6016-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1409214116-6016-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Checkpatch says:

ERROR: code indent should use tabs where possible

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 18662aec2ec4..477f8153debd 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
@@ -66,7 +66,7 @@
 	};
 
 	vmmc_sdhi0: regulator@2 {
-	        compatible = "regulator-fixed";
+		compatible = "regulator-fixed";
 		regulator-name = "SDHI0 Vcc";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
@@ -75,7 +75,7 @@
 	};
 
 	vmmc_sdhi2: regulator@3 {
-	        compatible = "regulator-fixed";
+		compatible = "regulator-fixed";
 		regulator-name = "SDHI2 Vcc";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-- 
1.9.1

