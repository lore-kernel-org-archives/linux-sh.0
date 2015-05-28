From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Date: Thu, 28 May 2015 15:15:56 +0000
Subject: [PATCH v4 3/4] ARM: shmobile: r8a7793: add minimal Gose board device tree
Message-Id: <1432826157-6414-4-git-send-email-ulrich.hecht+renesas@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1432826157-6414-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1432826157-6414-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: horms@verge.net.au, linux-sh@vger.kernel.org
Cc: magnus.damm@gmail.com, laurent.pinchart+renesas@ideasonboard.com, geert@linux-m68k.org, kuninori.morimoto.gx@renesas.com, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, devicetree@vger.kernel.org

Minmal DT description and Makefile entry for the Gose eval board.
Support for console, timer, and Ethernet.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: devicetree@vger.kernel.org
---
 arch/arm/boot/dts/Makefile         |  1 +
 arch/arm/boot/dts/r8a7793-gose.dts | 63 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7793-gose.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 86217db..03d876f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -492,6 +492,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r8a7790-lager.dtb \
 	r8a7791-henninger.dtb \
 	r8a7791-koelsch.dtb \
+	r8a7793-gose.dtb \
 	r8a7794-alt.dtb \
 	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += \
diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
new file mode 100644
index 0000000..96443ec
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -0,0 +1,63 @@
+/*
+ * Device Tree Source for the Gose board
+ *
+ * Copyright (C) 2014-2015 Renesas Electronics Corporation
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a7793.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Gose";
+	compatible = "renesas,gose", "renesas,r8a7793";
+
+	aliases {
+		serial0 = &scif0;
+		serial1 = &scif1;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		stdout-path = &scif0;
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
+&ether {
+	phy-handle = <&phy1>;
+	renesas,ether-link-active-low;
+	status = "okay";
+
+	phy1: ethernet-phy@1 {
+		reg = <1>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		micrel,led-mode = <1>;
+	};
+};
+
+&cmt0 {
+	status = "okay";
+};
+
+&scif0 {
+	status = "okay";
+};
+
+&scif1 {
+	status = "okay";
+};
-- 
2.3.5

