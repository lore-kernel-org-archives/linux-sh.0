From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 18 Dec 2015 02:29:51 +0000
Subject: [PATCH 21/25] ARM: shmobile: r8a7790: IPMMU compat string SoC part number update
Message-Id: <c8d6686e41afa560e4d5fc2b3f62aa79be3fb6d1.1450402264.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1450402264.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1450402264.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Update IPMMU compat strings to include SoC part number.

By specifying SoC part number in DT it becomes possible
to implement SoC specific features in the IPMMU driver.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7790.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index 4eab5f43f7e5..ee587cd823f5 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1770,7 +1770,7 @@
 	};
 
 	ipmmu_sy0: mmu@e6280000 {
-		compatible = "renesas,ipmmu-vmsa";
+		compatible = "renesas,ipmmu-r8a7790", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6280000 0 0x1000>;
 		interrupts = <0 223 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 224 IRQ_TYPE_LEVEL_HIGH>;
@@ -1779,7 +1779,7 @@
 	};
 
 	ipmmu_sy1: mmu@e6290000 {
-		compatible = "renesas,ipmmu-vmsa";
+		compatible = "renesas,ipmmu-r8a7790", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6290000 0 0x1000>;
 		interrupts = <0 225 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
@@ -1787,7 +1787,7 @@
 	};
 
 	ipmmu_ds: mmu@e6740000 {
-		compatible = "renesas,ipmmu-vmsa";
+		compatible = "renesas,ipmmu-r8a7790", "renesas,ipmmu-vmsa";
 		reg = <0 0xe6740000 0 0x1000>;
 		interrupts = <0 198 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 199 IRQ_TYPE_LEVEL_HIGH>;
@@ -1796,7 +1796,7 @@
 	};
 
 	ipmmu_mp: mmu@ec680000 {
-		compatible = "renesas,ipmmu-vmsa";
+		compatible = "renesas,ipmmu-r8a7790", "renesas,ipmmu-vmsa";
 		reg = <0 0xec680000 0 0x1000>;
 		interrupts = <0 226 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
@@ -1804,7 +1804,7 @@
 	};
 
 	ipmmu_mx: mmu@fe951000 {
-		compatible = "renesas,ipmmu-vmsa";
+		compatible = "renesas,ipmmu-r8a7790", "renesas,ipmmu-vmsa";
 		reg = <0 0xfe951000 0 0x1000>;
 		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 221 IRQ_TYPE_LEVEL_HIGH>;
@@ -1813,7 +1813,7 @@
 	};
 
 	ipmmu_rt: mmu@ffc80000 {
-		compatible = "renesas,ipmmu-vmsa";
+		compatible = "renesas,ipmmu-r8a7790", "renesas,ipmmu-vmsa";
 		reg = <0 0xffc80000 0 0x1000>;
 		interrupts = <0 307 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
-- 
2.1.4

