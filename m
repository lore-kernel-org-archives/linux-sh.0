From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon, 07 Apr 2014 20:07:05 +0000
Subject: [PATCH 5/9] ARM: shmobile: add Audio DMAC clocks
Message-Id: <1396901229-29117-6-git-send-email-ben.dooks@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1396901229-29117-1-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1396901229-29117-1-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@lists.codethink.co.uk, dmaengine@vger.kernel.org
Cc: vinod.koul@intel.com, dan.j.williams@intel.com, linux-sh@vger.kernel.org, magnus.damm@opensource.se, horms@verge.net.au, g.liakhovetski@gmx.d, kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org, Ben Dooks <ben.dooks@codethink.co.uk>

Add MSTP5 clock definitions for Audio DMAC

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 arch/arm/boot/dts/r8a7790.dtsi            | 7 ++++---
 include/dt-bindings/clock/r8a7790-clock.h | 2 ++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index a64bdc6..2c8cbbd 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -795,10 +795,11 @@
 		mstp5_clks: mstp5_clks@e6150144 {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
 			reg = <0 0xe6150144 0 4>, <0 0xe615003c 0 4>;
-			clocks = <&extal_clk>, <&p_clk>;
+			clocks = <&hp_clk>, <&hp_clk>, <&extal_clk>, <&p_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <R8A7790_CLK_THERMAL R8A7790_CLK_PWM>;
-			clock-output-names = "thermal", "pwm";
+			renesas,clock-indices = <R8A7790_CLK_AUDIO_DMAC0 R8A7790_CLK_AUDIO_DMAC1
+						 R8A7790_CLK_THERMAL R8A7790_CLK_PWM>;
+			clock-output-names = "audmac0", "audamc1", "thermal", "pwm";
 		};
 		mstp7_clks: mstp7_clks@e615014c {
 			compatible = "renesas,r8a7790-mstp-clocks", "renesas,cpg-mstp-clocks";
diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index 6548a5f..9e74d11 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -63,6 +63,8 @@
 #define R8A7790_CLK_USBDMAC1		31
 
 /* MSTP5 */
+#define R8A7790_CLK_AUDIO_DMAC1		1
+#define R8A7790_CLK_AUDIO_DMAC0		2
 #define R8A7790_CLK_THERMAL		22
 #define R8A7790_CLK_PWM			23
 
-- 
1.9.1

