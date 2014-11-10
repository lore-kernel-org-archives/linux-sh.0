From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 10 Nov 2014 18:49:36 +0000
Subject: [PATCH v2 3/6] ARM: shmobile: r8a7779 dtsi: Change to using clock-indices
Message-Id: <1415645379-3366-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1415645379-3366-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415645379-3366-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Turquette <mturquette@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

With the addition of clock-indices in commit 8e33f91a0b84ae19 ("clk:
shmobile: clk-mstp: change to using clock-indices"), we can change the
DTSes to use the generic property instead of the deprecated
vendor-specific property.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
v2:
  - Add Acked-by
---
 arch/arm/boot/dts/r8a7779.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index ede9a29e4bc601ae..e3846af833e1d532 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -475,7 +475,7 @@
 				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7779_CLK_HSPI R8A7779_CLK_TMU2
 				R8A7779_CLK_TMU1 R8A7779_CLK_TMU0
 				R8A7779_CLK_HSCIF1 R8A7779_CLK_HSCIF0
@@ -506,7 +506,7 @@
 				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_S>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7779_CLK_USB01 R8A7779_CLK_USB2
 				R8A7779_CLK_DU R8A7779_CLK_VIN2
 				R8A7779_CLK_VIN1 R8A7779_CLK_VIN0
@@ -527,7 +527,7 @@
 			clocks = <&s4_clk>, <&s4_clk>, <&s4_clk>, <&s4_clk>,
 				 <&s4_clk>, <&s4_clk>;
 			#clock-cells = <1>;
-			renesas,clock-indices = <
+			clock-indices = <
 				R8A7779_CLK_SDHI3 R8A7779_CLK_SDHI2
 				R8A7779_CLK_SDHI1 R8A7779_CLK_SDHI0
 				R8A7779_CLK_MMC1 R8A7779_CLK_MMC0
-- 
1.9.1

