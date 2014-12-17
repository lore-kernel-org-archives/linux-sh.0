From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 17 Dec 2014 06:11:52 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7790: tidyup #sound-dai-cells settings
Message-Id: <878ui63iv8.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

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
 arch/arm/boot/dts/r8a7790-lager.dts |    1 +
 arch/arm/boot/dts/r8a7790.dtsi      |    7 ++++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index b33ebcb..0c3b678 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -581,6 +581,7 @@
 	pinctrl-0 = <&sound_pins &sound_clk_pins>;
 	pinctrl-names = "default";
 
+	/* Single DAI */
 	#sound-dai-cells = <0>;
 
 	status = "okay";
diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index ffeff98..7c7b08b 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1399,7 +1399,12 @@
 	};
 
 	rcar_sound: rcar_sound@ec500000 {
-		#sound-dai-cells = <1>;
+		/*
+		 * #sound-dai-cells is required
+		 *
+		 * Single DAI : #sound-dai-cells = <0>;		<&rcar_sound>;
+		 * Multi  DAI : #sound-dai-cells = <1>;		<&rcar_sound N>;
+		 */
 		compatible =  "renesas,rcar_sound-r8a7790", "renesas,rcar_sound-gen2", "renesas,rcar_sound";
 		reg =	<0 0xec500000 0 0x1000>, /* SCU */
 			<0 0xec5a0000 0 0x100>,  /* ADG */
-- 
1.7.9.5

