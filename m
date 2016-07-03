From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 03 Jul 2016 16:46:34 +0000
Subject: [PATCH v5 14/22] sh: SH7751 core dtsi
Message-Id: <1467564402-2649-15-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

SH7751 core and internal peripheral define.

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boot/dts/include/dt-bindings               |  1 +
 arch/sh/boot/dts/sh7751.dtsi                       | 83 ++++++++++++++++++++++
 include/dt-bindings/clock/renesas-sh7750.h         | 26 +++++++
 include/dt-bindings/interrupt-controller/sh_intc.h |  2 +
 4 files changed, 112 insertions(+)
 create mode 120000 arch/sh/boot/dts/include/dt-bindings
 create mode 100644 arch/sh/boot/dts/sh7751.dtsi
 create mode 100644 include/dt-bindings/clock/renesas-sh7750.h
 create mode 100644 include/dt-bindings/interrupt-controller/sh_intc.h

diff --git a/arch/sh/boot/dts/include/dt-bindings b/arch/sh/boot/dts/include/dt-bindings
new file mode 120000
index 0000000..08c00e4
--- /dev/null
+++ b/arch/sh/boot/dts/include/dt-bindings
@@ -0,0 +1 @@
+../../../../../include/dt-bindings
\ No newline at end of file
diff --git a/arch/sh/boot/dts/sh7751.dtsi b/arch/sh/boot/dts/sh7751.dtsi
new file mode 100644
index 0000000..713e72e
--- /dev/null
+++ b/arch/sh/boot/dts/sh7751.dtsi
@@ -0,0 +1,83 @@
+/*
+ * Device Tree Source for the SH7751
+ *
+ * Copyright (C) 2016 Yoshinori Sato
+ */
+
+#include <dt-bindings/interrupt-controller/sh_intc.h>
+#include <dt-bindings/clock/renesas-sh7750.h>
+
+/ {
+	oclk: oscillator {
+                #clock-cells = <0>;
+                compatible = "fixed-clock";
+                clock-frequency = <0>;
+        };
+	cpg: clock-controller@ffc00000 {
+                compatible = "renesas,sh7750-cpg";
+                clocks = <&oclk>;
+                #clock-cells = <1>;
+		renesas,mult = <12>;
+                reg = <0xffc00000 32>, <0xfe0a0000 16>;
+        };
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cpu@0 {
+		      compatible = "renesas,sh4", "renesas,sh";
+		      clock-frequency = <266666666>;
+		};
+	};
+	shintc: interrupt-controller@ffd00000 {
+		compatible = "renesas,sh7751-intc";
+		#interrupt-cells = <2>;
+		interrupt-controller;
+		reg = <0xffd00000 14>, <0xfe080000 128>;
+
+	};
+	sci0: serial@ffe00000 {
+		compatible = "renesas,sci";
+		reg = <0xffe00000 0x20>;
+		interrupts = <evt2irq(0x4e0) 0>,
+		             <evt2irq(0x500) 0>,
+		             <evt2irq(0x540) 0>,
+		             <evt2irq(0x520) 0>;
+		clocks = <&cpg SH7750_CLK_SCI>;
+		clock-names = "fck";
+		status = "disabled";
+	};
+	sci1: serial@ffe80000 {
+		compatible = "renesas,scif";
+		reg = <0xffe80000 0x100>;
+		interrupts = <evt2irq(0x700) 0>,
+			     <evt2irq(0x720) 0>,
+			     <evt2irq(0x760) 0>,
+			     <evt2irq(0x740) 0>;
+		clocks = <&cpg SH7750_CLK_SCIF>;
+		clock-names = "fck";
+		status = "disabled";
+	};
+	tmu: timer@ffd80000 {
+		compatible = "renesas,tmu";
+		reg = <0xffd80000 12>;
+		interrupts = <evt2irq(0x400) 0>,
+			     <evt2irq(0x420) 0>,
+			     <evt2irq(0x440) 0>;
+		clocks = <&cpg SH7750_CLK_TMU0>;
+		clock-names = "fck";
+		renesas,channels-mask = <0x03>;
+	};
+	pci: pci-controller@fe200000 {
+		compatible = "renesas,sh7751-pci";
+		device_type = "pci";
+		bus-range = <0 0>;
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges = <0x02000000 0x00000000 0xfd000000 0xfd000000 0x00000000 0x01000000>,
+		         <0x01000000 0x00000000 0xfe240000 0x00000000 0x00000000 0x00040000>;
+		reg = <0xfe200000 0x0400>, <0xff800000 0x0030>;
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0x1800 0 7>;
+		status = "disabled";
+	};
+};
diff --git a/include/dt-bindings/clock/renesas-sh7750.h b/include/dt-bindings/clock/renesas-sh7750.h
new file mode 100644
index 0000000..546c0b1
--- /dev/null
+++ b/include/dt-bindings/clock/renesas-sh7750.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2016 Yoshinori Sato
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef __DT_BINDINGS_CLOCK_RENESAS_SH7750_H__
+#define __DT_BINDINGS_CLOCK_RENESAS_SH7750_H__
+
+#define SH7750_CLK_SCI	0
+#define SH7750_CLK_RTC	1
+#define SH7750_CLK_TMU0	2
+#define SH7750_CLK_TMU1	3
+#define SH7750_CLK_TMU2	4
+#define SH7750_CLK_SCIF	5
+#define SH7750_CLK_DMAC	6
+#define SH7750_CLK_UBC	7
+#define SH7750_CLK_SQ	8
+#define SH7750_CLK_INTC 9
+#define SH7750_CLK_TMU3	10
+#define SH7750_CLK_TMU4	11
+#define SH7750_CLK_PCIC	12
+
+#endif /* __DT_BINDINGS_CLOCK_RENESAS_CPG_MSSR_H__ */
diff --git a/include/dt-bindings/interrupt-controller/sh_intc.h b/include/dt-bindings/interrupt-controller/sh_intc.h
new file mode 100644
index 0000000..8c9dcdc
--- /dev/null
+++ b/include/dt-bindings/interrupt-controller/sh_intc.h
@@ -0,0 +1,2 @@
+#define evt2irq(evt)		(((evt) >> 5) - 16)
+#define irq2evt(irq)		(((irq) + 16) << 5)
-- 
2.7.0

