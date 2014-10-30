From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 30 Oct 2014 05:57:57 +0000
Subject: [PATCH 2/2] ARM: shmobile: r8a7790: Fix SD3CKCR address to device tree
Message-Id: <1414648677-31104-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414648677-31104-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1414648677-31104-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 69b7cd0..4242778 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -786,9 +786,9 @@
 			#clock-cells = <0>;
 			clock-output-names = "sd2";
 		};
-		sd3_clk: sd3_clk@e615007c {
+		sd3_clk: sd3_clk@e615026c {
 			compatible = "renesas,r8a7790-div6-clock", "renesas,cpg-div6-clock";
-			reg = <0 0xe615007c 0 4>;
+			reg = <0 0xe615026c 0 4>;
 			clocks = <&pll1_div2_clk>;
 			#clock-cells = <0>;
 			clock-output-names = "sd3";
-- 
2.1.1

