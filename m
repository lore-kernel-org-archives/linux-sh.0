From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 25 Aug 2014 01:10:05 +0000
Subject: [PATCH 5/7] ARM: shmobile: r8a7790 dtsi: Remove superfluous interrupt-parent
Message-Id: <980724eb5b56b43d0ff2c7a7f5cf6e5ba290d2e5.1408928822.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1408928822.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1408928822.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

There's already an "interrupt-parent = <&gic>;" at the top, which is
inherited by all child nodes, so the "interrupt-parent" property in
the sound node can be removed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index c11541d..4b6915a 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1126,7 +1126,6 @@
 	rcar_sound: rcar_sound@0xec500000 {
 		#sound-dai-cells = <1>;
 		compatible =  "renesas,rcar_sound-r8a7790", "renesas,rcar_sound-gen2", "renesas,rcar_sound";
-		interrupt-parent = <&gic>;
 		reg =	<0 0xec500000 0 0x1000>, /* SCU */
 			<0 0xec5a0000 0 0x100>,  /* ADG */
 			<0 0xec540000 0 0x1000>, /* SSIU */
-- 
2.0.1

