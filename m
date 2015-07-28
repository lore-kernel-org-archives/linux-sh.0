From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 28 Jul 2015 07:06:45 +0000
Subject: [PATCH v2] ARM: shmobile: dts: Add common file for AA121TD01 panel
Message-Id: <87vbd4227u.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

The Mitsubishi AA121TD01 panel is commonly used with the Marzen, Lager
and Koelsch boards. Create a .dtsi file that describe the panel and its
connection to the board.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

 - tidyup panel-timing / width / height settings

 arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi

diff --git a/arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi b/arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi
new file mode 100644
index 0000000..a07ebf8
--- /dev/null
+++ b/arch/arm/boot/dts/r8a77xx-aa121td01-panel.dtsi
@@ -0,0 +1,41 @@
+/*
+ * Common file for the AA121TD01 panel connected to Renesas R-Car boards
+ *
+ * Copyright (C) 2015 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/ {
+	panel {
+		compatible = "mitsubishi,aa121td01", "panel-dpi";
+
+		width-mm = <261>;
+		height-mm = <163>;
+
+		panel-timing {
+			/* 1280x800 @60Hz */
+			clock-frequency = <71000000>;
+			hactive = <1280>;
+			vactive = <800>;
+			hsync-len = <70>;
+			hfront-porch = <20>;
+			hback-porch = <70>;
+			vsync-len = <5>;
+			vfront-porch = <3>;
+			vback-porch = <15>;
+		};
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lvds_connector>;
+			};
+		};
+	};
+};
+
+&lvds_connector {
+	remote-endpoint = <&panel_in>;
+};
-- 
1.9.1

