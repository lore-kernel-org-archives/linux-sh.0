From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 20 Oct 2015 18:49:59 +0000
Subject: [PATCH v5 1/2] clk: shmobile: Add new Renesas CPG/MSSR DT bindings
Message-Id: <1445367000-11525-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1445367000-11525-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1445367000-11525-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: Magnus Damm <damm+renesas@opensource.se>, Simon Horman <horms+renesas@verge.net.au>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

On Renesas ARM SoCs (SH/R-Mobile, R-Car, RZ), the CPG (Clock Pulse
Generator) and MSSR (Module Standby and Software Reset) blocks are
intimately connected, and share the same register block.

Hence it makes sense to describe these two blocks using a
single device node in DT, instead of using a hierarchical structure with
multiple nodes, using a mix of generic and SoC-specific bindings.

These new DT bindings are intended to replace the existing DT bindings
for CPG core clocks ("renesas,*-cpg-clocks", "renesas,cpg-div6-clock")
and module clocks ("renesas,*-mstp-clocks"), at least for new SoCs.

This will make it easier to add module reset support later, which is
currently not implemented, and difficult to achieve using the existing
bindings due to the intertwined register layout.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Michael Turquette <mturquette@baylibre.com>
Reviewed-by: Magnus Damm <damm+renesas@opensource.se>
---
v5:
  - Add Acked-by, Reviewed-by,
  - Drop r8a7791.

v4:
  - No changes,

v3:
  - Integrate CPG and MSSR,

v2:
  - Switch from MSTP to MSSR.

 .../devicetree/bindings/clock/renesas,cpg-mssr.txt | 69 ++++++++++++++++++++++
 include/dt-bindings/clock/renesas-cpg-mssr.h       | 15 +++++
 2 files changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
 create mode 100644 include/dt-bindings/clock/renesas-cpg-mssr.h

diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
new file mode 100644
index 0000000000000000..59297d34b2084429
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mssr.txt
@@ -0,0 +1,69 @@
+* Renesas Clock Pulse Generator / Module Standby and Software Reset
+
+On Renesas ARM SoCs (SH/R-Mobile, R-Car, RZ), the CPG (Clock Pulse Generator)
+and MSSR (Module Standby and Software Reset) blocks are intimately connected,
+and share the same register block.
+
+They provide the following functionalities:
+  - The CPG block generates various core clocks,
+  - The MSSR block provides two functions:
+      1. Module Standby, providing a Clock Domain to control the clock supply
+	 to individual SoC devices,
+      2. Reset Control, to perform a software reset of individual SoC devices.
+
+Required Properties:
+  - compatible: Must be one of:
+      - "renesas,r8a7795-cpg-mssr" for the r8a7795 SoC
+
+  - reg: Base address and length of the memory resource used by the CPG/MSSR
+    block
+
+  - clocks: References to external parent clocks, one entry for each entry in
+    clock-names
+  - clock-names: List of external parent clock names. Valid names are:
+      - "extal" (r8a7795)
+      - "extalr" (r8a7795)
+
+  - #clock-cells: Must be 2
+      - For CPG core clocks, the two clock specifier cells must be "CPG_CORE"
+	and a core clock reference, as defined in
+	<dt-bindings/clock/*-cpg-mssr.h>.
+      - For module clocks, the two clock specifier cells must be "CPG_MOD" and
+	a module number, as defined in the datasheet.
+
+  - #power-domain-cells: Must be 0
+      - SoC devices that are part of the CPG/MSSR Clock Domain and can be
+	power-managed through Module Standby should refer to the CPG device
+	node in their "power-domains" property, as documented by the generic PM
+	Domain bindings in
+	Documentation/devicetree/bindings/power/power_domain.txt.
+
+
+Examples
+--------
+
+  - CPG device node:
+
+	cpg: clock-controller@e6150000 {
+		compatible = "renesas,r8a7795-cpg-mssr";
+		reg = <0 0xe6150000 0 0x1000>;
+		clocks = <&extal_clk>, <&extalr_clk>;
+		clock-names = "extal", "extalr";
+		#clock-cells = <2>;
+		#power-domain-cells = <0>;
+	};
+
+
+  - CPG/MSSR Clock Domain member device node:
+
+	scif2: serial@e6e88000 {
+		compatible = "renesas,scif-r8a7795", "renesas,scif";
+		reg = <0 0xe6e88000 0 64>;
+		interrupts = <GIC_SPI 164 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cpg CPG_MOD 310>;
+		clock-names = "sci_ick";
+		dmas = <&dmac1 0x13>, <&dmac1 0x12>;
+		dma-names = "tx", "rx";
+		power-domains = <&cpg>;
+		status = "disabled";
+	};
diff --git a/include/dt-bindings/clock/renesas-cpg-mssr.h b/include/dt-bindings/clock/renesas-cpg-mssr.h
new file mode 100644
index 0000000000000000..569a3cc33ffb5bc7
--- /dev/null
+++ b/include/dt-bindings/clock/renesas-cpg-mssr.h
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) 2015 Renesas Electronics Corp.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __DT_BINDINGS_CLOCK_RENESAS_CPG_MSSR_H__
+#define __DT_BINDINGS_CLOCK_RENESAS_CPG_MSSR_H__
+
+#define CPG_CORE			0	/* Core Clock */
+#define CPG_MOD				1	/* Module Clock */
+
+#endif /* __DT_BINDINGS_CLOCK_RENESAS_CPG_MSSR_H__ */
-- 
1.9.1

