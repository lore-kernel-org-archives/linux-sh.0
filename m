From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sun, 03 Jul 2016 16:46:42 +0000
Subject: [PATCH v5 22/22] sh: Renesas RTS7751R2Dplus (a,k.a R2Dplus) DeviceTree
Message-Id: <1467564402-2649-23-git-send-email-ysato@users.sourceforge.jp>
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
 arch/sh/boot/dts/Makefile    |  1 +
 arch/sh/boot/dts/r2dplus.dts | 85 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)
 create mode 100644 arch/sh/boot/dts/r2dplus.dts

diff --git a/arch/sh/boot/dts/Makefile b/arch/sh/boot/dts/Makefile
index cf5aec4..e059ce2b 100644
--- a/arch/sh/boot/dts/Makefile
+++ b/arch/sh/boot/dts/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_USE_BUILTIN_DTB) += $(patsubst "%",%,$(CONFIG_BUILTIN_DTB_SOURCE)).dtb.o
 
 dtb-y += landisk.dtb
+otb-y += r2dplus.dtb
 
 dtstree		:= $(srctree)/$(src)
 clean-files := *.dtb.S
diff --git a/arch/sh/boot/dts/r2dplus.dts b/arch/sh/boot/dts/r2dplus.dts
new file mode 100644
index 0000000..f9c01f9
--- /dev/null
+++ b/arch/sh/boot/dts/r2dplus.dts
@@ -0,0 +1,85 @@
+/dts-v1/;
+
+#include "sh7751.dtsi"
+
+/ {
+	model = "renesas,RTS7751R2D+";
+	compatible = "renesas,r2dplus";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	interrupt-parent = <&shintc>;
+	chosen {
+		stdout-path = "serial1:115200n8";
+	};
+	aliases {
+		serial1 = &sci1;
+	};
+
+	memory@0c000000 {
+		device_type = "memory";
+		reg = <0x0c000000 0x4000000>;
+	};
+
+	fpgaintc: fpga@a4000000 {
+		compatible = "renesas,r2dplus-intc";
+		#interrupt-cells = <1>;
+		#address-cells = <0>;
+		reg = <0xa4000000 0x40>;
+		interrupt-map=<0 &shintc evt2irq(0x200)>,
+		              <1 &shintc evt2irq(0x220)>,
+		              <2 &shintc evt2irq(0x240)>,
+			      <3 &shintc evt2irq(0x260)>,
+		              <4 &shintc evt2irq(0x280)>,
+			      <5 &shintc evt2irq(0x2a0)>,
+		              <6 &shintc evt2irq(0x2c0)>,
+			      <7 &shintc evt2irq(0x2e0)>,
+		              <8 &shintc evt2irq(0x300)>,
+			      <9 &shintc evt2irq(0x320)>,
+		              <10 &shintc evt2irq(0x340)>,
+			      <11 &shintc evt2irq(0x360)>,
+		              <12 &shintc evt2irq(0x380)>,
+			      <13 &shintc evt2irq(0x3a0)>,
+		              <14 &shintc evt2irq(0x3c0)>;
+	};
+
+	ide: ide@b4001000 {
+		compatible = "ata-generic";
+		reg = <0xb4001000 0x10>, <0xb400080c 0x02>;
+		interrupt-parent = <&fpgaintc>;
+		interrupts = <1 0>;
+		reg-shift = <1>;
+		pio-mode = <0>;
+	};
+
+	sm501: display@13e00000 {
+		compatible = "smi,sm501";
+		reg = <0x10000000 0x13dfffff>, <0x13e00000 0x13ffffff>;
+		interrupt-parent = <&fpgaintc>;
+		interrupts = <4 0>;
+		mode = "640x480-16@60";
+		edid = [00 ff ff ff ff ff ff 00 04 21 00 00 00 00 00 00
+		        01 00 01 04 00 00 00 00 08 00 00 00 00 00 00 00
+			00 00 00 20 00 00 01 40 01 00 01 00 01 00 01 00
+			01 00 01 00 01 00 d6 09 80 a0 20 e0 2d 10 10 60
+			a2 00 00 00 00 00 00 00 00 00 00 10 00 00 00 00
+			00 00 00 00 00 00 00 00 00 00 00 00 00 10 00 00
+			00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+			00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fd];
+		smi,devices = <1>;
+	};
+};
+
+&oclk {
+	clock-frequency = <60000000>;
+};
+
+&sci1 {
+	status = "ok";
+};
+
+&pci {
+	compatible = "renesas,sh7751-pci", "renesas.r2dplus-pci";
+	interrupt-map-mask = <0x1800 0 7>;
+	interrupt-map = <0x1000 0 1 &fpgaintc 3 0>;
+	status = "ok";
+};
-- 
2.7.0

