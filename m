From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 24 Aug 2015 16:12:13 +0000
Subject: [PATCH 1/3] clk: shmobile: rcar-gen3: Add CPG/MSTP Clock Domain support
Message-Id: <1440432735-9906-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add Clock Domain support to the R-Car Gen3 Clock Pulse Generator (CPG)
driver using the generic PM Domain.  This allows to power-manage the
module clocks of SoC devices that are part of the CPG/MSTP Clock Domain
using Runtime PM, or for system suspend/resume.

SoC devices that are part of the CPG/MSTP Clock Domain and can be
power-managed through an MSTP clock should be tagged in DT with a proper
"power-domains" property.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.

 .../clock/renesas,rcar-gen3-cpg-clocks.txt         | 26 ++++++++++++++++++++--
 arch/arm64/Kconfig.platforms                       |  1 +
 drivers/clk/shmobile/clk-rcar-gen3.c               |  2 ++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt
index b1a7e01fd042c6ce..a46245b834e0477a 100644
--- a/Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt
+++ b/Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt
@@ -2,6 +2,8 @@
 
 The CPG generates core clocks for the R-Car Gen3 SoCs. It includes three PLLs
 and several fixed ratio dividers.
+The CPG also provides a Clock Domain for SoC devices, in combination with the
+CPG Module Stop (MSTP) Clocks.
 
 Required Properties:
 
@@ -15,10 +17,18 @@ Required Properties:
   - #clock-cells: Must be 1
   - clock-output-names: The names of the clocks. Supported clocks are
     "main", "pll0", "pll1", "pll2", "pll3", "pll4"
+  - #power-domain-cells: Must be 0
 
+SoC devices that are part of the CPG/MSTP Clock Domain and can be power-managed
+through an MSTP clock should refer to the CPG device node in their
+"power-domains" property, as documented by the generic PM domain bindings in
+Documentation/devicetree/bindings/power/power_domain.txt.
 
-Example
--------
+
+Examples
+--------
+
+  - CPG device node:
 
 	cpg_clocks: cpg_clocks@e6150000 {
 		compatible = "renesas,r8a7795-cpg-clocks",
@@ -28,4 +38,16 @@ Example
 		#clock-cells = <1>;
 		clock-output-names = "main", "pll0", "pll1","pll2",
 				     "pll3", "pll4";
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
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 1e9b0c89fdbc3517..8b47d2bac9018873 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -55,6 +55,7 @@ config ARCH_RCAR_GEN3
 	bool "Renesas R-Car Gen3 SoC Platform"
 	select ARCH_SHMOBILE
 	select ARCH_SHMOBILE_MULTI
+	select PM_GENERIC_DOMAINS if PM
 	help
 	  This enables support for Renesas SoC.
 
diff --git a/drivers/clk/shmobile/clk-rcar-gen3.c b/drivers/clk/shmobile/clk-rcar-gen3.c
index 098caac07bdc2727..80c9b1dfff05990d 100644
--- a/drivers/clk/shmobile/clk-rcar-gen3.c
+++ b/drivers/clk/shmobile/clk-rcar-gen3.c
@@ -227,6 +227,8 @@ static void __init rcar_gen3_cpg_clocks_init(struct device_node *np)
 	}
 
 	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
+
+	cpg_mstp_add_clk_domain(np);
 }
 CLK_OF_DECLARE(rcar_gen3_cpg_clks, "renesas,rcar-gen3-cpg-clocks",
 	       rcar_gen3_cpg_clocks_init);
-- 
1.9.1

