From: Magnus Damm <magnus.damm@gmail.com>
Date: Sun, 18 Oct 2015 05:26:56 +0000
Subject: [PATCH] ARM: shmobile: r8a7794: Disable all IPMMU nodes by default
Message-Id: <20151018052656.3608.65682.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

The r8a7794 IPMMU nodes for MX and DS are currently lacking
a line containing 'status = "disabled"', fix this by
making sure they are disabled like all other IPMMU nodes.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-20151015-v4.3-rc5 and
 [PATCH 00/02] ARM: shmobile: r8a7794 ALT board DU VGA port enablement
 No special dependencies.

 arch/arm/boot/dts/r8a7794.dtsi |    2 ++
 1 file changed, 2 insertions(+)

--- 0002/arch/arm/boot/dts/r8a7794.dtsi
+++ work/arch/arm/boot/dts/r8a7794.dtsi	2015-10-18 14:20:46.490513000 +0900
@@ -1135,6 +1135,7 @@
 		interrupts = <0 198 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 199 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
+		status = "disabled";
 	};
 
 	ipmmu_mp: mmu@ec680000 {
@@ -1151,6 +1152,7 @@
 		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 221 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
+		status = "disabled";
 	};
 
 	ipmmu_gp: mmu@e62a0000 {
