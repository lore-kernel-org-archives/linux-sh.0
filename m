From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Jun 2014 08:10:27 +0000
Subject: [PATCH 3/3 v2] ARM: shmobile: lager: add sound support on DT
Message-Id: <87a99lchhh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It supports PIO transfer at this point

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

- no change

 arch/arm/boot/dts/r8a7790-lager.dts |   70 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig      |    1 +
 2 files changed, 71 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 295a60e..51a3e41 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -9,6 +9,18 @@
  * kind, whether express or implied.
  */
 
+/*
+ * SSI-AK4643
+ *
+ * SW1: 1: AK4643
+ *      2: CN22
+ *      3: ADV7511
+ *
+ * this command is required when playback.
+ *
+ * # amixer set "LINEOUT Mixer DACL" on
+ */
+
 /dts-v1/;
 #include "r8a7790.dtsi"
 #include <dt-bindings/gpio/gpio.h>
@@ -144,6 +156,22 @@
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
+
+		simple-audio-card,codec {
+			bitclock-master;
+			frame-master;
+			sound-dai = <&snd_codec>;
+			system-clock-frequency = <11289600>;
+		};
+	};
 };
 
 &extal_clk {
@@ -219,6 +247,16 @@
 		renesas,groups = "i2c3";
 		renesas,function = "i2c3";
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
@@ -372,3 +410,35 @@
 &i2c3	{
 	status = "ok";
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
+	pinctrl-0 = <&sound_pins &sound_clk_pins>;
+	pinctrl-names = "default";
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
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 3b28bd8..6fc352a 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -58,6 +58,7 @@ config MACH_LAGER
 	bool "Lager board"
 	depends on ARCH_R8A7790
 	select MICREL_PHY if SH_ETH
+	select SND_SOC_AK4642 if SND_SIMPLE_CARD
 
 config MACH_MARZEN
 	bool "MARZEN board"
-- 
1.7.9.5

