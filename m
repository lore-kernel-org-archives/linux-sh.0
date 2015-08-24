From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 24 Aug 2015 02:28:56 +0000
Subject: [PATCH 11/25 v7][RFC] arm64: renesas: r8a7795: add mstp7 node and enable HSUSB clock
Message-Id: <87d1yd7797.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v5 -> v7

 - based on Gen3 v7 patch set

 arch/arm64/boot/dts/renesas/r8a7795.dtsi  | 10 ++++++++++
 include/dt-bindings/clock/r8a7795-clock.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index c3421b3..77cfcea 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -100,6 +100,16 @@
 					renesas,clock-indices = <R8A7795_CLK_SCIF2>;
 					clock-output-names = "scif2";
 				};
+
+				mstp7_clks: mstp7_clks@e615014c {
+					compatible = "renesas,r8a7795-mstp-clocks",
+						     "renesas,cpg-mstp-clocks";
+					reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
+					clocks =  <&s3d4_clk>;
+					#clock-cells = <1>;
+					renesas,clock-indices = <R8A7795_CLK_HSUSB>;
+					clock-output-names = "hsusb";
+				};
 			};
 		};
 
diff --git a/include/dt-bindings/clock/r8a7795-clock.h b/include/dt-bindings/clock/r8a7795-clock.h
index 27b3a29..ffb0b5b 100644
--- a/include/dt-bindings/clock/r8a7795-clock.h
+++ b/include/dt-bindings/clock/r8a7795-clock.h
@@ -29,6 +29,7 @@
 /* MSTP5 */
 
 /* MSTP7 */
+#define R8A7795_CLK_HSUSB		4
 
 /* MSTP8 */
 
-- 
1.9.1

