From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 18 Oct 2015 05:35:41 +0000
Subject: [PATCH] ARM: shmobile: r8a7793: Add IPMMU nodes
Message-Id: <20151018053541.26392.44581.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Add IPMMU nodes for the r8a7793 SoC. The IPMMU configuration for r8a7793
is identical to r8a7791 and includes SY0, SY1, DS, MP, MX, RT and GP.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-20151015-v4.3-rc5 and
 [PATCH 00/02] ARM: shmobile: r8a7794 ALT board DU VGA port enablement
 No special dependencies.

 arch/arm/boot/dts/r8a7793.dtsi |   59 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

--- 0001/arch/arm/boot/dts/r8a7793.dtsi
+++ work/arch/arm/boot/dts/r8a7793.dtsi	2015-10-18 14:29:42.180513000 +0900
@@ -371,4 +371,63 @@
 		};
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
 };
