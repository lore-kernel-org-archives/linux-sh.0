From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 06 Nov 2014 12:48:09 +0000
Subject: [PATCH 2/2] ARM: shmobile: r8a7791: Spelling s/audamc1/audmac1/
Message-Id: <1415278089-1842-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 1a586233c856ebe3..142c3ed5fb7a4d68 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1120,7 +1120,7 @@
 			#clock-cells = <1>;
 			renesas,clock-indices = <R8A7791_CLK_AUDIO_DMAC0 R8A7791_CLK_AUDIO_DMAC1
 						 R8A7791_CLK_THERMAL R8A7791_CLK_PWM>;
-			clock-output-names = "audmac0", "audamc1", "thermal", "pwm";
+			clock-output-names = "audmac0", "audmac1", "thermal", "pwm";
 		};
 		mstp7_clks: mstp7_clks@e615014c {
 			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
-- 
1.9.1

