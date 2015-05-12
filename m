From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 12 May 2015 17:37:14 +0000
Subject: [PATCH/RFC 11/12] ARM: shmobile: koelsch dts: Add overlay for SCIFA5(b) on EXIO C
Message-Id: <1431452235-11692-12-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Provide access to SCIFA5(b) on EXIO Connector C.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/Makefile                         |  1 +
 .../boot/dts/r8a7791-koelsch-exio-c-scifa5-b.dtso  | 60 ++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-c-scifa5-b.dtso

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 655a967b0566a3d1..a5cf8a6daf12ea1a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -677,6 +677,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r8a7791-koelsch-exio-a-scifb1.dtbo \
 	r8a7791-koelsch-exio-c-scif3.dtbo \
 	r8a7791-koelsch-exio-c-scif5.dtbo \
+	r8a7791-koelsch-exio-c-scifa5-b.dtbo \
 endif
 endif
 
diff --git a/arch/arm/boot/dts/r8a7791-koelsch-exio-c-scifa5-b.dtso b/arch/arm/boot/dts/r8a7791-koelsch-exio-c-scifa5-b.dtso
new file mode 100644
index 0000000000000000..f8b7ea5ffc4b7247
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7791-koelsch-exio-c-scifa5-b.dtso
@@ -0,0 +1,60 @@
+/*
+ * Device Tree Overlay for SCIFA5(b) on r8a7791/Koelsch EXIO Connector C
+ *
+ * Copyright (C) 2015 Glider bvba
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ * Pinout:
+ *   - RXD = EXIO Connector C pin 40
+ *   - TXD = EXIO Connector C pin 38
+ *
+ * Notes:
+ *   - As these pins are shared with SDHI0, the latter is disabled first.
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
+			/* serial11 = &scifa5; */
+			serial11 = "/serial@e6c80000";
+		};
+	};
+
+	fragment@1 {
+		target = <&pfc>;
+
+		__overlay__ {
+			scifa5_pins_b: serial11_b {
+				renesas,groups = "scifa5_data_b";
+				renesas,function = "scifa5";
+			};
+		};
+	};
+
+	fragment@2 {
+		target = <&sdhi0>;
+
+		__overlay__ {
+			status = "disabled";
+		};
+	};
+
+	fragment@3 {
+		target = <&scifa5>;
+
+		__overlay__ {
+			pinctrl-0 = <&scifa5_pins_b>;
+			pinctrl-names = "default";
+
+			status = "okay";
+		};
+	};
+};
-- 
1.9.1

