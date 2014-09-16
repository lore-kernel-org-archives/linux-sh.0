From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 16 Sep 2014 10:46:45 +0000
Subject: [PATCH][TEST] ARM: shmobile: lager-reference: IPMMUDS and SYS-DMAC test
Message-Id: <20140916104645.14823.43403.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20140915134529.21562.28560.sendpatchset@w520>
In-Reply-To: <20140915134529.21562.28560.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

This is a prototype patch to allow simplified test of the
R-Car Gen2 IPMMU and the SYS-DMAC components. Not for upstream
merge. Please ignore unless you enjoy digging deep into IOMMU
and DMA Engine areas.

In detail, with this patch the IPMMUDS IOMMU hardware is combined
with a single instance of the SYS-DMAC that has been adjusted to
only include a single channel of DMA hardware for the DMA Engine API.

The target platform for this patch is the r8a7790 Lager board.

For test purpose the soon-to-be-removed C board code in the file
board-lager-reference.c is extended temporarily to include glue
code between the IPMMU driver and the SYS-DMAC driver. At this
point the IPMMU is handled as a regular platform device (this until
we have DT bindings) but the SYS-DMAC is handled as a DT device.
The actual DMA Engine driver for the SYS-DMAC is however not
upstream yet, so the stack of patches listed below are needed for
this to work.

The test program in dmatest.c is modified slightly to perform
some basic test on kernel boot. In general this all needs more work,
however the DMA Engine driver patches listed below should be possible
to merge independently of IOMMU enablement / integration order.

Not-Yet-Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written on top of renesas-devel-20140911-v3.17-rc4 together with
 the following DMA Engine driver patches:

 dmaengine: rcar-dmac: Cache hardware descriptors memory
 dmaengine: rcar-dmac: Implement support for hardware descriptor lists
 dmaengine: rcar-dmac: Compute maximum chunk size at runtime
 dmaengine: rcar-dmac: Fix typo in register definition
 dmaengine: rcar-dmac: Rename rcar_dmac_hw_desc to rcar_dmac_xfer_chunk
 dmaengine: rcar-dmac: Filter out channels from unrelated devices
 dma/sh: fix rcar-dma.c printk format warnings
 dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC) driver

 arch/arm/boot/dts/r8a7790.dtsi                 |   52 +-----------------------
 arch/arm/mach-shmobile/board-lager-reference.c |   28 ++++++++++++
 drivers/dma/dmatest.c                          |   12 ++---
 3 files changed, 37 insertions(+), 55 deletions(-)

--- 0001/arch/arm/boot/dts/r8a7790.dtsi
+++ work/arch/arm/boot/dts/r8a7790.dtsi	2014-09-16 18:13:51.000000000 +0900
@@ -257,61 +257,15 @@
 		compatible = "renesas,rcar-dmac";
 		reg = <0 0xe6700000 0 0x20000>;
 		interrupts = <0 197 IRQ_TYPE_LEVEL_HIGH
-			      0 200 IRQ_TYPE_LEVEL_HIGH
-			      0 201 IRQ_TYPE_LEVEL_HIGH
-			      0 202 IRQ_TYPE_LEVEL_HIGH
-			      0 203 IRQ_TYPE_LEVEL_HIGH
-			      0 204 IRQ_TYPE_LEVEL_HIGH
-			      0 205 IRQ_TYPE_LEVEL_HIGH
-			      0 206 IRQ_TYPE_LEVEL_HIGH
-			      0 207 IRQ_TYPE_LEVEL_HIGH
-			      0 208 IRQ_TYPE_LEVEL_HIGH
-			      0 209 IRQ_TYPE_LEVEL_HIGH
-			      0 210 IRQ_TYPE_LEVEL_HIGH
-			      0 211 IRQ_TYPE_LEVEL_HIGH
-			      0 212 IRQ_TYPE_LEVEL_HIGH
-			      0 213 IRQ_TYPE_LEVEL_HIGH
-			      0 214 IRQ_TYPE_LEVEL_HIGH>;
+			      0 200 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "error",
-				"ch0", "ch1", "ch2", "ch3",
-				"ch4", "ch5", "ch6", "ch7",
-				"ch8", "ch9", "ch10", "ch11",
-				"ch12", "ch13", "ch14";
+				"ch0";
 		clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC0>;
 		clock-names = "fck";
 		#dma-cells = <1>;
-		dma-channels = <15>;
+		dma-channels = <1>;
 	};
 
