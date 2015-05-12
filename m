From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 12 May 2015 17:37:11 +0000
Subject: [PATCH/RFC 08/12] ARM: shmobile: koelsch dts: Add overlay for SCIFB1 on EXIO A
Message-Id: <1431452235-11692-9-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Provide access to SCIFB1 on EXIO Connector A.

FIXME SCIFB1 TX works, RX doesn't.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/Makefile                         |  1 +
 .../boot/dts/r8a7791-koelsch-exio-a-scifb1.dtso    | 51 ++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-a-scifb1.dtso

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 576fa500e987ad2b..19e36347aeb302b1 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -674,6 +674,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r8a7791-koelsch-exio-a-hscif1.dtbo \
 	r8a7791-koelsch-exio-a-hscif2.dtbo \
 	r8a7791-koelsch-exio-a-scifb0.dtbo \
+	r8a7791-koelsch-exio-a-scifb1.dtbo \
 endif
 endif
 
diff --git a/arch/arm/boot/dts/r8a7791-koelsch-exio-a-scifb1.dtso b/arch/arm/boot/dts/r8a7791-koelsch-exio-a-scifb1.dtso
new file mode 100644
index 0000000000000000..660a5b87e687f133
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7791-koelsch-exio-a-scifb1.dtso
@@ -0,0 +1,51 @@
+/*
+ * Device Tree Overlay for SCIFB1 on r8a7791/Koelsch EXIO Connector A
+ *
+ * Copyright (C) 2015 Glider bvba
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ * Pinout:
+ *   - RXD = EXIO Connector A pin 72
+ *   - TXD = EXIO Connector A pin 53
+ *   - SCK = EXIO Connector A pin 39
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
+			/* serial13 = &scifb1; */
+			serial13 = "/serial@e6c30000";
+		};
+	};
+
+	fragment@1 {
+		target = <&pfc>;
+
+		__overlay__ {
+			scifb1_pins: serial13 {
+				renesas,groups = "scifb1_data_b",
+						 "scifb1_clk_b";
+				renesas,function = "scifb1";
+			};
+		};
+	};
+
+	fragment@2 {
+		target = <&scifb1>;
+
+		__overlay__ {
+			pinctrl-0 = <&scifb1_pins>;
+			pinctrl-names = "default";
+
+			status = "okay";
+		};
+	};
+};
-- 
1.9.1

