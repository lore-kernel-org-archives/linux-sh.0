From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 30 Sep 2015 14:22:42 +0000
Subject: [PATCH] Gen2 IPMMU and DU prototype
Message-Id: <20150930142242.25755.81946.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Here is a simple hack to enable the IPMMU on R-Car Gen2.

The VGA port on r8a7790 Lager may be driven by the DU
and the IPMMU via the modetest utility to output some
test image.

Actually the r8a7790 DU device is connected to the
IPMMU using two separate uTLBs, but the DU driver
is currently supporting all DU instances using a
single device. To make testing easily the r8a7790 DU
driver code is with this patch hacked to just cover
a single DU instance with a single IPMMU uTLB.

The map/umap debug printk() will show you if the IPMMU
is used or not. Another way could be to XOR the physical
address in the map routine to adjust the test image.

Several sources have told me that the DU on Lager is not
working as expected. With this hack (with or without IPMMU)
at least the VGA output seems fine. So it would be good
to look into HDMI and LVDS as well as unmodified VGA
support for the DU on the Lager board.

Also, we need to figure out how to modify the DU driver
to support multiple uTLBs.

Not for upstream merge.

Not-Yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/boot/dts/r8a7790.dtsi        |    3 ++-
 arch/arm/boot/dts/r8a7791.dtsi        |    3 ++-
 arch/arm/mm/dma-mapping.c             |    4 ++--
 drivers/gpu/drm/rcar-du/rcar_du_drv.c |    6 +++---
 drivers/iommu/ipmmu-vmsa.c            |    8 ++++++--
 drivers/of/device.c                   |    6 +++---
 6 files changed, 18 insertions(+), 12 deletions(-)

--- 0001/arch/arm/boot/dts/r8a7790.dtsi
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2015-09-29 15:04:37.540513000 +0900
@@ -882,6 +882,7 @@
 			 <&mstp7_clks R8A7790_CLK_LVDS0>,
 			 <&mstp7_clks R8A7790_CLK_LVDS1>;
 		clock-names = "du.0", "du.1", "du.2", "lvds.0", "lvds.1";
+		iommus = <&ipmmu_mx 15>;
 		status = "disabled";
 
 		ports {
@@ -1805,7 +1806,7 @@
 		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 221 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
-		status = "disabled";
+		status = "okay";
 	};
 
 	ipmmu_rt: mmu@ffc80000 {
--- 0001/arch/arm/boot/dts/r8a7791.dtsi
+++ work/arch/arm/boot/dts/r8a7791.dtsi	2015-09-29 14:15:26.610513000 +0900
@@ -919,6 +919,7 @@
 			 <&mstp7_clks R8A7791_CLK_DU1>,
 			 <&mstp7_clks R8A7791_CLK_LVDS0>;
 		clock-names = "du.0", "du.1", "lvds.0";
+		iommus = <&ipmmu_mx 15>;
 		status = "disabled";
 
 		ports {
@@ -1618,7 +1619,7 @@
 		interrupts = <0 222 IRQ_TYPE_LEVEL_HIGH>,
 			     <0 221 IRQ_TYPE_LEVEL_HIGH>;
 		#iommu-cells = <1>;
-		status = "disabled";
+		status = "okay";
 	};
 
 	ipmmu_rt: mmu@ffc80000 {
--- 0001/arch/arm/mm/dma-mapping.c
+++ work/arch/arm/mm/dma-mapping.c	2015-09-29 14:58:51.150513000 +0900
@@ -1998,7 +1998,7 @@ static int __arm_iommu_attach_device(str
 	kref_get(&mapping->kref);
 	to_dma_iommu_mapping(dev) = mapping;
 
-	pr_debug("Attached IOMMU controller to %s device.\n", dev_name(dev));
+	pr_info("Attached IOMMU controller to %s device.\n", dev_name(dev));
 	return 0;
 }
 
@@ -2043,7 +2043,7 @@ static void __arm_iommu_detach_device(st
 	kref_put(&mapping->kref, release_iommu_mapping);
 	to_dma_iommu_mapping(dev) = NULL;
 
-	pr_debug("Detached IOMMU controller from %s device.\n", dev_name(dev));
+	pr_info("Detached IOMMU controller from %s device.\n", dev_name(dev));
 }
 
 /**
--- 0001/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ work/drivers/gpu/drm/rcar-du/rcar_du_drv.c	2015-09-29 15:05:31.520513000 +0900
@@ -60,13 +60,13 @@ static const struct rcar_du_device_info
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS,
 	.quirks = RCAR_DU_QUIRK_ALIGN_128B | RCAR_DU_QUIRK_LVDS_LANES,
-	.num_crtcs = 3,
+	.num_crtcs = 2,
 	.routes = {
 		/* R8A7790 has one RGB output, two LVDS outputs and one
 		 * (currently unsupported) TCON output.
 		 */
 		[RCAR_DU_OUTPUT_DPAD0] = {
-			.possible_crtcs = BIT(2) | BIT(1) | BIT(0),
+			.possible_crtcs = BIT(1) | BIT(0),
 			.encoder_type = DRM_MODE_ENCODER_NONE,
 			.port = 0,
 		},
@@ -76,7 +76,7 @@ static const struct rcar_du_device_info
 			.port = 1,
 		},
 		[RCAR_DU_OUTPUT_LVDS1] = {
-			.possible_crtcs = BIT(2) | BIT(1),
+			.possible_crtcs = BIT(1),
 			.encoder_type = DRM_MODE_ENCODER_LVDS,
 			.port = 2,
 		},
--- 0001/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2015-09-29 15:12:31.610513000 +0900
@@ -7,7 +7,7 @@
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; version 2 of the License.
  */
-
+#define DEBUG
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
@@ -544,9 +544,11 @@ static int ipmmu_map(struct iommu_domain
 {
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 
+	printk("xxx map 0x%08lx <-> %pad %zu\n", iova, &paddr, size);
+
 	if (!domain)
 		return -ENODEV;
-
+	
 	return domain->iop->map(domain->iop, iova, paddr, size, prot);
 }
 
@@ -555,6 +557,8 @@ static size_t ipmmu_unmap(struct iommu_d
 {
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 
+	printk("xxx unmap 0x%08lx %zu\n", iova, size);
+
 	return domain->iop->unmap(domain->iop, iova, size);
 }
 
--- 0001/drivers/of/device.c
+++ work/drivers/of/device.c	2015-09-29 15:00:10.680513000 +0900
@@ -124,7 +124,7 @@ void of_dma_configure(struct device *dev
 			dev_err(dev, "Adjusted size 0x%llx invalid\n", size);
 			return;
 		}
-		dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
+		dev_info(dev, "dma_pfn_offset(%#08lx)\n", offset);
 	}
 
 	dev->dma_pfn_offset = offset;
@@ -139,11 +139,11 @@ void of_dma_configure(struct device *dev
 			     DMA_BIT_MASK(ilog2(dma_addr + size)));
 
 	coherent = of_dma_is_coherent(np);
-	dev_dbg(dev, "device is%sdma coherent\n",
+	dev_info(dev, "device is%sdma coherent\n",
 		coherent ? " " : " not ");
 
 	iommu = of_iommu_configure(dev, np);
-	dev_dbg(dev, "device is%sbehind an iommu\n",
+	dev_info(dev, "device is%sbehind an iommu\n",
 		iommu ? " " : " not ");
 
 	arch_setup_dma_ops(dev, dma_addr, size, iommu, coherent);
