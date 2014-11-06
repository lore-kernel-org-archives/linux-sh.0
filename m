From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 06 Nov 2014 12:48:08 +0000
Subject: [PATCH 1/2] ARM: shmobile: r8a7790: Spelling s/audamc1/audmac1/
Message-Id: <1415278089-1842-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index c7be6b3e5cf215e7..a17f5630bcc22bec 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1114,7 +1114,7 @@
 			#clock-cells = <1>;
 			renesas,clock-indices = <R8A7790_CLK_AUDIO_DMAC0 R8A7790_CLK_AUDIO_DMAC1
 						 R8A7790_CLK_THERMAL R8A7790_CLK_PWM>;
-			clock-output-names = "audmac0", "audamc1", "thermal", "pwm";
+			clock-output-names = "audmac0", "audmac1", "thermal", "pwm";
 		};
 		mstp7_clks: mstp7_clks@e615014c {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
-- 
1.9.1

