From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 12 May 2015 17:37:06 +0000
Subject: [PATCH/RFC 03/12] ARM: shmobile: armadillo dts: Add overlay for SCIFA0 on CON15
Message-Id: <1431452235-11692-4-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Provide access to SCIFA0 on the Expansion Interface Connector (CON15),
as documented in Table 18.15 of the "Armadillo-800 EVA Product Manual".

FIXME Document "ctsrts" DT property.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/Makefile                         |  5 ++
 .../dts/r8a7740-armadillo800eva-con15-scifa0.dtso  | 53 ++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7740-armadillo800eva-con15-scifa0.dtso

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 93be426297370a2c..5366e2112ad1ea18 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -666,6 +666,11 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += \
 	mt6592-evb.dtb \
 	mt8127-moose.dtb \
 	mt8135-evbp1.dtb
+
+ifeq ($(CONFIG_OF_OVERLAY),y)
+dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
+	r8a7740-armadillo800eva-con15-scifa0.dtbo \
+endif
 endif
 
 always		:= $(dtb-y)
diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-con15-scifa0.dtso b/arch/arm/boot/dts/r8a7740-armadillo800eva-con15-scifa0.dtso
new file mode 100644
index 0000000000000000..4a7d89ddf61d3dc2
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-con15-scifa0.dtso
@@ -0,0 +1,53 @@
+/*
+ * Device Tree Overlay for SCIFA0 on r8a7740/Armadillo-800 EVA Expansion
+ * Interface Connector
+ *
+ * Copyright (C) 2015 Glider bvba
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ * Pinout:
+ *   - RXD = CON15 pin 23
+ *   - TXD = CON15 pin 25
+ *   - CTS = CON15 pin 35
+ *   - RTS = CON15 pin 34
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
+			/* serial0 = &scifa0; */
+			serial0 = "/serial@e6c40000";
+		};
+	};
+
+	fragment@1 {
+		target = <&pfc>;
+
+		__overlay__ {
+			scifa0_pins: serial0 {
+				renesas,groups = "scifa0_data", "scifa0_ctrl";
+				renesas,function = "scifa0";
+			};
+		};
+	};
+
+	fragment@2 {
+		target = <&scifa0>;
+
+		__overlay__ {
+			pinctrl-0 = <&scifa0_pins>;
+			pinctrl-names = "default";
+
+			ctsrts;
+			status = "okay";
+		};
+	};
+};
-- 
1.9.1

