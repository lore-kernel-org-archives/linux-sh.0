From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Aug 2015 09:27:38 +0000
Subject: [PATCH 10/17 v6][RFC] arm64: renesas: add SalvatorX board support on DTS
Message-Id: <878u96b9ei.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Gaku Inami <gaku.inami.xw@bp.renesas.com>

Signed-off-by: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v5 -> v6

 - add Documentation
 - SCIF uses PFC

 Documentation/devicetree/bindings/arm/shmobile.txt |  2 +
 arch/arm64/boot/dts/renesas/Makefile               |  2 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 46 ++++++++++++++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 10e65d8..dbcc007 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -57,5 +57,7 @@ Boards:
     compatible = "renesas,lager", "renesas,r8a7790"
   - Marzen
     compatible = "renesas,marzen", "renesas,r8a7779"
+  - Salvator-X
+    compatible = "renesas,salvator-x", "renesas,r8a7795";
   - Silk
     compatible = "renesas,silk", "renesas,r8a7794";
diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 6aeefd9..dbacc64 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -1,4 +1,4 @@
-dtb-$(CONFIG_ARCH_RCAR_GEN3) ++dtb-$(CONFIG_ARCH_RCAR_GEN3) += r8a7795-salvator-x.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
new file mode 100644
index 0000000..2d5773d
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -0,0 +1,46 @@
+/*
+ * Device Tree Source for the SalvatorX board
+ *
+ * Copyright (C) 2015 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a7795.dtsi"
+
+/ {
+	model = "Renesas SalvatorX board based on r8a7795";
+	compatible = "renesas,salvator-x", "renesas,r8a7795";
+
+	aliases {
+		serial0 = &scif2;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel";
+		stdout-path = &scif2;
+	};
+
+	memory@48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x38000000>;
+	};
+};
+
+&pfc {
+	scif2_pins: scif2 {
+		renesas,groups = "scif2_data";
+		renesas,function = "scif2";
+       };
+};
+
+&scif2 {
+	pinctrl-0 = <&scif2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
-- 
1.9.1

