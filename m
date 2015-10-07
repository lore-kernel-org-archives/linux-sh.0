From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 07 Oct 2015 01:57:50 +0000
Subject: [PATCH 13/28] ARM: shmobile: lager: use CCF for audio clock
Message-Id: <6bc651afec2dba4d3e40901a2c5cfc88ad35d97a.1444182812.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1444182812.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1444182812.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Because of historical reason, audio clock didn't use CCF.
Let's use it now.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index 37dec5269491..6f5d7f50d5ca 100644
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
2.1.4

