From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 25 Mar 2014 04:37:28 +0000
Subject: [PATCH 7/7] ARM: shmobile: bockw: add R-Car sound support on DTS
Message-Id: <87y4zyc2re.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts |  138 +++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index f76f6ec..7d467f6 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -53,6 +53,87 @@
 		vdd33a-supply = <&fixedregulator3v3>;
 	};
 
+	sound_card1 {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,format = "left_j";
+		simple-audio-card,cpu {
+			sound-dai = <&rcar_sound 0>;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&ak4643_codec>;
+			bitclock-master;
+			frame-master;
+			system-clock-frequency = <11289600>;
+		};
+	};
+
+	sound_card2 {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,format = "right_j";
+		simple-audio-card,cpu {
+			sound-dai = <&rcar_sound 1>;
+			bitclock-master;
+			frame-master;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&ak4554_codec_0>;
+		};
+	};
+
+	sound_card3 {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,format = "left_j";
+		simple-audio-card,cpu {
+			sound-dai = <&rcar_sound 2>;
+			bitclock-master;
+			frame-master;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&ak4554_codec_0>;
+		};
+	};
+
+	sound_card4 {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,format = "right_j";
+		simple-audio-card,cpu {
+			sound-dai = <&rcar_sound 3>;
+			bitclock-master;
+			frame-master;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&ak4554_codec_1>;
+		};
+	};
+
+	sound_card5 {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,format = "right_j";
+		simple-audio-card,cpu {
+			sound-dai = <&rcar_sound 4>;
+			bitclock-master;
+			frame-master;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&ak4554_codec_1>;
+		};
+	};
+
+	ak4554_codec_0: ak4554 {
+		#sound-dai-cells = <0>;
+		compatible = "asahi-kasei,ak4554";
+	};
+
+	ak4554_codec_1: ak4554 {
+		#sound-dai-cells = <0>;
+		compatible = "asahi-kasei,ak4554";
+	};
+
 };
 
 &mmcif {
@@ -93,6 +174,19 @@
 		renesas,groups = "hspi0_a";
 		renesas,function = "hspi0";
 	};
+
+	sound_pins: sound {
+		renesas,groups = "ssi34_ctrl", "ssi3_data", "ssi4_data",
+				 "ssi5_ctrl", "ssi5_data", "ssi6_ctrl",
+				 "ssi6_data", "ssi78_ctrl", "ssi7_data",
+				 "ssi8_data";
+		renesas,function = "ssi";
+	};
+
+	sound_clk_pins: sound_clk {
+		renesas,groups = "audio_clk_a", "audio_clk_b";
+		renesas,function = "audio_clk";
+	};
 };
 
 &sdhi0 {
@@ -124,3 +218,47 @@
 		};
 	};
 };
+
+&i2c0 {
+	status = "okay";
+	ak4643_codec: ak4643 {
+		#sound-dai-cells = <0>;
+		compatible = "asahi-kasei,ak4643";
+		reg = <0x12>;
+	};
+};
+
+&rcar_sound {
+	pinctrl-names = "default", "audio_clock";
+	pinctrl-0 = <&sound_pins>;
+	pinctrl-2 = <&sound_clk_pins>;
+
+	status = "okay";
+
+	rcar_sound,dai {
+		dai0 {
+			playback = <&ssi5>;
+			capture  = <&ssi6>;
+		};
+		dai1 {
+			playback = <&ssi3>;
+		};
+		dai2 {
+			capture  = <&ssi4>;
+		};
+		dai3 {
+			capture  = <&ssi7>;
+		};
+		dai4 {
+			capture  = <&ssi8>;
+		};
+	};
+};
+
+&ssi4 {
+	shared-pin;
+};
+
+&ssi8 {
+	shared-pin;
+};
-- 
1.7.9.5

