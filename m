From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 02 Oct 2014 18:42:29 +0000
Subject: [PATCH] ARM: shmobile: r8a7740 dtsi: Fix clock index for scifa2
Message-Id: <1412275349-21118-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The clocks property for the scifa2 device node referred to the scifa0
clock index instead of the scifa2 clock index.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7740.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 502483f4dccb2f45..559bd39e778bddaf 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -197,7 +197,7 @@
 		compatible = "renesas,scifa-r8a7740", "renesas,scifa";
 		reg = <0xe6c60000 0x100>;
 		interrupts = <0 102 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&mstp2_clks R8A7740_CLK_SCIFA0>;
+		clocks = <&mstp2_clks R8A7740_CLK_SCIFA2>;
 		clock-names = "sci_ick";
 		status = "disabled";
 	};
-- 
1.9.1

