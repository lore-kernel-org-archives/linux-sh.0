From: Simon Horman <horms@verge.net.au>
Date: Fri, 28 Aug 2015 00:52:34 +0000
Subject: Re: [PATCH/RFC 01/10] arm64: dts: r8a7795: add GPIO nodes
Message-Id: <20150828005234.GA591@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 28, 2015 at 09:20:53AM +0900, Simon Horman wrote:
> On Thu, Aug 27, 2015 at 12:16:46PM +0200, Ulrich Hecht wrote:
> > Thanks for the patch.
> 
> You are welcome.
> 
> I'll update my local copy with your suggestions regarding clocks.
> I plan to replace that with a version you post whenever that occurs.

For reference this is what I now have.
Light testing indicates that the driver is initialised correctly,
though that was also the case before when the clocks were wrong.

From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Subject: [PATCH] arm64: dts: r8a7795: add GPIO clocks

Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
[horms: moved into clock node; removed non-clock nodes; updated changelog;
        used R8A7795 as prefix for clock defines]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 27 +++++++++++++++++++++++++++
 include/dt-bindings/clock/r8a7795-clock.h |  8 ++++++++
 2 files changed, 35 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 5ee10c375190..9fba8be62025 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -70,6 +70,14 @@
 			#clock-cells = <1>;
 			ranges;
 
+			cp_clk: cp_clk {
+				compatible = "fixed-factor-clock";
+				clocks = <&extal_clk>;
+				#clock-cells = <0>;
+				clock-div = <2>;
+				clock-mult = <1>;
+			};
+
 			s3d4_clk: s3d4 {
 				compatible = "fixed-factor-clock";
 				clocks = <&cpg_clocks R8A7795_CLK_PLL1>;
@@ -114,6 +122,25 @@
 								 R8A7795_CLK_EHCI2>;
 					clock-output-names = "hsusb", "ehci0", "ehci1", "ehci2";
 				};
+
+				mstp9_clks: mstp9_clks@e6150994 {
+					compatible = "renesas,r8a7795-mstp-clocks",
+						     "renesas,cpg-mstp-clocks";
+					reg = <0 0xe6150994 0 4>, <0 0xe61509a4 0 4>;
+					clocks = <&cp_clk>, <&cp_clk>, <&cp_clk>,
+						 <&cp_clk>, <&cp_clk>, <&cp_clk>,
+						 <&cp_clk>, <&cp_clk>;
+					#clock-cells = <1>;
+					clock-indices = <
+						R8A7795_CLK_GPIO7 R8A7795_CLK_GPIO6
+						R8A7795_CLK_GPIO5 R8A7795_CLK_GPIO4
+						R8A7795_CLK_GPIO3 R8A7795_CLK_GPIO2
+						R8A7795_CLK_GPIO1 R8A7795_CLK_GPIO0
+					>;
+					clock-output-names +						"gpio7", "gpio6", "gpio5", "gpio4",
+						"gpio3", "gpio2", "gpio1", "gpio0";
+				};
 			};
 		};
 
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index 2bd9d934e341..5ca06876902f 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -37,6 +37,14 @@
 /* MSTP8 */
 
 /* MSTP9 */
+#define R8A7795_CLK_GPIO0		12
+#define R8A7795_CLK_GPIO1		11
+#define R8A7795_CLK_GPIO2		10
+#define R8A7795_CLK_GPIO3		9
+#define R8A7795_CLK_GPIO4		8
+#define R8A7795_CLK_GPIO5		7
+#define R8A7795_CLK_GPIO6		6
+#define R8A7795_CLK_GPIO7		5
 
 /* MSTP10 */
 
-- 
2.1.4

