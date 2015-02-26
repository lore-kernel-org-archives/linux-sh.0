From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 26 Feb 2015 06:21:11 +0000
Subject: [PATCH 14/32] ARM: shmobile: r8a7791: Add IPMMU DT nodes
Message-Id: <f1951852ed17684f6033e96a9faf3dbe67c163ae.1424849129.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1424849129.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1424849129.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add the seven IPMMU instances found in the r8a7791 to DT with a disabled
status.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 60 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index e35812a..43fb58a 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1384,6 +1384,66 @@
 		status = "disabled";
 	};
 
+	ipmmu_sy0: mmu@e6280000 {
+		compatible = "renesas,ipmmu-vmsa";
+		reg = <0 0xe6280000 0 0x1000>;
+		interrupts = <0 223 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 224 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		status = "disabled";
+	};
+
+	ipmmu_sy1: mmu@e6290000 {
+		compatible = "renesas,ipmmu-vmsa";
+		reg = <0 0xe6290000 0 0x1000>;
+		interrupts = <0 225 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		status = "disabled";
+	};
+
+	ipmmu_ds: mmu@e6740000 {
+		compatible = "renesas,ipmmu-vmsa";
+		reg = <0 0xe6740000 0 0x1000>;
+		interrupts = <0 198 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 199 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		status = "disabled";
+	};
+
+	ipmmu_mp: mmu@ec680000 {
+		compatible = "renesas,ipmmu-vmsa";
+		reg = <0 0xec680000 0 0x1000>;
+		interrupts = <0 226 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		status = "disabled";
+	};
+
+	ipmmu_mx: mmu@fe951000 {
+		compatible = "renesas,ipmmu-vmsa";
+		reg = <0 0xfe951000 0 0x1000>;
+		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 221 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		status = "disabled";
+	};
+
+	ipmmu_rt: mmu@ffc80000 {
+		compatible = "renesas,ipmmu-vmsa";
+		reg = <0 0xffc80000 0 0x1000>;
+		interrupts = <0 307 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		status = "disabled";
+	};
+
+	ipmmu_gp: mmu@e62a0000 {
+		compatible = "renesas,ipmmu-vmsa";
+		reg = <0 0xe62a0000 0 0x1000>;
+		interrupts = <0 260 IRQ_TYPE_LEVEL_HIGH>,
+			     <0 261 IRQ_TYPE_LEVEL_HIGH>;
+		#iommu-cells = <1>;
+		status = "disabled";
+	};
+
 	rcar_sound: rcar_sound@ec500000 {
 		/*
 		 * #sound-dai-cells is required
-- 
2.1.4

