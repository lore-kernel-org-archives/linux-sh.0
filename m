From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 23 Apr 2014 01:26:01 +0000
Subject: [PATCH 33/33] ARM: shmobile: armadillo-reference dts: Seiko Instruments, Inc is "sii"
Message-Id: <dd485ab9a88267f4db0d58ace23b19e876ebf8ac.1398216022.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1398216022.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1398216022.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Use "sii,s35390a" instead of "seiko,s35390a", cfr.
Documentation/devicetree/bindings/i2c/trivial-devices.txt and
Documentation/devicetree/bindings/vendor-prefixes.txt.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 0cb235a..10344e6 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -180,7 +180,7 @@
 &i2c2 {
 	status = "okay";
 	rtc@30 {
-		compatible = "seiko,s35390a";
+		compatible = "sii,s35390a";
 		reg = <0x30>;
 	};
 };
-- 
1.8.5.2

