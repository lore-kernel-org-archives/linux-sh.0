From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 30 Jan 2015 22:52:16 +0000
Subject: [PATCH] ARM: shmobile: silk: initial device tree
Message-Id: <1608366.HtA9yBksdO@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201404250239.39150.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Add the initial device tree for the R8A7794 SoC based SILK low cost board.
SCIF2 serial port support is included, so that the serial console can work.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
This patch is against the 'renesas-devel-20150129-v3.19-rc6' tag of Simon
Horman's 'renesas.git' repo.

 arch/arm/boot/dts/Makefile         |    1 
 arch/arm/boot/dts/r8a7794-silk.dts |   41 +++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

Index: renesas/arch/arm/boot/dts/Makefile
=================================--- renesas.orig/arch/arm/boot/dts/Makefile
+++ renesas/arch/arm/boot/dts/Makefile
@@ -421,6 +421,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += eme
 	r8a7791-koelsch.dtb \
 	r8a7791-porter.dtb \
 	r8a7794-alt.dtb \
+	r8a7794-silk.dtb \
 	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
 	socfpga_arria10_socdk.dtb \
Index: renesas/arch/arm/boot/dts/r8a7794-silk.dts
=================================--- /dev/null
+++ renesas/arch/arm/boot/dts/r8a7794-silk.dts
@@ -0,0 +1,41 @@
+/*
+ * Device Tree Source for the SILK board
+ *
+ * Copyright (C) 2014 Renesas Electronics Corporation
+ * Copyright (C) 2014-2015 Renesas Solutions Corp.
+ * Copyright (C) 2014-2015 Cogent Embedded, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a7794.dtsi"
+
+/ {
+	model = "SILK";
+	compatible = "renesas,silk", "renesas,r8a7794";
+
+	aliases {
+		serial0 = &scif2;
+	};
+
+	chosen {
+		bootargs = "console=ttySC0,38400 ignore_loglevel";
+		stdout-path = &scif2;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x40000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <20000000>;
+};
+
+&scif2 {
+	status = "okay";
+};

