From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 03 Jul 2016 16:46:40 +0000
Subject: [PATCH v5 20/22] sh: IO-DATA HDL-U (a.k.a landisk) DeviceTree
Message-Id: <1467564402-2649-21-git-send-email-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1467564402-2649-1-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>

Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 arch/sh/boot/dts/Makefile    |  2 ++
 arch/sh/boot/dts/landisk.dts | 61 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)
 create mode 100644 arch/sh/boot/dts/landisk.dts

diff --git a/arch/sh/boot/dts/Makefile b/arch/sh/boot/dts/Makefile
index 38fdc38..cf5aec4 100644
--- a/arch/sh/boot/dts/Makefile
+++ b/arch/sh/boot/dts/Makefile
@@ -1,5 +1,7 @@
 obj-$(CONFIG_USE_BUILTIN_DTB) += $(patsubst "%",%,$(CONFIG_BUILTIN_DTB_SOURCE)).dtb.o
 
+dtb-y += landisk.dtb
+
 dtstree		:= $(srctree)/$(src)
 clean-files := *.dtb.S
 always	    := $(dtb-y)
diff --git a/arch/sh/boot/dts/landisk.dts b/arch/sh/boot/dts/landisk.dts
new file mode 100644
index 0000000..3745ae0
--- /dev/null
+++ b/arch/sh/boot/dts/landisk.dts
@@ -0,0 +1,61 @@
+/dts-v1/;
+
+#include "sh7751.dtsi"
+
+/ {
+	model = "iodata,HDL-U";
+	compatible = "iodata,hdl-u";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&shintc>;
+	chosen {
+		stdout-path = "serial1:115200n8";
+	};
+	aliases {
+		serial0 = &sci0;
+		serial1 = &sci1;
+	};
+
+	memory@0c000000 {
+		device_type = "memory";
+		reg = <0x0c000000 0x4000000>;
+	};
+
+	cpldintc: cpld@b0000000 {
+		compatible = "iodata,landisk-intc";
+		#interrupt-cells = <1>;
+		#address-cells = <0>;
+		reg = <0xb0000000 8>;
+		interrupt-map=<0 &shintc evt2irq(0x2a0)>,
+		              <1 &shintc evt2irq(0x2c0)>,
+		              <2 &shintc evt2irq(0x2e0)>,
+			      <3 &shintc evt2irq(0x300)>,
+		              <4 &shintc evt2irq(0x320)>,
+			      <5 &shintc evt2irq(0x340)>,
+		              <6 &shintc evt2irq(0x360)>,
+			      <7 &shintc evt2irq(0x380)>;
+	};
+};
+
+&oclk {
+	clock-frequency = <22222222>;
+};
+
+&sci0 {
+	status = "ok";
+};
+
+&sci1 {
+	status = "ok";
+};
+
+&pci {
+	compatible = "renesas,sh7751-pci", "iodata,landisk-pci";
+	interrupt-map-mask = <0x1800 0 7>;
+	interrupt-map = <0x0000 0 1 &cpldintc 0>,
+	                <0x0800 0 1 &cpldintc 1>,
+	                <0x1000 0 1 &cpldintc 2>,
+	                <0x1000 0 2 &cpldintc 3>,
+	                <0x1000 0 3 &cpldintc 0>;
+	status = "ok";
+};
-- 
2.7.0

