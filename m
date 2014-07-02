From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 02 Jul 2014 04:28:38 +0000
Subject: [PATCH/RFC 2/6] ARM: shmobile: r8a7778: Add SCIF nodes
Message-Id: <1404275322-26514-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1404275322-26514-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1404275322-26514-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 48 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 3af0a21..55357dc 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -156,6 +156,54 @@
 		status = "disabled";
 	};
 
+	scif0: serial@ffe40000 {
+		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		reg = <0xffe40000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 70 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scif1: serial@ffe41000 {
+		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		reg = <0xffe41000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 71 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scif2: serial@ffe42000 {
+		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		reg = <0xffe42000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scif3: serial@ffe43000 {
+		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		reg = <0xffe43000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scif4: serial@ffe44000 {
+		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		reg = <0xffe44000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scif5: serial@ffe45000 {
+		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		reg = <0xffe45000 0x100>;
+		interrupt-parent = <&gic>;
+		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
 	mmcif: mmc@ffe4e000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0xffe4e000 0x100>;
-- 
2.0.0.rc2

