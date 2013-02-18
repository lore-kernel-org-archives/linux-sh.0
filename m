From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 18 Feb 2013 19:30:21 +0000
Subject: [PATCH v2 2/4] ARM: mach-shmobile: r8a7779: SATA DT configuration
Message-Id: <201302182330.44542.sergei.shtylyov@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Vladimir Barinov <vladimir.barinov@cogentembedded.com>

Allow configuration of the r8a7779 SoC SATA controller using a flattened device
tree.

Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes since v1:
- removed "0x" from the node name.
 
 arch/arm/boot/dts/r8a7779.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

Index: renesas/arch/arm/boot/dts/r8a7779.dtsi
=================================--- renesas.orig/arch/arm/boot/dts/r8a7779.dtsi
+++ renesas/arch/arm/boot/dts/r8a7779.dtsi
@@ -92,4 +92,11 @@
 		interrupts = <0 28 0x4>;
 		reg-io-width = <4>;
 	};
+
+	sata: sata@fc600000 {
+		compatible = "renesas,rcar-sata";
+		reg = <0xfc600000 0x2000>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 100 0x4>;
+	};
 };
