From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 12 May 2015 17:37:09 +0000
Subject: [PATCH/RFC 06/12] ARM: shmobile: koelsch dts: Add overlay for HSCIF2 on EXIO A
Message-Id: <1431452235-11692-7-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1431452235-11692-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1431452235-11692-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>

Provide access to HSCIF2 on EXIO Connector A.

FIXME Document "ctsrts" DT property.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/Makefile                         |  1 +
 .../boot/dts/r8a7791-koelsch-exio-a-hscif2.dtso    | 53 ++++++++++++++++++++++
 2 files changed, 54 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7791-koelsch-exio-a-hscif2.dtso

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index d800690e3aaf7bab..d5d2386694d57391 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -672,6 +672,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r8a7740-armadillo800eva-con15-scifa0.dtbo \
 	r8a7740-armadillo800eva-con15-scifb.dtbo \
 	r8a7791-koelsch-exio-a-hscif1.dtbo \
+	r8a7791-koelsch-exio-a-hscif2.dtbo \
 endif
 endif
 
diff --git a/arch/arm/boot/dts/r8a7791-koelsch-exio-a-hscif2.dtso b/arch/arm/boot/dts/r8a7791-koelsch-exio-a-hscif2.dtso
new file mode 100644
index 0000000000000000..7570096b0377fc89
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7791-koelsch-exio-a-hscif2.dtso
@@ -0,0 +1,53 @@
+/*
+ * Device Tree Overlay for HSCIF2 on r8a7791/Koelsch EXIO Connector A
+ *
+ * Copyright (C) 2015 Glider bvba
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ *
+ * Pinout:
+ *   - RXD = EXIO Connector A pin 66
+ *   - TXD = EXIO Connector A pin 62
+ *   - CTS = EXIO Connector A pin 60
+ *   - RTS = EXIO Connector A pin 65
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
+			/* serial17 = &hscif2; */
+			serial17 = "/serial@e62d0000";
+		};
+	};
+
+	fragment@1 {
+		target = <&pfc>;
+
+		__overlay__ {
+			hscif2_pins: serial17 {
+				renesas,groups = "hscif2_data_b",
+						 "hscif2_ctrl_b";
+				renesas,function = "hscif2";
+			};
+		};
+	};
+
+	fragment@2 {
+		target = <&hscif2>;
+
+		__overlay__ {
+			pinctrl-0 = <&hscif2_pins>;
+			pinctrl-names = "default";
+
+			ctsrts;
+			status = "okay";
+		};
+	};
+};
-- 
1.9.1

