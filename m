From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 07 Sep 2015 16:33:46 +0000
Subject: [PATCH v7 05/05] clk: shmobile: rcar-gen3: Add CPG/MSTP Clock Domain support
Message-Id: <20150907163346.475.69916.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20150907163252.475.18281.sendpatchset@little-apple>
In-Reply-To: <20150907163252.475.18281.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: kuninori.morimoto.gx@renesas.com, linux-sh@vger.kernel.org, mturquette@baylibre.com, gaku.inami.xw@bp.renesas.com, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add Clock Domain support to the R-Car Gen3 Clock Pulse Generator (CPG)
driver using the generic PM Domain.  This allows to power-manage the
module clocks of SoC devices that are part of the CPG/MSTP Clock Domain
using Runtime PM, or for system suspend/resume.

SoC devices that are part of the CPG/MSTP Clock Domain and can be
power-managed through an MSTP clock should be tagged in DT with a proper
"power-domains" property.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V6:
 - None

 Changes since V5:
 - Rebased to fit on top of updated CPG DT binding document

 Changes since V4:
 - Rebased to fit on top of updated CPG DT binding document

 Changes since V3:
 - Fixed so correct file is actually used. =)
 - Took V2 from Geert but filtered out Kconfig.platforms bits

 Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt |   26 +++++++++-
 drivers/clk/shmobile/clk-rcar-gen3.c                                     |    2 
 2 files changed, 26 insertions(+), 2 deletions(-)

--- 0009/Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt
+++ work/Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt	2015-09-02 14:41:32.942366518 +0900
@@ -2,6 +2,8 @@
 
 The CPG generates core clocks for the R-Car Gen3 SoCs. It includes three PLLs
 and several fixed ratio dividers.
+The CPG also provides a Clock Domain for SoC devices, in combination with the
+CPG Module Stop (MSTP) Clocks.
 
 Required Properties:
 
@@ -14,9 +16,17 @@ Required Properties:
   - clocks: References to the parent clocks: first to the EXTAL clock
   - #clock-cells: Must be 1
   - clock-indices: Indices of the exported clocks
+  - #power-domain-cells: Must be 0
 
-Example
--------
+SoC devices that are part of the CPG/MSTP Clock Domain and can be power-managed
+through an MSTP clock should refer to the CPG device node in their
+"power-domains" property, as documented by the generic PM domain bindings in
+Documentation/devicetree/bindings/power/power_domain.txt.
+
+Examples
+--------
+
+  - CPG device node:
 
 	cpg_clocks: cpg_clocks@e6150000 {
 		compatible = "renesas,r8a7795-cpg-clocks",
@@ -29,4 +39,16 @@ Example
 				R8A7795_CLK_PLL1 R8A7795_CLK_PLL2
 				R8A7795_CLK_PLL3 R8A7795_CLK_PLL4
 		>;
+		#power-domain-cells = <0>;
+	};
+
+  - CPG/MSTP Clock Domain member device node:
+
+	scif2: serial@e6e88000 {
+		compatible = "renesas,scif-r8a7795", "renesas,scif";
+		reg = <0 0xe6e88000 0 64>;
+		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp3_clks RCAR_R8A7795_CLK_SCIF2>;
+		clock-names = "sci_ick";
+		power-domains = <&cpg_clocks>;
 	};
--- 0009/drivers/clk/shmobile/clk-rcar-gen3.c
+++ work/drivers/clk/shmobile/clk-rcar-gen3.c	2015-09-02 14:39:35.912366518 +0900
@@ -236,6 +236,8 @@ static void __init rcar_gen3_cpg_clocks_
 	}
 
 	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
+
+	cpg_mstp_add_clk_domain(np);
 }
 CLK_OF_DECLARE(rcar_gen3_cpg_clks, "renesas,rcar-gen3-cpg-clocks",
 	       rcar_gen3_cpg_clocks_init);
