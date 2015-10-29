From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 29 Oct 2015 23:27:52 +0000
Subject: [PATCH v5 06/14] arm64: renesas: r8a7795: Sound CTU/MIX support
Message-Id: <1446161280-23097-7-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1446161280-23097-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1446161280-23097-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---

v5 [Simon Horman]
* Update for new CPG/MSSR bindings via Geert Uytterhoeven
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 03690b12f44b..774bdf84709a 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -375,6 +375,8 @@
 				 <&cpg CPG_MOD 1026>, <&cpg CPG_MOD 1027>,
 				 <&cpg CPG_MOD 1028>, <&cpg CPG_MOD 1029>,
 				 <&cpg CPG_MOD 1030>, <&cpg CPG_MOD 1031>,
+				 <&cpg CPG_MOD 1021>, <&cpg CPG_MOD 1020>,
+				 <&cpg CPG_MOD 1021>, <&cpg CPG_MOD 1020>,
 				 <&cpg CPG_MOD 1019>, <&cpg CPG_MOD 1018>,
 				 <&audio_clk_a>, <&audio_clk_b>,
 				 <&audio_clk_c>,
@@ -386,6 +388,8 @@
 				      "src.9", "src.8", "src.7", "src.6",
 				      "src.5", "src.4", "src.3", "src.2",
 				      "src.1", "src.0",
+				      "ctu.0", "ctu.1",
+				      "mix.0", "mix.1",
 				      "dvc.0", "dvc.1",
 				      "clk_a", "clk_b", "clk_c", "clk_i";
 			power-domains = <&cpg>;
@@ -402,6 +406,22 @@
 				};
 			};
 
+			rcar_sound,mix {
+				mix0: mix@0 { };
+				mix1: mix@1 { };
+			};
+
+			rcar_sound,ctu {
+				ctu00: ctu@0 { };
+				ctu01: ctu@1 { };
+				ctu02: ctu@2 { };
+				ctu03: ctu@3 { };
+				ctu10: ctu@4 { };
+				ctu11: ctu@5 { };
+				ctu12: ctu@6 { };
+				ctu13: ctu@7 { };
+			};
+
 			rcar_sound,src {
 				src0: src@0 {
 					interrupts = <0 352 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.1.4

