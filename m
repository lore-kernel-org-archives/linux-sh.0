From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 04 Sep 2014 01:12:28 +0000
Subject: [PATCH 5/5] ARM: shmobile: kzm9g-reference dts: Use tabs for indentation
Message-Id: <40c488df84f9fbf4b84b4baed6e2cec4a2d946ed.1409792871.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1409792871.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1409792871.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Checkpatch says:

ERROR: code indent should use tabs where possible

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts b/arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
index 18662ae..477f815 100644
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
2.0.1

