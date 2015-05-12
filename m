From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 12 May 2015 17:37:08 +0000
Subject: [PATCH/RFC 05/12] ARM: shmobile: koelsch dts: Add overlay for HSCIF1 on EXIO A
Message-Id: <1431452235-11692-6-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Pantelis Antoniou <pantelis.antoniou@konsulko.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Provide access to HSCIF1 on EXIO Connector A.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/Makefile                         |  1 +
 .../boot/dts/r8a7791-koelsch-exio-a-hscif1.dtso    | 49 ++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-a-hscif1.dtso

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 1f2478d6254ea70f..d800690e3aaf7bab 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -671,6 +671,7 @@ ifeq ($(CONFIG_OF_OVERLAY),y)
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r8a7740-armadillo800eva-con15-scifa0.dtbo \
 	r8a7740-armadillo800eva-con15-scifb.dtbo \
+	r8a7791-koelsch-exio-a-hscif1.dtbo \
 endif
 endif
 
diff --git a/arch/arm/boot/dts/r8a7791-koelsch-exio-a-hscif1.dtso b/arch/arm/boot/dts/r8a7791-koelsch-exio-a-hscif1.dtso
new file mode 100644
index 0000000000000000..03793154b6fa2cb1
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7791-koelsch-exio-a-hscif1.dtso
@@ -0,0 +1,49 @@
+/*
+ * Device Tree Overlay for HSCIF1 on r8a7791/Koelsch EXIO Connector A
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
+			/* serial16 = &hscif1; */
+			serial16 = "/serial@e62c8000";
+		};
+	};
+
+	fragment@1 {
+		target = <&pfc>;
+
+		__overlay__ {
+			hscif1_pins: serial16 {
+				renesas,groups = "hscif1_data_b";
+				renesas,function = "hscif1";
+			};
+		};
+	};
+
+	fragment@2 {
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

