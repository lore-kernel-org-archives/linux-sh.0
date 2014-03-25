From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 25 Mar 2014 04:37:21 +0000
Subject: [PATCH 6/7] ARM: shmobile: lager: add R-Car sound support on DTS
Message-Id: <87zjkec2rl.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts |   51 +++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index a55c5f8..bb92a7a 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -139,6 +139,21 @@
 		states = <3300000 1
 			  1800000 0>;
 	};
+
+	sound {
+		compatible = "simple-audio-card";
+
+		simple-audio-card,format = "left_j";
+		simple-audio-card,cpu {
+			sound-dai = <&rcar_sound 0>;
+		};
+		simple-audio-card,codec {
+			sound-dai = <&snd_codec>;
+			bitclock-master;
+			frame-master;
+			system-clock-frequency = <11289600>;
+		};
+	};
 };
 
 &extal_clk {
@@ -199,6 +214,14 @@
 				 "msiof1_tx";
 		renesas,function = "msiof1";
 	};
+	sound_pins: sound {
+		renesas,groups = "ssi0129_ctrl", "ssi0_data", "ssi1_data";
+		renesas,function = "ssi";
+	};
+	sound_clk_pins: sound_clk {
+		renesas,groups = "audio_clk_a";
+		renesas,function = "audio_clk";
+	};
 };
 
 &ether {
@@ -297,3 +320,31 @@
 	cd-gpios = <&gpio3 22 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
+
+&i2c2 {
+	status = "okay";
+	snd_codec: ak4643 {
+		#sound-dai-cells = <0>;
+		compatible = "asahi-kasei,ak4643";
+		reg = <0x12>;
+	};
+};
+
+&rcar_sound {
+	pinctrl-names = "default", "audio_clock";
+	pinctrl-0 = <&sound_pins>;
+	pinctrl-1 = <&sound_clk_pins>;
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
+&ssi1 {
+	shared-pin;
+};
-- 
1.7.9.5

