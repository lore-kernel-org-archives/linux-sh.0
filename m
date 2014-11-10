From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 10 Nov 2014 19:00:41 +0000
Subject: [PATCH 2/5] ARM: shmobile: sh73a0 dtsi: Add SoC-specific FSI2 compatible property
Message-Id: <1415646044-4168-3-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1415646044-4168-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415646044-4168-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: alsa-devel@alsa-project.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The FSI2 sound node used the generic compatible property only.
Add the SoC-specific one, to make it future proof.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/sh73a0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index ccb2b2c54d4711c4..f2f39b9dc8afa25f 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -347,7 +347,7 @@
 
 	sh_fsi2: sound@ec230000 {
 		#sound-dai-cells = <1>;
-		compatible = "renesas,sh_fsi2";
+		compatible = "renesas,fsi2-sh73a0", "renesas,sh_fsi2";
 		reg = <0xec230000 0x400>;
 		interrupts = <0 146 0x4>;
 		status = "disabled";
-- 
1.9.1

