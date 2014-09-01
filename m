From: Xiubo Li <Li.Xiubo@freescale.com>
Date: Mon, 01 Sep 2014 04:29:39 +0000
Subject: [PATCHv1 5/7] ASoC: dts: r8a7740-armadillo800eva-reference: To support simple card newest style.
Message-Id: <1409545781-20530-6-git-send-email-Li.Xiubo@freescale.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1409545781-20530-1-git-send-email-Li.Xiubo@freescale.com>
In-Reply-To: <1409545781-20530-1-git-send-email-Li.Xiubo@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, kuninori.morimoto.gx@renesas.com, moinejf@free.fr, andrew@lunn.ch, jsarha@ti.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, alsa-devel@alsa-project.org, shawn.guo@freescale.com
Cc: linux-kernel@vger.kernel.org, Xiubo Li <Li.Xiubo@freescale.com>

This patch depends on the following simple card patch:
=ASoC: simple-card: Merge single and muti DAI link code.

This patch merge single DAI link and muti-DAI links code together,
and simply the simple-card driver code.

And also do some other improvement:

Since from the DAI format micro SND_SOC_DAIFMT_CBx_CFx, the 'CBx'
mean Codec's bit clock is as master/slave and the 'CFx' mean Codec's
frame clock is as master/slave.

So these same DAI formats should be informed to CPU and CODE DAIs at
the same time. For the Codec driver will set the bit clock and frame
clock as the DAI formats said, but for the CPU driver, if the the
bit clock or frame clock is as Codec master, so it should be set CPU
DAI device as bit clock or frame clock as slave, and vice versa.

The old code will cause confusion, and we should be clear that the
letter 'C' here mean to Codec.
=
Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 .../boot/dts/r8a7740-armadillo800eva-reference.dts  | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index ee9e7d5..b83d95a 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -150,18 +150,19 @@
 	sound {
 		compatible = "simple-audio-card";
 
-		simple-audio-card,format = "i2s";
-
-		simple-audio-card,cpu {
-			sound-dai = <&sh_fsi2 0>;
-			bitclock-inversion;
-		};
-
-		simple-audio-card,codec {
-			sound-dai = <&wm8978>;
+		simple-audio-card,dai-link {
+			format = "i2s";
 			bitclock-master;
 			frame-master;
-			system-clock-frequency = <12288000>;
+
+			cpu {
+				sound-dai = <&sh_fsi2 0>;
+				bitclock-inversion;
+			};
+			codec {
+				sound-dai = <&wm8978>;
+				system-clock-frequency = <12288000>;
+			};
 		};
 	};
 };
-- 
1.8.4

