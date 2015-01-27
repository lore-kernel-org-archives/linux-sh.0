From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 27 Jan 2015 09:13:23 +0000
Subject: [PATCH 1/3] ARM: shmobile: r8a7790: Add IPMMU DT nodes
Message-Id: <1422350005-20573-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383060193-1505-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383060193-1505-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add the six IPMMU instances found in the r8a7790 to DT with a disabled
status.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7790.dtsi | 51 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 56847bf09c3b..a9e601053bbb 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1473,4 +1473,55 @@
 			ssi9: ssi@9 { interrupts = <0 379 IRQ_TYPE_LEVEL_HIGH>; };
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
 };
-- 
2.0.5

