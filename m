From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 27 Jan 2015 09:13:25 +0000
Subject: [PATCH 3/3] ARM: shmobile: r8a7794: Add IPMMU DT nodes
Message-Id: <1422350005-20573-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414648736-31412-4-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1414648736-31412-4-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add the six IPMMU instances found in the r8a7794 to DT with a disabled
status.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7794.dtsi | 50 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7794.dtsi b/arch/arm/boot/dts/r8a7794.dtsi
index 8f78da5ef10b..2239dab77ce2 100644
--- a/arch/arm/boot/dts/r8a7794.dtsi
+++ b/arch/arm/boot/dts/r8a7794.dtsi
@@ -585,4 +585,54 @@
 			clock-output-names = "scifa3", "scifa4", "scifa5";
 		};
 	};
+
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
 };
-- 
2.0.5

