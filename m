From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 02 Oct 2015 02:56:12 +0000
Subject: [PATCH v10 06/07] arm64: renesas: add Salvator-X board support on DTS
Message-Id: <20151002025612.28158.43848.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Add initial board support for r8a7795 Salvator-X. At this point
only DEBUG0 and DEBUG1 serial ports are supported.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Changes since V9: (Magnus Damm <damm+renesas@opensource.se>)
 - Added board specific EXTAL information by folding in:
   [PATCH][RFC] arm64: renesas: Add EXTAL configuration to Salvator-X

 Changes since V8: (Magnus Damm <damm+renesas@opensource.se>)
 - None

 Changes since V7: (Magnus Damm <damm+renesas@opensource.se>)
 - Added changelog

 Based on:
  [PATCH 15/25] arm64: renesas: add Salvator-X board support on DTS
  [PATCH 5/5] arm64: renesas: salvator-x: Update SCIF2 pin group
  [PATCH 5/6] arm64: renesas: salvator-x: Enable SCIF1 on serial1

 Documentation/devicetree/bindings/arm/shmobile.txt |    2 
 arch/arm64/boot/dts/renesas/Makefile               |    2 
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   62 ++++++++++++++++++++
 3 files changed, 66 insertions(+)

--- 0008/Documentation/devicetree/bindings/arm/shmobile.txt
+++ work/Documentation/devicetree/bindings/arm/shmobile.txt	2015-10-01 23:00:24.340513000 +0900
@@ -57,5 +57,7 @@ Boards:
     compatible = "renesas,lager", "renesas,r8a7790"
   - Marzen
     compatible = "renesas,marzen", "renesas,r8a7779"
+  - Salvator-X
+    compatible = "renesas,salvator-x", "renesas,r8a7795";
   - Silk
     compatible = "renesas,silk", "renesas,r8a7794";
--- 0008/arch/arm64/boot/dts/renesas/Makefile
+++ work/arch/arm64/boot/dts/renesas/Makefile	2015-10-01 23:00:24.340513000 +0900
@@ -1,2 +1,4 @@
+dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-x.dtb
+
 always		:= $(dtb-y)
 clean-files	:= *.dtb
--- /dev/null
+++ work/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts	2015-10-01 23:00:30.750513000 +0900
@@ -0,0 +1,62 @@
+/*
+ * Device Tree Source for the Salvator-X board
+ *
+ * Copyright (C) 2015 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a7795.dtsi"
+
+/ {
+	model = "Renesas Salvator-X board based on r8a7795";
+	compatible = "renesas,salvator-x", "renesas,r8a7795";
+
+	aliases {
+		serial0 = &scif2;
+		serial1 = &scif1;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = &scif2;
+	};
+
+	memory@48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x38000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <16666666>;
+};
+
+&pfc {
+	scif1_pins: scif1 {
+		renesas,groups = "scif1_data_a", "scif1_ctrl";
+		renesas,function = "scif1";
+	};
+	scif2_pins: scif2 {
+		renesas,groups = "scif2_data_a";
+		renesas,function = "scif2";
+	};
+};
+
+&scif1 {
+	pinctrl-0 = <&scif1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
+
+&scif2 {
+	pinctrl-0 = <&scif2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
