From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 26 Aug 2015 18:13:52 +0000
Subject: [PATCH 6/6] [POC] arm64: renesas: salvator-x dts: Add overlay for HSCIF1
Message-Id: <1440612832-17627-7-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On r8a7795/Salvator-X, both SCIF1 and HSCIF1 can be routed to the "DEBUG
SERIAL-1" connector. The standard DTS provides access to SCIF1.

Add an overlay to use HSCIF1 instead.

Not-yet-signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is a proof-of-concept, which depends on:
  - https://github.com/pantoniou/linux-beagle-track-mainline.git#bbb-overlays,
  - kbuild: Create a rule for building device tree overlay objects
    (https://lkml.org/lkml/2015/5/12/343),
  - Passing -@ to dtc,
  - [RFC] of/dynamic: Update list of aliases on aliases changes.
---
 arch/arm64/boot/dts/renesas/Makefile               |  5 ++
 .../dts/renesas/r8a7795-salvator-x-hscif1.dtso     | 57 ++++++++++++++++++++++
 2 files changed, 62 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-salvator-x-hscif1.dtso

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index dbacc64e3c10fcd7..a880e3f07c850b6f 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -1,5 +1,10 @@
 dtb-$(CONFIG_ARCH_RCAR_GEN3) += r8a7795-salvator-x.dtb
 
+ifeq ($(CONFIG_OF_OVERLAY),y)
+dtb-$(CONFIG_ARCH_RCAR_GEN3) += \
+	r8a7795-salvator-x-hscif1.dtbo
+endif
+
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
 clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x-hscif1.dtso b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x-hscif1.dtso
new file mode 100644
index 0000000000000000..da833c6406ae3390
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x-hscif1.dtso
@@ -0,0 +1,57 @@
+/*
+ * Device Tree Overlay for HSCIF1 on r8a7795/Salvator-X Debug Serial 1
+ *
+ * Copyright (C) 2015 Glider bvba
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ * Notes:
+ *   - As these pins are shared with SCIF1, the latter is disabled first.
+ */
+
+/dts-v1/;
+/plugin/;
+
+/ {
+	fragment@0 {
+		target-path = "/aliases";
+
+		__overlay__ {
+			/* serial1 = &hscif1; */
+			serial1 = "/soc/serial@e6550000";
+		};
+	};
+
+	fragment@1 {
+		target = <&pfc>;
+
+		__overlay__ {
+			hscif1_pins: hscif1 {
+				renesas,groups = "hscif1_data_a",
+						 "hscif1_ctrl_a";
+				renesas,function = "hscif1";
+			};
+		};
+	};
+
+	fragment@2 {
+		target = <&scif1>;
+
+		__overlay__ {
+			status = "disabled";
+		};
+	};
+
+	fragment@3 {
+		target = <&hscif1>;
+
+		__overlay__ {
+			pinctrl-0 = <&hscif1_pins>;
+			pinctrl-names = "default";
+
+			status = "okay";
+		};
+	};
+};
-- 
1.9.1

