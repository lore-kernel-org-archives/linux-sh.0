From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 18 Sep 2015 00:47:21 +0000
Subject: [PATCH 19/19] ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain for sound
Message-Id: <2529493c288c109cf734235d1eb3de1b23d9bcef.1442536920.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1442536920.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1442536920.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

797a0626e08c ("ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain")
added CPG/MSTP clock-cells domain support, but it was missing sound
support. This patch adds it.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
[horms: updated commit id referred to in changelog]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 3b8e26dde36d..328f48bd15e7 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1677,6 +1677,7 @@
 				"mix.0", "mix.1",
 				"dvc.0", "dvc.1",
 				"clk_a", "clk_b", "clk_c", "clk_i";
+		power-domains = <&cpg_clocks>;
 
 		status = "disabled";
 
-- 
2.1.4

