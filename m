From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 15 Dec 2015 13:27:00 +0000
Subject: [PATCH/RFC 03/03] ARM: shmobile: r8a7795: Tie in IPMMU with SYS-DMAC0
Message-Id: <20151215132700.15356.86856.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Hook up IPMMU-MM and IPMMU-DS0 to the r8a7795 DTS and
make sure the SYS-DMAC0 is connected to IPMMU-DS0.

The DT binding for the IPMMU will change.

Not for upstream merge.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm64/boot/dts/renesas/r8a7795.dtsi |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- 0023/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ work/arch/arm64/boot/dts/renesas/r8a7795.dtsi	2015-12-15 15:13:00.300513000 +0900
@@ -312,6 +312,22 @@
 			reg = <0 0xe6060000 0 0x50c>;
 		};
 
+		ipmmu_mm: mmu@e67b0000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xe67b0000 0 0x1000>; /* IPMMU-MM */
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "okay";
+		};
+
+		ipmmu_ds0: mmu@e6740000 {
+			compatible = "renesas,ipmmu-r8a7795";
+			reg = <0 0xe6740000 0 0x1000>; /* IPMMU-DS0 */
+			#iommu-cells = <1>;
+			status = "okay";
+		};
+
 		dmac0: dma-controller@e6700000 {
 			compatible = "renesas,rcar-dmac";
 			reg = <0 0xe6700000 0 0x10000>;
@@ -342,6 +358,14 @@
 			power-domains = <&cpg>;
 			#dma-cells = <1>;
 			dma-channels = <16>;
+			iommus = <&ipmmu_ds0 0>, <&ipmmu_ds0 1>,
+			       <&ipmmu_ds0 2>, <&ipmmu_ds0 3>,
+			       <&ipmmu_ds0 4>, <&ipmmu_ds0 5>,
+			       <&ipmmu_ds0 6>, <&ipmmu_ds0 7>,
+			       <&ipmmu_ds0 8>, <&ipmmu_ds0 9>,
+			       <&ipmmu_ds0 10>, <&ipmmu_ds0 11>,
+			       <&ipmmu_ds0 12>, <&ipmmu_ds0 13>,
+			       <&ipmmu_ds0 14>, <&ipmmu_ds0 15>;
 		};
 
 		dmac1: dma-controller@e7300000 {
