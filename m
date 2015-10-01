From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 01 Oct 2015 14:37:57 +0000
Subject: [PATCH v8 04/05] clk: shmobile: Add r8a7795 MSSR support
Message-Id: <20151001143757.20618.56442.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
References: <20151001143717.20618.26365.sendpatchset@little-apple>
In-Reply-To: <20151001143717.20618.26365.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-clk@vger.kernel.org
Cc: kuninori.morimoto.gx@renesas.com, gaku.inami.xw@bp.renesas.com, mturquette@baylibre.com, linux-sh@vger.kernel.org, sboyd@codeaurora.org, horms@verge.net.au, geert@linux-m68k.org, laurent.pinchart@ideasonboard.com, Magnus Damm <magnus.damm@gmail.com>

From: Magnus Damm <damm+renesas@opensource.se>

Hook up r8a7795 support to the MSSR driver, enable build
for r8a7795, tie it into the r8a7795 CPG driver and add
DT binding documentation.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V7: (Magnus Damm <damm+renesas@opensource.se>)
 - New patch
 - DT documentation hunks nicked from patch by Geert - thanks!
  [PATCH v7 05/05] clk: shmobile: rcar-gen3: Add CPG/MSTP Clock Domain support

 Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt |   26 +++++++++-
 drivers/clk/shmobile/Makefile                                            |    2 
 drivers/clk/shmobile/clk-mssr.c                                          |    1 
 drivers/clk/shmobile/clk-rcar-gen3.c                                     |    2 
 4 files changed, 28 insertions(+), 3 deletions(-)

--- 0003/Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt
+++ work/Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt	2015-10-01 23:23:59.780513000 +0900
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
--- 0003/drivers/clk/shmobile/Makefile
+++ work/drivers/clk/shmobile/Makefile	2015-10-01 18:52:50.160513000 +0900
@@ -8,5 +8,5 @@ obj-$(CONFIG_ARCH_R8A7790)		+= clk-rcar-
 obj-$(CONFIG_ARCH_R8A7791)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
 obj-$(CONFIG_ARCH_R8A7793)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
 obj-$(CONFIG_ARCH_R8A7794)		+= clk-rcar-gen2.o clk-mstp.o clk-div6.o
-obj-$(CONFIG_ARCH_R8A7795)		+= clk-rcar-gen3.o clk-div6.o
+obj-$(CONFIG_ARCH_R8A7795)		+= clk-rcar-gen3.o clk-mssr.o clk-div6.o
 obj-$(CONFIG_ARCH_SH73A0)		+= clk-sh73a0.o clk-mstp.o clk-div6.o
--- 0004/drivers/clk/shmobile/clk-mssr.c
+++ work/drivers/clk/shmobile/clk-mssr.c	2015-10-01 18:52:50.160513000 +0900
@@ -307,6 +307,7 @@ static void __init cpg_mssr_init(struct
 
 	// TODO Register reset controller
 }
+CLK_OF_DECLARE(cpg_mssr, "renesas,r8a7795-cpg-mssr", cpg_mssr_init);
 
 
 #ifdef CONFIG_PM_GENERIC_DOMAINS_OF
--- 0003/drivers/clk/shmobile/clk-rcar-gen3.c
+++ work/drivers/clk/shmobile/clk-rcar-gen3.c	2015-10-01 18:52:50.160513000 +0900
@@ -237,6 +237,8 @@ static void __init rcar_gen3_cpg_clocks_
 	cpg->data.clk_num = i;
 
 	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
+
+	cpg_mssr_add_clk_domain(np);
 }
 CLK_OF_DECLARE(rcar_gen3_cpg_clks, "renesas,rcar-gen3-cpg-clocks",
 	       rcar_gen3_cpg_clocks_init);
