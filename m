From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Aug 2015 03:09:52 +0000
Subject: [PATCH] ARM: shmobile: lager: use CCF for audio clock
Message-Id: <87614ad5gc.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Because of historical reason, audio clock didn't use CCF.
Let's use it now.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 37dec52..6f5d7f5 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -174,6 +174,13 @@
 			  1800000 0>;
 	};
 
+	audio_clock: clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <11289600>;
+		clock-output-names = "audio_clock";
+	};
+
 	rsnd_ak4643: sound {
 		compatible = "simple-audio-card";
 
@@ -187,7 +194,7 @@
 
 		sndcodec: simple-audio-card,codec {
 			sound-dai = <&ak4643>;
-			system-clock-frequency = <11289600>;
+			clocks = <&audio_clock>;
 		};
 	};
 
-- 
1.9.1

