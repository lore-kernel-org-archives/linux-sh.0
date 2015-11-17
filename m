From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 17 Nov 2015 04:31:05 +0000
Subject: [PATCH 02/04] ARM: shmobile: r8a7791: IPMMU compat string SoC part number update
Message-Id: <20151117043105.4521.14142.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Update IPMMU compat strings to include SoC part number.

By specifying SoC part number in DT it becomes possible 
to implement SoC specific features in the IPMMU driver.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/boot/dts/r8a7791.dtsi |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

--- 0001/arch/arm/boot/dts/r8a7791.dtsi
+++ work/arch/arm/boot/dts/r8a7791.dtsi	2015-11-17 13:02:09.830513000 +0900
@@ -1571,7 +1571,7 @@
 	};
 
 	ipmmu_sy0: mmu@e6280000 {
-		compatible = "renesas,ipmmu-vmsa";
+		compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6280000 0 0x1000>;
 		interrupts = <0 223 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 224 IRQ_TYPE_LEVEL_HIGH>;
@@ -1580,7 +1580,7 @@
 	};
 
 	ipmmu_sy1: mmu@e6290000 {
-		compatible = "renesas,ipmmu-vmsa";
+		compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6290000 0 0x1000>;
 		interrupts = <0 225 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
@@ -1588,7 +1588,7 @@
 	};
 
 	ipmmu_ds: mmu@e6740000 {
-		compatible = "renesas,ipmmu-vmsa";
+		compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6740000 0 0x1000>;
 		interrupts = <0 198 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 199 IRQ_TYPE_LEVEL_HIGH>;
@@ -1597,7 +1597,7 @@
 	};
 
 	ipmmu_mp: mmu@ec680000 {
-		compatible = "renesas,ipmmu-vmsa";
+		compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
 		reg = <0 0xec680000 0 0x1000>;
 		interrupts = <0 226 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
@@ -1605,7 +1605,7 @@
 	};
 
 	ipmmu_mx: mmu@fe951000 {
-		compatible = "renesas,ipmmu-vmsa";
+		compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
 		reg = <0 0xfe951000 0 0x1000>;
 		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 221 IRQ_TYPE_LEVEL_HIGH>;
@@ -1614,7 +1614,7 @@
 	};
 
 	ipmmu_rt: mmu@ffc80000 {
-		compatible = "renesas,ipmmu-vmsa";
+		compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
 		reg = <0 0xffc80000 0 0x1000>;
 		interrupts = <0 307 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
@@ -1622,7 +1622,7 @@
 	};
 
 	ipmmu_gp: mmu@e62a0000 {
-		compatible = "renesas,ipmmu-vmsa";
+		compatible = "renesas,ipmmu-r8a7791", "renesas,ipmmu-vmsa";
 		reg = <0 0xe62a0000 0 0x1000>;
 		interrupts = <0 260 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 261 IRQ_TYPE_LEVEL_HIGH>;
