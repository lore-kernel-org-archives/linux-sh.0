From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 30 Sep 2015 14:51:35 +0000
Subject: [PATCH] Gen3 IPMMU and DU prototype
Message-Id: <20150930145135.28053.50009.sendpatchset@little-apple>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Here is yet another IPMMU hack but this time for Gen3.

The VGA port on r8a7795 Salvator-X may be used to test
the IPMMU via the DU and the modetest utility. At this
point this patch does not work as expected, but something
seems to happen at least.

On the r8a7795 Salvator-X board the VGA port is driven
by DU and VSPD instances. The IPMMU on r8a7795 seems to
be tied to via uTLBS not to the VSPD instances directy
but instead by going through FCPVD instances. These
FCPVD instances may require some setup and they have
their own MSTP bits to just make things more fun.

To keep things simple this prototype patch modifies
the DU driver to only use a single crtc and a single
VSPD with a single uTLB. When IPMMU is enabled the
idea is that the map/umap debug printk() will show
how the pages are mapped. Unfortunately I have not
been able to get the same result as on Gen2 so when
the IPMMU is enabled then the test image is incorrect.

From what I can tell the biggest challenges when it comes
to enabling IPMMU together with DU, VSPD and FCPVD on Gen3
seems to be:
 - FCPVD needs software support (collides with Gen2 VSP1 space).
 - The DU driver must be adjusted somehow to be able to pass
   separate device pointers to dma_alloc_writecombine() so
   the correct IPMMU uTLB will be used. See HACK below.

I'll try to separate and clean up some portions of the IPMMU driver
changes below and validate both on Gen2 and Gen3. Especially the
probe ordering and IRQ handling should be possible to reuse.

This prototype patch is not for upstream merge.

Not-Yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Built on top of vsp1-kms-gen3-20150929 plus...

 The following from linux-next:
  iommu/iova: Avoid over-allocating when size-aligned
  iommu: iova: Move iova cache management to the iova library
  iommu: iova: Export symbols
  iommu: Make the iova library a module

 And the following patches are picked from mailing lists:
  [PATCH v5 1/3] iommu: Implement common IOMMU ops for DMA mapping
  [PATCH v5 2/3] arm64: Add IOMMU dma_ops
  [PATCH v5 3/3] arm64: Hook up IOMMU dma_ops

 arch/arm64/boot/dts/renesas/r8a7795.dtsi |   16 +++
 drivers/clk/shmobile/clk-mstp.c          |   14 +++
 drivers/gpu/drm/rcar-du/rcar_du_drv.c    |    4 
 drivers/gpu/drm/rcar-du/rcar_du_vsp.c    |    2 
 drivers/iommu/Kconfig                    |    6 -
 drivers/iommu/ipmmu-vmsa.c               |  135 ++++++++++++++----------------
 drivers/media/platform/vsp1/vsp1_wpf.c   |    2 
 7 files changed, 102 insertions(+), 77 deletions(-)

--- 0001/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ work/arch/arm64/boot/dts/renesas/r8a7795.dtsi	2015-09-30 18:33:46.850513000 +0900
@@ -430,6 +430,7 @@
 						R8A7795_CLK_VSPI2 R8A7795_CLK_VSPI1
 						R8A7795_CLK_VSPI0
 					>;
+					force-enable = <0 1 2 3>;
 				};
 
 				mstp7_clks: mstp7@e615014c {
@@ -488,6 +489,15 @@
 			/* Empty node for now */
 		};
 
