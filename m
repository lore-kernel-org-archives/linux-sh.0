From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 29 Oct 2014 14:30:52 +0000
Subject: [PATCH 2/3] ARM: shmobile: r8a7791 dtsi: Drop bogus 0x unit-address prefix
Message-Id: <1414593053-25627-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1414593053-25627-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1414593053-25627-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 41a636167c0e6a8c..b170693f3314f8b1 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1313,7 +1313,7 @@
 		status = "disabled";
 	};
 
-	rcar_sound: rcar_sound@0xec500000 {
+	rcar_sound: rcar_sound@ec500000 {
 		#sound-dai-cells = <1>;
 		compatible =  "renesas,rcar_sound-r8a7791", "renesas,rcar_sound-gen2", "renesas,rcar_sound";
 		reg =	<0 0xec500000 0 0x1000>, /* SCU */
-- 
1.9.1

