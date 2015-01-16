From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 16 Jan 2015 02:34:53 +0000
Subject: [PATCH 1/4] ARM: shmobile: r8a7790 dtsi: Drop "renesas,rcar_sound" compatible value
Message-Id: <31078ecdc7b374efb3f4b2e60c620b2abc1ed307.1421371490.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1421371490.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1421371490.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

The "renesas,rcar_sound" compatible property value was never processed
nor documented.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index af7e255..7cef4d9 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1398,7 +1398,7 @@
 
 	rcar_sound: rcar_sound@ec500000 {
 		#sound-dai-cells = <1>;
-		compatible =  "renesas,rcar_sound-r8a7790", "renesas,rcar_sound-gen2", "renesas,rcar_sound";
+		compatible =  "renesas,rcar_sound-r8a7790", "renesas,rcar_sound-gen2";
 		reg =	<0 0xec500000 0 0x1000>, /* SCU */
 			<0 0xec5a0000 0 0x100>,  /* ADG */
 			<0 0xec540000 0 0x1000>, /* SSIU */
-- 
2.1.4

