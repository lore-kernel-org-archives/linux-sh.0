From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 04 Nov 2014 01:50:28 +0000
Subject: [PATCH 05/10] ARM: shmobile: dts: Add common file for AA104XD12 panel
Message-Id: <2610027a48300acc3b98565c7f48b2a48aa6287e.1415058552.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1415058552.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1415058552.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The Mitsubishi AA104XD12 panel is commonly used with the Marzen, Lager
and Koelsch boards. Create a .dtsi file that describe the panel and its
connection to the board.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a77xx-aa104xd12-panel.dtsi | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a77xx-aa104xd12-panel.dtsi

diff --git a/arch/arm/boot/dts/r8a77xx-aa104xd12-panel.dtsi b/arch/arm/boot/dts/r8a77xx-aa104xd12-panel.dtsi
new file mode 100644
index 0000000..65cb50f
--- /dev/null
+++ b/arch/arm/boot/dts/r8a77xx-aa104xd12-panel.dtsi
@@ -0,0 +1,41 @@
+/*
+ * Common file for the AA104XD12 panel connected to Renesas R-Car boards
+ *
+ * Copyright (C) 2014 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/ {
+	panel {
+		compatible = "mitsubishi,aa104xd12", "panel-dpi";
+
+		width-mm = <210>;
+		height-mm = <158>;
+
+		panel-timing {
+			/* 1024x768 @65Hz */
+			clock-frequency = <65000000>;
+			hactive = <1024>;
+			vactive = <768>;
+			hsync-len = <136>;
+			hfront-porch = <20>;
+			hback-porch = <160>;
+			vfront-porch = <3>;
+			vback-porch = <29>;
+			vsync-len = <6>;
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
2.1.1

