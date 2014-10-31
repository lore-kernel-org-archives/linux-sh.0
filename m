From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 31 Oct 2014 08:03:17 +0000
Subject: [PATCH 08/12] ARM: shmobile: koelsch: Sound PIO support on DTS
Message-Id: <87ppd81xa2.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts |   70 +++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 1ad9fb3..f612e09 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -10,6 +10,18 @@
  * kind, whether express or implied.
  */
 
+/*
+ * SSI-AK4643
+ *
+ * SW1: 1: AK4643
+ *      2: CN22
+ *      3: ADV7511
+ *
+ * This command is required when Playback/Capture
+ *
+ *	amixer set "LINEOUT Mixer DACL" on
+ */
+
 /dts-v1/;
 #include "r8a7791.dtsi"
 #include <dt-bindings/gpio/gpio.h>
@@ -210,6 +222,23 @@
 		states = <3300000 1
 			  1800000 0>;
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,format = "left_j";
+		simple-audio-card,bitclock-master = <&sndcodec>;
+		simple-audio-card,frame-master = <&sndcodec>;
+
+		sndcpu: simple-audio-card,cpu {
+			sound-dai = <&rcar_sound>;
+		};
+
+		sndcodec: simple-audio-card,codec {
+			sound-dai = <&ak4643>;
+			system-clock-frequency = <11289600>;
+		};
+	};
 };
 
 &du {
@@ -300,6 +329,16 @@
 		renesas,groups = "vin1_data8", "vin1_clk";
 		renesas,function = "vin1";
 	};
+
+	sound_pins: sound {
+		renesas,groups = "ssi0129_ctrl", "ssi0_data", "ssi1_data";
+		renesas,function = "ssi";
+	};
+
+	sound_clk_pins: sound_clk {
+		renesas,groups = "audio_clk_a";
+		renesas,function = "audio_clk";
+	};
 };
 
 &ether {
@@ -426,6 +465,12 @@
 
 	status = "okay";
 
+	ak4643: sound-codec@12 {
+		compatible = "asahi-kasei,ak4643";
+		#sound-dai-cells = <0>;
+		reg = <0x12>;
+	};
+
 	composite-in@20 {
 		compatible = "adi,adv7180";
 		reg = <0x20>;
@@ -512,3 +557,28 @@
 		};
 	};
 };
+
+&rcar_sound {
+	pinctrl-0 = <&sound_pins &sound_clk_pins>;
+	pinctrl-names = "default";
+
+	#sound-dai-cells = <0>;
+
+	status = "okay";
+
+	rcar_sound,dai {
+		dai0 {
+			playback = <&ssi0>;
+			capture  = <&ssi1>;
+		};
+	};
+};
+
+&ssi0 {
+	pio-transfer;
+};
+
+&ssi1 {
+	pio-transfer;
+	shared-pin;
+};
-- 
1.7.9.5

