From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 03 Apr 2015 01:37:35 +0000
Subject: [LOCAL PATCH] test: ARM: shmobile: SRC sampling rate convert
Message-Id: <877ftuxaa6.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all

Latest ALSA SoC branch is including Synchronous SRC mode on
43cb6954f8c8a68fdc354226fa045ff43c7e4d39
(ASoC: rsnd: add Synchronous SRC mode)

ALSA SoC git repository
 git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git :: topic/rcar

You can try Synchronous/Asynchronous sampling rate convert.

 - git checkout Geert's renesas-drivers-2015-03-30-v4.0-rc6 or similar
 - git merge ASoC branch asoc/topic/rcar
 - apply this patch

Asynchronous SRC mode:
	Use normal playback. it will exchange sampling rate convert
	to 48kHz. The image is...

	48kHz   ->
	44.1kHz ->  [SRC] -> 48kHz -> [SSI] -> ak4642
	22050Hz ->
	...

	But unfortunately, Lager board only has 1 system clock which
	is needed for sampling rate convert. Because of this reason,
	this patch try to exchange to 48kHz from 12288000 Hz.
	So, 44.1kHz base sound will be strange sound.
	Because 44.1kHz base needs 11289600 Hz, but Lager doesn't have it.
	It needs both 11289600/12288000 system clock if you want to use
	all sampling rate.
	But, don't worry about this. Asynchronous SRC mode is not needed
	on Lager anyway. this is just for test/debug.

Synchronous SRC mode:
	You can try this command.
		amixer set "SRC Out Rate" on
		aplay xxx.wav &
		amixer set "SRC Out Rate" 96000	// convert rate to 96000Hz
		amixer set "SRC Out Rate" 22050 // convert rate to 22050Hz
	You can exchange sampling rate on runtime. But ak4642 is keeping
	48kHz on this patch. So, the sound will be fast/slow.
	Sampling rate will be reset when you stop aplay. I don't know detail
	of use case of this feature...

I'm happy if I could have feedback from you.

>> Simon

This is just test/debug patch. don't apply it to your branch :P

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 40 +++++++++++++++++++++++++++++++++----
 arch/arm/configs/shmobile_defconfig |  1 +
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index aaa4f25..5360067 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -18,7 +18,7 @@
  *
  * This command is required when Playback/Capture
  *
- *	amixer set "LINEOUT Mixer DACL" on
+ *	amixer set "ak4642 LINEOUT Mixer DACL" on
  *	amixer set "DVC Out" 100%
  *	amixer set "DVC In" 100%
  *
@@ -35,6 +35,13 @@
  *	aplay xxx.wav &
  *	amixer set "DVC Out"  80%  // Volume Down
  *	amixer set "DVC Out" 100%  // Volume Up
+ *
+ * You can use Synchronous Sampling Rate Convert (if no DVC)
+ *
+ *	amixer set "SRC Out Rate" on
+ *	aplay xxx.wav &
+ *	amixer set "SRC Out Rate" 96000	// convert rate to 96000Hz
+ *	amixer set "SRC Out Rate" 22050 // convert rate to 22050Hz
  */
 
 /dts-v1/;
@@ -174,8 +181,9 @@
 			  1800000 0>;
 	};
 
-	sound {
+	sound@1 {
 		compatible = "simple-audio-card";
+		status = "disabled";
 
 		simple-audio-card,format = "left_j";
 		simple-audio-card,bitclock-master = <&sndcodec>;
@@ -191,6 +199,26 @@
 		};
 	};
 
+	sound@2 {
+		compatible = "renesas,rsrc-card,lager";
+
+		card-name = "rsnd-ak4643";
+		format = "left_j";
+		bitclock-master = <&dpcmcpu>;
+		frame-master = <&dpcmcpu>;
+
+		convert-rate = <48000>; /* see audio_clk_a */
+
+		dpcmcpu: cpu {
+			sound-dai = <&rcar_sound>;
+		};
+
+		dpcmcodec: codec {
+			sound-dai = <&ak4643>;
+			system-clock-frequency = <11289600>;
+		};
+	};
+
 	vga-encoder {
 		compatible = "adi,adv7123";
 
@@ -675,8 +703,8 @@
 
 	rcar_sound,dai {
 		dai0 {
-			playback = <&ssi0 &src2 &dvc0>;
-			capture  = <&ssi1 &src3 &dvc1>;
+			playback = <&ssi0 &src2>;
+			capture  = <&ssi1 &src3>;
 		};
 	};
 };
@@ -684,3 +712,7 @@
 &ssi1 {
 	shared-pin;
 };
+
+&audio_clk_a {
+       clock-frequency = <12288000>; /* 48000 base clock */
+};
diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index b58618e..d2f807d 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -152,6 +152,7 @@ CONFIG_SND=y
 CONFIG_SND_SOC=y
 CONFIG_SND_SOC_SH4_FSI=y
 CONFIG_SND_SOC_RCAR=y
+CONFIG_SND_SOC_RSRC_CARD=y
 CONFIG_SND_SOC_AK4642=y
 CONFIG_SND_SOC_WM8978=y
 CONFIG_USB=y
-- 
1.9.1

