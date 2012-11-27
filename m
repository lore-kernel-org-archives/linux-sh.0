From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 27 Nov 2012 00:03:14 +0000
Subject: [PATCH v2 75/77] ARM: shmobile: kzm9g: Add pin control device in device tree
Message-Id: <1353974596-30033-76-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a pfc node in the sh73a0 device tree and include it in kzm9g.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts |    2 +-
 arch/arm/boot/dts/sh73a0.dtsi      |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/sh73a0.dtsi

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index bcb9119..7b37901 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -9,7 +9,7 @@
  */
 
 /dts-v1/;
-/include/ "skeleton.dtsi"
+/include/ "sh73a0.dtsi"
 
 / {
 	model = "KZM-A9-GT";
diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
new file mode 100644
index 0000000..6b374ff
--- /dev/null
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -0,0 +1,32 @@
+/*
+ * Device Tree Source for the SH73A0 SoC
+ *
+ * Copyright (C) 2012 Renesas Solutions Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/include/ "skeleton.dtsi"
+
+/ {
+	compatible = "renesas,sh73a0";
+
+	cpus {
+		cpu@0 {
+			compatible = "arm,cortex-a9";
+		};
+		cpu@1 {
+			compatible = "arm,cortex-a9";
+		};
+	};
+
+	gpio: pfc@e6050000 {
+		compatible = "renesas,pfc-sh73a0";
+		reg = <0xe6050000 0x8000>,
+		      <0xe605801c 0x1c>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
-- 
1.7.8.6

