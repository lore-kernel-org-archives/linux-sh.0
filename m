From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 16 Jan 2015 02:34:55 +0000
Subject: [PATCH 3/4] ARM: shmobile: r8a7790: tidyup #sound-dai-cells settings
Message-Id: <ad63241cdc328edbb0f879416ea7707bf0997f08.1421371490.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1421371490.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1421371490.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

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
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 1 +
 arch/arm/boot/dts/r8a7790.dtsi      | 7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 636d53b..2bc20e4 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -579,6 +579,7 @@
 	pinctrl-0 = <&sound_pins &sound_clk_pins>;
 	pinctrl-names = "default";
 
+	/* Single DAI */
 	#sound-dai-cells = <0>;
 
 	status = "okay";
diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 7cef4d9..1543fa5 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1397,7 +1397,12 @@
 	};
 
 	rcar_sound: rcar_sound@ec500000 {
-		#sound-dai-cells = <1>;
+		/*
+		 * #sound-dai-cells is required
+		 *
+		 * Single DAI : #sound-dai-cells = <0>;         <&rcar_sound>;
+		 * Multi  DAI : #sound-dai-cells = <1>;         <&rcar_sound N>;
+		 */
 		compatible =  "renesas,rcar_sound-r8a7790", "renesas,rcar_sound-gen2";
 		reg =	<0 0xec500000 0 0x1000>, /* SCU */
 			<0 0xec5a0000 0 0x100>,  /* ADG */
-- 
2.1.4

