From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 12 May 2015 17:37:10 +0000
Subject: [PATCH/RFC 07/12] ARM: shmobile: koelsch dts: Add overlay for SCIFB0 on EXIO A
Message-Id: <1431452235-11692-8-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Provide access to SCIFB0 on EXIO Connector A.

FIXME Document "ctsrts" DT property.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/Makefile                         |  1 +
 .../boot/dts/r8a7791-koelsch-exio-a-scifb0.dtso    | 53 ++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-a-scifb0.dtso

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d5d2386694d57391..576fa500e987ad2b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -673,6 +673,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r8a7740-armadillo800eva-con15-scifb.dtbo \
 	r8a7791-koelsch-exio-a-hscif1.dtbo \
 	r8a7791-koelsch-exio-a-hscif2.dtbo \
+	r8a7791-koelsch-exio-a-scifb0.dtbo \
 endif
 endif
 
diff --git a/arch/arm/boot/dts/r8a7791-koelsch-exio-a-scifb0.dtso b/arch/arm/boot/dts/r8a7791-koelsch-exio-a-scifb0.dtso
new file mode 100644
index 0000000000000000..30b83c5d36b4fbe6
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7791-koelsch-exio-a-scifb0.dtso
@@ -0,0 +1,53 @@
+/*
+ * Device Tree Overlay for SCIFB0 on r8a7791/Koelsch EXIO Connector A
+ *
+ * Copyright (C) 2015 Glider bvba
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ * Pinout:
+ *   - RXD = EXIO Connector A pin 66
+ *   - TXD = EXIO Connector A pin 60
+ *   - CTS = EXIO Connector A pin 65
+ *   - RTS = EXIO Connector A pin 62
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
+			/* serial12 = &scifb0; */
+			serial12 = "/serial@e6c20000";
+		};
+	};
+
+	fragment@1 {
+		target = <&pfc>;
+
+		__overlay__ {
+			scifb0_pins: serial12 {
+				renesas,groups = "scifb0_data_b",
+						 "scifb0_ctrl_b";
+				renesas,function = "scifb0";
+			};
+		};
+	};
+
+	fragment@2 {
+		target = <&scifb0>;
+
+		__overlay__ {
+			pinctrl-0 = <&scifb0_pins>;
+			pinctrl-names = "default";
+
+			ctsrts;
+			status = "okay";
+		};
+	};
+};
-- 
1.9.1

