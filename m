From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Dec 2015 00:10:59 +0000
Subject: [PATCH] ARM: shmobile: r8a7778: tidyup #sound-dai-cells settings
Message-Id: <878u557qff.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449505537-15428-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1449505537-15428-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Renesas sound driver needs #sound-dai-cells settings, but, this usage
is a little bit confusable. It came from ALSA SoC historical reasons.
The sound DAI naming method is different between Single/Multi DAI in
the ALSA framework, and it is used for sound card matching.
And this #sound-dai-cells has relationship to it.
Current SoC dtsi has #sound-dai-cells = <1> as default settings
(= it is assuming that board/platform has multi DAI), and
board/platform side needs to overwrite it if board/platform was single
DAI. This style is more confusable for users.
This patch removes SoC side default settings, and force to set it by
board/platform side.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
This patch is based on Geert's
ARM: shmobile: bockw dts: Override #sound-dai-cells to zero

 arch/arm/boot/dts/r8a7778.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 4f8e078..b140627 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -236,7 +236,12 @@
 	};
 
 	rcar_sound: sound@ffd90000 {
-		#sound-dai-cells = <1>;
+		/*
+		 * #sound-dai-cells is required
+		 *
+		 * Single DAI : #sound-dai-cells = <0>;         <&rcar_sound>;
+		 * Multi  DAI : #sound-dai-cells = <1>;         <&rcar_sound N>;
+		 */
 		compatible = "renesas,rcar_sound-r8a7778", "renesas,rcar_sound-gen1";
 		reg =	<0xffd90000 0x1000>,	/* SRU */
 			<0xffd91000 0x240>,	/* SSI */
-- 
1.9.1