+		ipmmuvi: mmu@febd0000 {
+			compatible = "renesas,ipmmu-vmsa";
+			reg = <0 0xfebd0000 0 0x1000>;
+			interrupts = <GIC_SPI 196 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 197 IRQ_TYPE_LEVEL_HIGH>;
+			#iommu-cells = <1>;
+			status = "okay";
+		};
+
 		scif0: serial@e6e60000 {
 			compatible = "renesas,scif-r8a7795", "renesas,scif";
 			reg = <0 0xe6e60000 0 64>;
@@ -624,6 +634,7 @@
 			reg = <0 0xfea20000 0 0x8000>;
 			interrupts = <GIC_SPI 466 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp6_clks R8A7795_CLK_VSPD0>;
+			iommus = <&ipmmuvi 8>;
 
 			renesas,has-bru;
 			renesas,has-lif;
@@ -637,6 +648,7 @@
 			reg = <0 0xfea28000 0 0x8000>;
 			interrupts = <GIC_SPI 467 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp6_clks R8A7795_CLK_VSPD1>;
+			iommus = <&ipmmuvi 9>;
 
 			renesas,has-bru;
 			renesas,has-lif;
@@ -650,6 +662,7 @@
 			reg = <0 0xfea30000 0 0x8000>;
 			interrupts = <GIC_SPI 468 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp6_clks R8A7795_CLK_VSPD2>;
+			iommus = <&ipmmuvi 10>;
 
 			renesas,has-bru;
 			renesas,has-lif;
@@ -663,6 +676,7 @@
 			reg = <0 0xfea38000 0 0x8000>;
 			interrupts = <GIC_SPI 469 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&mstp6_clks R8A7795_CLK_VSPD3>;
+			iommus = <&ipmmuvi 11>;
 
 			renesas,has-bru;
 			renesas,has-lif;
@@ -688,7 +702,7 @@
 			clock-names = "du.0", "du.1", "du.2", "du.3", "lvds.0";
 			status = "disabled";
 
-			vsps = <&vspd0 &vspd1 &vspd2 &vspd3>;
+			vsps = <&vspd0>;
 
 			ports {
 				#address-cells = <1>;
--- 0001/drivers/clk/shmobile/clk-mstp.c
+++ work/drivers/clk/shmobile/clk-mstp.c	2015-09-30 18:32:55.060513000 +0900
@@ -244,6 +244,20 @@ static void __init cpg_mstp_clocks_init(
 		kfree(allocated_name);
 	}
 
+	for (i = 0; i < MSTP_MAX_CLOCKS; ++i) {
+		u32 clkidx;
+		u32 value;
+
+		if (of_property_read_u32_index(np, "force-enable",
+					       i, &clkidx) < 0)
+			break;
+
+		/* enable bit */
+		value = clk_readl(group->smstpcr);
+		value &= ~(1 << clkidx);
+		clk_writel(value, group->smstpcr);
+	}
+
 	of_clk_add_provider(np, of_clk_src_onecell_get, &group->data);
 }
 CLK_OF_DECLARE(cpg_mstp_clks, "renesas,cpg-mstp-clocks", cpg_mstp_clocks_init);
--- 0001/drivers/gpu/drm/rcar-du/rcar_du_drv.c
+++ work/drivers/gpu/drm/rcar-du/rcar_du_drv.c	2015-09-30 17:09:26.250513000 +0900
@@ -138,13 +138,13 @@ static const struct rcar_du_device_info
 	.features = RCAR_DU_FEATURE_CRTC_IRQ_CLOCK
 		  | RCAR_DU_FEATURE_EXT_CTRL_REGS
 		  | RCAR_DU_FEATURE_VSP1_SOURCE,
-	.num_crtcs = 4,
+	.num_crtcs = 1,
 	.routes = {
 		/* R8A7795 has one RGB output, one LVDS output and two
 		 * (currently unsupported) HDMI outputs.
 		 */
 		[RCAR_DU_OUTPUT_DPAD0] = {
-			.possible_crtcs = BIT(3),
+			.possible_crtcs = BIT(0),
 			.encoder_type = DRM_MODE_ENCODER_NONE,
 			.port = 0,
 		},
--- 0001/drivers/gpu/drm/rcar-du/rcar_du_vsp.c
+++ work/drivers/gpu/drm/rcar-du/rcar_du_vsp.c	2015-09-30 16:43:08.270513000 +0900
@@ -329,6 +329,8 @@ int rcar_du_vsp_init(struct rcar_du_vsp
 
 	vsp->vsp = &pdev->dev;
 
+	rcdu->ddev->dev = vsp->vsp; // HACK
+	
 	ret = vsp1_du_init(vsp->vsp);
 	if (ret < 0)
 		return ret;
--- 0006/drivers/iommu/Kconfig
+++ work/drivers/iommu/Kconfig	2015-09-30 16:43:08.270513000 +0900
@@ -43,7 +43,7 @@ config IOMMU_IO_PGTABLE_LPAE_SELFTEST
 endmenu
 
 config IOMMU_IOVA
-	tristate
+	bool
 
 config OF_IOMMU
        def_bool y
@@ -331,8 +331,8 @@ config SHMOBILE_IOMMU_L1SIZE
 
 config IPMMU_VMSA
 	bool "Renesas VMSA-compatible IPMMU"
-	depends on ARM_LPAE
-	depends on ARCH_SHMOBILE || COMPILE_TEST
+	depends on ARM_LPAE || ARM64
+	depends on ARCH_SHMOBILE || ARCH_RENESAS || COMPILE_TEST
 	select IOMMU_API
 	select IOMMU_IO_PGTABLE_LPAE
 	select ARM_DMA_USE_IOMMU
--- 0001/drivers/iommu/ipmmu-vmsa.c
+++ work/drivers/iommu/ipmmu-vmsa.c	2015-09-30 17:58:24.320513000 +0900
@@ -20,8 +20,9 @@
 #include <linux/platform_device.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
+#include <linux/of_iommu.h>
+#include <linux/of_platform.h>
 
-#include <asm/dma-iommu.h>
 #include <asm/pgalloc.h>
 
 #include "io-pgtable.h"
@@ -29,11 +30,10 @@
 struct ipmmu_vmsa_device {
 	struct device *dev;
 	void __iomem *base;
+	int irq;
 	struct list_head list;
 
 	unsigned int num_utlbs;
-
-	struct dma_iommu_mapping *mapping;
 };
 
 struct ipmmu_vmsa_domain {
@@ -293,10 +293,15 @@ static struct iommu_gather_ops ipmmu_gat
  * Domain/Context Management
  */
 
+static irqreturn_t ipmmu_domain_irq(int irq, void *dev);
+
 static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 {
 	phys_addr_t ttbr;
+	int ret;
 
+	dev_info(domain->mmu->dev, "IPMMU init_context!\n");
+	
 	/*
 	 * Allocate the page table operations.
 	 *
@@ -324,6 +329,15 @@ static int ipmmu_domain_init_context(str
 	if (!domain->iop)
 		return -EINVAL;
 
+	ret = devm_request_irq(domain->mmu->dev, domain->mmu->irq,
+			       ipmmu_domain_irq, IRQF_SHARED,
+			       dev_name(domain->mmu->dev), domain);
+	if (ret < 0) {
+		dev_err(domain->mmu->dev, "failed to request IRQ %d\n",
+			domain->mmu->irq);
+		return ret;
+	}
+	
 	/*
 	 * TODO: When adding support for multiple contexts, find an unused
 	 * context.
@@ -342,16 +356,26 @@ static int ipmmu_domain_init_context(str
 	 */
 	ipmmu_ctx_write(domain, IMTTBCR, IMTTBCR_EAE |
 			IMTTBCR_SH0_INNER_SHAREABLE | IMTTBCR_ORGN0_WB_WA |
-			IMTTBCR_IRGN0_WB_WA | IMTTBCR_SL0_LVL_1);
+			IMTTBCR_IRGN0_WB_WA
+#if 1 /* gen3 */			
+			| (0x02 << 6)
+#else
+			| IMTTBCR_SL0_LVL_1
+#endif		       
+			);
 
 	/* MAIR0 */
 	ipmmu_ctx_write(domain, IMMAIR0, domain->cfg.arm_lpae_s1_cfg.mair[0]);
 
 	/* IMBUSCR */
+#if 1 /* gen3 */
+	ipmmu_ctx_write(domain, IMBUSCR,
+			ipmmu_ctx_read(domain, IMBUSCR) | (1 << 0));
+#else
 	ipmmu_ctx_write(domain, IMBUSCR,
 			ipmmu_ctx_read(domain, IMBUSCR) &
 			~(IMBUSCR_DVM | IMBUSCR_BUSSEL_MASK));
-
+#endif	
 	/*
 	 * IMSTR
 	 * Clear all interrupt flags.
@@ -386,8 +410,9 @@ static void ipmmu_domain_destroy_context
  * Fault Handling
  */
 
-static irqreturn_t ipmmu_domain_irq(struct ipmmu_vmsa_domain *domain)
+static irqreturn_t ipmmu_domain_irq(int irq, void *dev)
 {
+	struct ipmmu_vmsa_domain *domain = dev;
 	const u32 err_mask = IMSTR_MHIT | IMSTR_ABORT | IMSTR_PF | IMSTR_TF;
 	struct ipmmu_vmsa_device *mmu = domain->mmu;
 	u32 status;
@@ -434,21 +459,6 @@ static irqreturn_t ipmmu_domain_irq(stru
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t ipmmu_irq(int irq, void *dev)
-{
-	struct ipmmu_vmsa_device *mmu = dev;
-	struct iommu_domain *io_domain;
-	struct ipmmu_vmsa_domain *domain;
-
-	if (!mmu->mapping)
-		return IRQ_NONE;
-
-	io_domain = mmu->mapping->domain;
-	domain = to_vmsa_domain(io_domain);
-
-	return ipmmu_domain_irq(domain);
-}
-
 /* -----------------------------------------------------------------------------
  * IOMMU Operations
  */
@@ -547,6 +557,8 @@ static int ipmmu_map(struct iommu_domain
 	if (!domain)
 		return -ENODEV;
 
+	printk("xxx map 0x%08lx <-> %pad %zu\n", iova, &paddr, size);
+
 	return domain->iop->map(domain->iop, iova, paddr, size, prot);
 }
 
@@ -555,6 +567,8 @@ static size_t ipmmu_unmap(struct iommu_d
 {
 	struct ipmmu_vmsa_domain *domain = to_vmsa_domain(io_domain);
 
+	printk("xxx unmap 0x%08lx %zu\n", iova, size);
+	
 	return domain->iop->unmap(domain->iop, iova, size);
 }
 
@@ -654,7 +668,7 @@ static int ipmmu_add_device(struct devic
 	}
 
 	ret = iommu_group_add_device(group, dev);
-	iommu_group_put(group);
+	//	iommu_group_put(group);
 
 	if (ret < 0) {
 		dev_err(dev, "Failed to add device to IPMMU group\n");
@@ -673,41 +687,9 @@ static int ipmmu_add_device(struct devic
 	archdata->num_utlbs = num_utlbs;
 	dev->archdata.iommu = archdata;
 
-	/*
-	 * Create the ARM mapping, used by the ARM DMA mapping core to allocate
-	 * VAs. This will allocate a corresponding IOMMU domain.
-	 *
-	 * TODO:
-	 * - Create one mapping per context (TLB).
-	 * - Make the mapping size configurable ? We currently use a 2GB mapping
-	 *   at a 1GB offset to ensure that NULL VAs will fault.
-	 */
-	if (!mmu->mapping) {
-		struct dma_iommu_mapping *mapping;
-
-		mapping = arm_iommu_create_mapping(&platform_bus_type,
-						   SZ_1G, SZ_2G);
-		if (IS_ERR(mapping)) {
-			dev_err(mmu->dev, "failed to create ARM IOMMU mapping\n");
-			ret = PTR_ERR(mapping);
-			goto error;
-		}
-
-		mmu->mapping = mapping;
-	}
-
-	/* Attach the ARM VA mapping to the device. */
-	ret = arm_iommu_attach_device(dev, mmu->mapping);
-	if (ret < 0) {
-		dev_err(dev, "Failed to attach device to VA mapping\n");
-		goto error;
-	}
-
 	return 0;
 
 error:
-	arm_iommu_release_mapping(mmu->mapping);
-
 	kfree(dev->archdata.iommu);
 	kfree(utlbs);
 
@@ -723,7 +705,6 @@ static void ipmmu_remove_device(struct d
 {
 	struct ipmmu_vmsa_archdata *archdata = dev->archdata.iommu;
 
-	arm_iommu_detach_device(dev);
 	iommu_group_remove_device(dev);
 
 	kfree(archdata->utlbs);
@@ -732,6 +713,12 @@ static void ipmmu_remove_device(struct d
 	dev->archdata.iommu = NULL;
 }
 
+static int ipmmu_of_xlate(struct device *dev, struct of_phandle_args *spec)
+{
+	dev_info(dev, "xxxx xlate!\n");
+	return 0;
+}
+
 static const struct iommu_ops ipmmu_ops = {
 	.domain_alloc = ipmmu_domain_alloc,
 	.domain_free = ipmmu_domain_free,
@@ -744,6 +731,7 @@ static const struct iommu_ops ipmmu_ops
 	.add_device = ipmmu_add_device,
 	.remove_device = ipmmu_remove_device,
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
+	.of_xlate = ipmmu_of_xlate,
 };
 
 /* -----------------------------------------------------------------------------
@@ -763,8 +751,6 @@ static int ipmmu_probe(struct platform_d
 {
 	struct ipmmu_vmsa_device *mmu;
 	struct resource *res;
-	int irq;
-	int ret;
 
 	if (!IS_ENABLED(CONFIG_OF) && !pdev->dev.platform_data) {
 		dev_err(&pdev->dev, "missing platform data\n");
@@ -800,19 +786,14 @@ static int ipmmu_probe(struct platform_d
 	 */
 	mmu->base += IM_NS_ALIAS_OFFSET;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
+	mmu->irq = platform_get_irq(pdev, 0);
+	if (mmu->irq < 0) {
 		dev_err(&pdev->dev, "no IRQ found\n");
-		return irq;
-	}
-
-	ret = devm_request_irq(&pdev->dev, irq, ipmmu_irq, 0,
-			       dev_name(&pdev->dev), mmu);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to request IRQ %d\n", irq);
-		return ret;
+		return mmu->irq;
 	}
 
+	dev_info(&pdev->dev, "IPMMU at %pR with IRQ %d\n", res, mmu->irq);
+	
 	ipmmu_device_reset(mmu);
 
 	/*
@@ -838,8 +819,6 @@ static int ipmmu_remove(struct platform_
 	list_del(&mmu->list);
 	spin_unlock(&ipmmu_devices_lock);
 
-	arm_iommu_release_mapping(mmu->mapping);
-
 	ipmmu_device_reset(mmu);
 
 	return 0;
@@ -878,9 +857,25 @@ static void __exit ipmmu_exit(void)
 	return platform_driver_unregister(&ipmmu_driver);
 }
 
-subsys_initcall(ipmmu_init);
 module_exit(ipmmu_exit);
 
+static int __init ipmmu_vmsa_iommu_of_setup(struct device_node *np)
+{
+	struct platform_device *pdev;
+
+	ipmmu_init();
+
+	pdev = of_platform_device_create(np, NULL, platform_bus_type.dev_root);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+        of_iommu_set_ops(np, (struct iommu_ops *)&ipmmu_ops);
+	return 0;
+}
+
+IOMMU_OF_DECLARE(ipmmu_vmsa_iommu_of, "renesas,ipmmu-vmsa",
+		 ipmmu_vmsa_iommu_of_setup);
+
 MODULE_DESCRIPTION("IOMMU API for Renesas VMSA-compatible IPMMU");
 MODULE_AUTHOR("Laurent Pinchart <laurent.pinchart@ideasonboard.com>");
 MODULE_LICENSE("GPL v2");
--- 0001/drivers/media/platform/vsp1/vsp1_wpf.c
+++ work/drivers/media/platform/vsp1/vsp1_wpf.c	2015-09-30 18:48:49.910513000 +0900
@@ -158,7 +158,7 @@ static int wpf_s_stream(struct v4l2_subd
 	if (vsp1->info->uapi)
 		mutex_lock(wpf->ctrls.lock);
 	outfmt |= wpf->alpha->cur.val << VI6_WPF_OUTFMT_PDV_SHIFT;
-	vsp1_wpf_write(wpf, VI6_WPF_OUTFMT, outfmt);
+	vsp1_wpf_write(wpf, VI6_WPF_OUTFMT, outfmt | (1 << 20));
 	if (vsp1->info->uapi)
 		mutex_unlock(wpf->ctrls.lock);
 
