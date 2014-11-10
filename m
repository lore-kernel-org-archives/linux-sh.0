From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 10 Nov 2014 01:32:21 +0000
Subject: [PATCH 4/8] ARM: shmobile: r8a7790 dtsi: Drop bogus 0x unit-address prefix
Message-Id: <83b4fb6d9034b989075b4887d86b80bd41884d85.1415582842.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415582842.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1415582842.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 2be9122..77b7f76 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1151,7 +1151,7 @@
 		status = "disabled";
 	};
 
-	rcar_sound: rcar_sound@0xec500000 {
+	rcar_sound: rcar_sound@ec500000 {
 		#sound-dai-cells = <1>;
 		compatible =  "renesas,rcar_sound-r8a7790", "renesas,rcar_sound-gen2", "renesas,rcar_sound";
 		reg =	<0 0xec500000 0 0x1000>, /* SCU */
-- 
2.1.1

