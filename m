From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 12 May 2015 17:37:12 +0000
Subject: [PATCH/RFC 09/12] ARM: shmobile: koelsch dts: Add overlay for SCIF3 on EXIO C
Message-Id: <1431452235-11692-10-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Provide access to SCIF3 on EXIO Connector C.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/Makefile                         |  1 +
 .../arm/boot/dts/r8a7791-koelsch-exio-c-scif3.dtso | 60 ++++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-c-scif3.dtso

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 19e36347aeb302b1..ec2abfe19329b791 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -675,6 +675,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r8a7791-koelsch-exio-a-hscif2.dtbo \
 	r8a7791-koelsch-exio-a-scifb0.dtbo \
 	r8a7791-koelsch-exio-a-scifb1.dtbo \
+	r8a7791-koelsch-exio-c-scif3.dtbo \
 endif
 endif
 
diff --git a/arch/arm/boot/dts/r8a7791-koelsch-exio-c-scif3.dtso b/arch/arm/boot/dts/r8a7791-koelsch-exio-c-scif3.dtso
new file mode 100644
index 0000000000000000..3cb5fd138c0997c6
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7791-koelsch-exio-c-scif3.dtso
@@ -0,0 +1,60 @@
+/*
+ * Device Tree Overlay for SCIF3 on r8a7791/Koelsch EXIO Connector C
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
+			/* serial3 = &scif3; */
+			serial3 = "/serial@e6ea8000";
+		};
+	};
+
+	fragment@1 {
+		target = <&pfc>;
+
+		__overlay__ {
+			scif3_pins: serial3 {
+				renesas,groups = "scif3_data_c";
+				renesas,function = "scif3";
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
+		target = <&scif3>;
+
+		__overlay__ {
+			pinctrl-0 = <&scif3_pins>;
+			pinctrl-names = "default";
+
+			status = "okay";
+		};
+	};
+};
-- 
1.9.1

