From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 25 Aug 2015 07:14:50 +0000
Subject: [PATCH v2] ARM: shmobile: r8a7778: tidyup SSI resource region
Message-Id: <87bndv7shl.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - 0x240

 arch/arm/boot/dts/r8a7778.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 4b1fa9f..4f8e078 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -239,7 +239,7 @@
 		#sound-dai-cells = <1>;
 		compatible = "renesas,rcar_sound-r8a7778", "renesas,rcar_sound-gen1";
 		reg =	<0xffd90000 0x1000>,	/* SRU */
-			<0xffd91000 0x1240>,	/* SSI */
+			<0xffd91000 0x240>,	/* SSI */
 			<0xfffe0000 0x24>;	/* ADG */
 		clocks = <&mstp3_clks R8A7778_CLK_SSI8>,
 			<&mstp3_clks R8A7778_CLK_SSI7>,
-- 
1.9.1

