From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 07 Jul 2014 07:54:27 +0000
Subject: [PATCH v2 02/30] ARM: shmobile: r8a7778: Add SCIF nodes
Message-Id: <1404719695-1634-3-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This describes all of the SCIF hardware of the r8a7778.
Each node is disabled and may be enabled as necessary
by board DTS files.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* Added ack from Laurent Pinchart
* Removed interrupt-parent property from each new node
  as it is inherited from the top-level.
* Expanded changelog
---
 arch/arm/boot/dts/r8a7778.dtsi | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index 3af0a21..ecfdf4b 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -156,6 +156,48 @@
 		status = "disabled";
 	};
 
+	scif0: serial@ffe40000 {
+		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		reg = <0xffe40000 0x100>;
+		interrupts = <0 70 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scif1: serial@ffe41000 {
+		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		reg = <0xffe41000 0x100>;
+		interrupts = <0 71 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scif2: serial@ffe42000 {
+		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		reg = <0xffe42000 0x100>;
+		interrupts = <0 72 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scif3: serial@ffe43000 {
+		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		reg = <0xffe43000 0x100>;
+		interrupts = <0 73 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scif4: serial@ffe44000 {
+		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		reg = <0xffe44000 0x100>;
+		interrupts = <0 74 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
+	scif5: serial@ffe45000 {
+		compatible = "renesas,scif-r8a7778", "renesas,scif";
+		reg = <0xffe45000 0x100>;
+		interrupts = <0 75 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
 	mmcif: mmc@ffe4e000 {
 		compatible = "renesas,sh-mmcif";
 		reg = <0xffe4e000 0x100>;
-- 
2.0.0.rc2