-	dmac1: dma-controller@e6720000 {
-		compatible = "renesas,rcar-dmac";
-		reg = <0 0xe6720000 0 0x20000>;
-		interrupts = <0 220 IRQ_TYPE_LEVEL_HIGH
-			      0 216 IRQ_TYPE_LEVEL_HIGH
-			      0 217 IRQ_TYPE_LEVEL_HIGH
-			      0 218 IRQ_TYPE_LEVEL_HIGH
-			      0 219 IRQ_TYPE_LEVEL_HIGH
-			      0 308 IRQ_TYPE_LEVEL_HIGH
-			      0 309 IRQ_TYPE_LEVEL_HIGH
-			      0 310 IRQ_TYPE_LEVEL_HIGH
-			      0 311 IRQ_TYPE_LEVEL_HIGH
-			      0 312 IRQ_TYPE_LEVEL_HIGH
-			      0 313 IRQ_TYPE_LEVEL_HIGH
-			      0 314 IRQ_TYPE_LEVEL_HIGH
-			      0 315 IRQ_TYPE_LEVEL_HIGH
-			      0 316 IRQ_TYPE_LEVEL_HIGH
-			      0 317 IRQ_TYPE_LEVEL_HIGH
-			      0 318 IRQ_TYPE_LEVEL_HIGH>;
-		interrupt-names = "error",
-				"ch0", "ch1", "ch2", "ch3",
-				"ch4", "ch5", "ch6", "ch7",
-				"ch8", "ch9", "ch10", "ch11",
-				"ch12", "ch13", "ch14";
-		clocks = <&mstp2_clks R8A7790_CLK_SYS_DMAC1>;
-		clock-names = "fck";
-		#dma-cells = <1>;
-		dma-channels = <15>;
-	};
 	i2c0: i2c@e6508000 {
 		#address-cells = <1>;
 		#size-cells = <0>;
--- 0001/arch/arm/mach-shmobile/board-lager-reference.c
+++ work/arch/arm/mach-shmobile/board-lager-reference.c	2014-09-16 18:39:12.000000000 +0900
@@ -21,6 +21,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
 #include <linux/of_platform.h>
+#include <linux/platform_data/ipmmu-vmsa.h>
 #include <linux/platform_data/rcar-du.h>
 
 #include <asm/mach/arch.h>
@@ -88,6 +89,32 @@ static void __init lager_add_du_device(v
 }
 
 /*
+ * IPMMUDS
+ */
+static struct resource ipmmu_resources[] = {
+	DEFINE_RES_MEM(0xe6740800, 0x800),
+	DEFINE_RES_IRQ(gic_spi(198)),
+};
+
+static const struct ipmmu_vmsa_master ipmmu_masters[] = {
+	{ "e6700000.dma-controller", 0, },
+};
+
+static struct ipmmu_vmsa_platform_data ipmmu_platform_data = {
+	.masters = ipmmu_masters,
+	.num_masters = ARRAY_SIZE(ipmmu_masters),
+};
+
+static void __init lager_add_ipmmu_devices(void)
+{
+	platform_device_register_resndata(NULL, "ipmmu-vmsa", -1,
+					  ipmmu_resources,
+					  ARRAY_SIZE(ipmmu_resources),
+					  &ipmmu_platform_data,
+					  sizeof(ipmmu_platform_data));
+}
+
+/*
  * This is a really crude hack to provide clkdev support to platform
  * devices until they get moved to DT.
  */
@@ -105,6 +132,7 @@ static void __init lager_add_standard_de
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 
 	lager_add_du_device();
+	lager_add_ipmmu_devices();
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {
--- 0001/drivers/dma/dmatest.c
+++ work/drivers/dma/dmatest.c	2014-09-16 18:10:24.000000000 +0900
@@ -22,7 +22,7 @@
 #include <linux/slab.h>
 #include <linux/wait.h>
 
-static unsigned int test_buf_size = 16384;
+static unsigned int test_buf_size = 4096;
 module_param(test_buf_size, uint, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(test_buf_size, "Size of the memcpy test buffer");
 
@@ -41,12 +41,12 @@ module_param(threads_per_chan, uint, S_I
 MODULE_PARM_DESC(threads_per_chan,
 		"Number of threads to start per channel (default: 1)");
 
-static unsigned int max_channels;
+static unsigned int max_channels = 1;
 module_param(max_channels, uint, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(max_channels,
 		"Maximum number of channels to use (default: all)");
 
-static unsigned int iterations;
+static unsigned int iterations = 1;
 module_param(iterations, uint, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(iterations,
 		"Iterations before stopping test (default: infinite)");
@@ -66,11 +66,11 @@ module_param(timeout, uint, S_IRUGO | S_
 MODULE_PARM_DESC(timeout, "Transfer Timeout in msec (default: 3000), "
 		 "Pass -1 for infinite timeout");
 
-static bool noverify;
+static bool noverify = 1;
 module_param(noverify, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(noverify, "Disable random data setup and verification");
 
-static bool verbose;
+static bool verbose = 1;
 module_param(verbose, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(verbose, "Enable \"success\" result messages (default: off)");
 
@@ -124,7 +124,7 @@ static struct kernel_param_ops run_ops  	.set = dmatest_run_set,
 	.get = dmatest_run_get,
 };
-static bool dmatest_run;
+static bool dmatest_run = true;
 module_param_cb(run, &run_ops, &dmatest_run, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(run, "Run the test (default: false)");
 
