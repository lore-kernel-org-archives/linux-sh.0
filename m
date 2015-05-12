From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 12 May 2015 17:37:07 +0000
Subject: [PATCH/RFC 04/12] ARM: shmobile: armadillo dts: Add overlay for SCIFB on CON15
Message-Id: <1431452235-11692-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Provide access to SCIFB on the Expansion Interface Connector (CON15), as
documented in Table 18.15 of the "Armadillo-800 EVA Product Manual".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/Makefile                         |  1 +
 .../dts/r8a7740-armadillo800eva-con15-scifb.dtso   | 52 ++++++++++++++++++++++
 2 files changed, 53 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7740-armadillo800eva-con15-scifb.dtso

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5366e2112ad1ea18..1f2478d6254ea70f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -670,6 +670,7 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 ifeq ($(CONFIG_OF_OVERLAY),y)
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r8a7740-armadillo800eva-con15-scifa0.dtbo \
+	r8a7740-armadillo800eva-con15-scifb.dtbo \
 endif
 endif
 
diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-con15-scifb.dtso b/arch/arm/boot/dts/r8a7740-armadillo800eva-con15-scifb.dtso
new file mode 100644
index 0000000000000000..34e46580e09565a9
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-con15-scifb.dtso
@@ -0,0 +1,52 @@
+/*
+ * Device Tree Overlay for SCIFB on r8a7740/Armadillo-800 EVA Expansion
+ * Interface Connector
+ *
+ * Copyright (C) 2015 Glider bvba
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ * Pinout:
+ *   - RXD = CON15 pin 41
+ *   - TXD = CON15 pin 40
+ *   - SCK = CON15 pin 42
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
+			/* serial8 = &scifb; */
+			serial8 = "/serial@e6c30000";
+		};
+	};
+
+	fragment@1 {
+		target = <&pfc>;
+
+		__overlay__ {
+			scifb_pins: serial8 {
+				renesas,groups = "scifb_data_0";
+				renesas,function = "scifb";
+			};
+		};
+	};
+
+	fragment@2 {
+		target = <&scifb>;
+
+		__overlay__ {
+			pinctrl-0 = <&scifb_pins>;
+			pinctrl-names = "default";
+
+			ctsrts;
+			status = "okay";
+		};
+	};
+};
-- 
1.9.1

