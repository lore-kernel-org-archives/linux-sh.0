From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 07 Aug 2015 03:20:02 +0000
Subject: [PATCH 16/16 v5][RFC] Local: arm64: renesas: add SalvatorX board support on DTS
Message-Id: <87lhdndbz9.wl%kuninori.morimoto.gx@renesas.com>
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
v4 -> v5

 - modify bootargs

 arch/arm64/boot/dts/renesas/Makefile              |  2 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts | 36 +++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 6aeefd9..255c957 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -1,4 +1,4 @@
-dtb-$(CONFIG_ARCH_RCAR_GEN3) ++dtb-$(CONFIG_ARCH_RCAR_GEN3) += r8a7795-salvatorx.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts
new file mode 100644
index 0000000..1b00390
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts
@@ -0,0 +1,36 @@
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
+	compatible = "renesas,salvatorx", "renesas,r8a7795";
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
+&scif2 {
+	status = "okay";
+};
-- 
1.9.1

