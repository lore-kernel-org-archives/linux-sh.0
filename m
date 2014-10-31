From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 31 Oct 2014 08:01:17 +0000
Subject: [PATCH 02/12] ARM: shmobile: r8a7791: Remove unneeded prefix for sound
Message-Id: <87y4rw1xde.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

"0x" is not needed

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7791.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 73e4c8e..828b4c5 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1313,7 +1313,7 @@
 		status = "disabled";
 	};
 
-	rcar_sound: rcar_sound@0xec500000 {
+	rcar_sound: rcar_sound@ec500000 {
 		#sound-dai-cells = <1>;
 		compatible =  "renesas,rcar_sound-r8a7791", "renesas,rcar_sound-gen2", "renesas,rcar_sound";
 		reg =	<0 0xec500000 0 0x1000>, /* SCU */
-- 
1.7.9.5

