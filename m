From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 26 Apr 2012 21:48:32 +0000
Subject: [PATCH] sh: switch various MSTP PM clocks to device-ID look-up
Message-Id: <Pine.LNX.4.64.1204262327080.32219@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Most SH drivers, accessing clocks, used for their devices, directly, have
been converted to not use connection IDs for clock look-up. The runtime PM
subsystem does the same. This means, that clock look-up entries for such
devices with non-NULL connection IDs are useless. This patch converts such
clock look-up entries to correct device IDs.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

This supersedes my earlier patch "[PATCH 1/6] sh: switch MSIOF and MMCIF 
PM clocks to device-ID look-up"
http://www.spinics.net/lists/linux-sh/msg11015.html
After a more detailed look, I think, it is best to just convert these 
entries to CLKDEV_DEV_ID(), instead of adding them to existing 
CLKDEV_CON_ID() ones. It does look like the present entries are 
non-functional and keeping them around makes no sense. Most of these 
lookup entries are also currently unused - affected platforms don't 
register respective devices. The only used ones are
1. MMCIF on sh7757
2. DMA on sh7785 and sh7786
(1) will be broken without this patch, once "[PATCH 5/6] mmc: mmcif: don't 
use connection IDs to obtain a clock reference" is committed. So, this 
patch is required to keep MMCIF working on sh7757, and can actually be 
committed before the above patch, nothing would break. (2) won't affect 
the DMAC driver - it doesn't acquire clocks directly. The legacy SH DMA 
driver under arch/sh/drivers/dma/ doesn't use the clock API either.

What will be affected - is the runtime PM. It will begin to work:-) So, if 
any of these platforms have problems in that area, they can become 
apparent.

Another thing to note - I didn't convert TMU entries on sh7343 and sh7366. 
On both these platforms currently there's one tmu clock look-up entry with 
just a "tmu_fck" connection ID, but platforms themselves register multiple 
tmu devices. Without datasheets I have no idea, whether some clock entries 
are missing from the lookup table, or that entry controlls all TMU clocks, 
or only one (#0?) TMU clock can be switched on and off.

 arch/sh/kernel/cpu/sh4a/clock-sh7343.c |    8 ++++----
 arch/sh/kernel/cpu/sh4a/clock-sh7366.c |   12 ++++++------
 arch/sh/kernel/cpu/sh4a/clock-sh7757.c |    2 +-
 arch/sh/kernel/cpu/sh4a/clock-sh7785.c |    6 +++---
 arch/sh/kernel/cpu/sh4a/clock-sh7786.c |    8 ++++----
 arch/sh/kernel/cpu/sh4a/clock-shx3.c   |    4 ++--
 6 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7343.c b/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
index ea01a72..0e8904b 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7343.c
@@ -244,10 +244,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP108]),
 	CLKDEV_CON_ID("tpu0", &mstp_clks[MSTP225]),
 	CLKDEV_CON_ID("irda0", &mstp_clks[MSTP224]),
-	CLKDEV_CON_ID("sdhi0", &mstp_clks[MSTP218]),
-	CLKDEV_CON_ID("mmcif0", &mstp_clks[MSTP217]),
+	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP218]),
+	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP217]),
 	CLKDEV_CON_ID("sim0", &mstp_clks[MSTP216]),
-	CLKDEV_CON_ID("keysc0", &mstp_clks[MSTP214]),
+	CLKDEV_DEV_ID("sh_keysc.0", &mstp_clks[MSTP214]),
 	CLKDEV_CON_ID("tsif0", &mstp_clks[MSTP213]),
 	CLKDEV_CON_ID("s3d40", &mstp_clks[MSTP212]),
 	CLKDEV_CON_ID("usbf0", &mstp_clks[MSTP211]),
@@ -258,7 +258,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("ceu0", &mstp_clks[MSTP203]),
 	CLKDEV_CON_ID("veu0", &mstp_clks[MSTP202]),
 	CLKDEV_CON_ID("vpu0", &mstp_clks[MSTP201]),
-	CLKDEV_CON_ID("lcdc0", &mstp_clks[MSTP200]),
+	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0", &mstp_clks[MSTP200]),
 };
 
 int __init arch_clk_init(void)
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7366.c b/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
index 7ac07b4..fad5588 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7366.c
@@ -234,7 +234,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.1", &mstp_clks[MSTP006]),
 	CLKDEV_ICK_ID("sci_fck", "sh-sci.2", &mstp_clks[MSTP005]),
 
-	CLKDEV_CON_ID("msiof0", &mstp_clks[MSTP002]),
+	CLKDEV_DEV_ID("spi_sh_msiof.0", &mstp_clks[MSTP002]),
 	CLKDEV_CON_ID("sbr0", &mstp_clks[MSTP001]),
 	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP109]),
 	CLKDEV_CON_ID("icb0", &mstp_clks[MSTP227]),
@@ -242,16 +242,16 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("dacy1", &mstp_clks[MSTP224]),
 	CLKDEV_CON_ID("dacy0", &mstp_clks[MSTP223]),
 	CLKDEV_CON_ID("tsif0", &mstp_clks[MSTP222]),
-	CLKDEV_CON_ID("sdhi0", &mstp_clks[MSTP218]),
-	CLKDEV_CON_ID("mmcif0", &mstp_clks[MSTP217]),
+	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP218]),
+	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP217]),
 	CLKDEV_CON_ID("usbf0", &mstp_clks[MSTP211]),
 	CLKDEV_CON_ID("veu1", &mstp_clks[MSTP207]),
-	CLKDEV_CON_ID("vou0", &mstp_clks[MSTP205]),
+	CLKDEV_DEV_ID("sh-vou.0", &mstp_clks[MSTP205]),
 	CLKDEV_CON_ID("beu0", &mstp_clks[MSTP204]),
-	CLKDEV_CON_ID("ceu0", &mstp_clks[MSTP203]),
+	CLKDEV_DEV_ID("sh_mobile_ceu.0", &mstp_clks[MSTP203]),
 	CLKDEV_CON_ID("veu0", &mstp_clks[MSTP202]),
 	CLKDEV_CON_ID("vpu0", &mstp_clks[MSTP201]),
-	CLKDEV_CON_ID("lcdc0", &mstp_clks[MSTP200]),
+	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0", &mstp_clks[MSTP200]),
 };
 
 int __init arch_clk_init(void)
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
index 04ab5ae..4cbd9a3 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7757.c
@@ -131,7 +131,7 @@ static struct clk_lookup lookups[] = {
 
 	CLKDEV_CON_ID("usb_fck", &mstp_clks[MSTP103]),
 	CLKDEV_DEV_ID("renesas_usbhs.0", &mstp_clks[MSTP102]),
-	CLKDEV_CON_ID("mmc0", &mstp_clks[MSTP220]),
+	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP220]),
 	CLKDEV_CON_ID("rspi2", &mstp_clks[MSTP127]),
 };
 
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
index ab1c58f..6dea6b6 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7785.c
@@ -143,7 +143,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("ssi0_fck", &mstp_clks[MSTP020]),
 	CLKDEV_CON_ID("hac1_fck", &mstp_clks[MSTP017]),
 	CLKDEV_CON_ID("hac0_fck", &mstp_clks[MSTP016]),
-	CLKDEV_CON_ID("mmcif_fck", &mstp_clks[MSTP013]),
+	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP013]),
 	CLKDEV_CON_ID("flctl_fck", &mstp_clks[MSTP012]),
 
 	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.0", &mstp_clks[MSTP008]),
@@ -157,8 +157,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("hspi_fck", &mstp_clks[MSTP002]),
 	CLKDEV_CON_ID("hudi_fck", &mstp_clks[MSTP119]),
 	CLKDEV_CON_ID("ubc0", &mstp_clks[MSTP117]),
-	CLKDEV_CON_ID("dmac_11_6_fck", &mstp_clks[MSTP105]),
-	CLKDEV_CON_ID("dmac_5_0_fck", &mstp_clks[MSTP104]),
+	CLKDEV_DEV_ID("sh-dma-engine.1", &mstp_clks[MSTP105]),
+	CLKDEV_DEV_ID("sh-dma-engine.0", &mstp_clks[MSTP104]),
 	CLKDEV_CON_ID("gdta_fck", &mstp_clks[MSTP100]),
 };
 
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7786.c b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
index 4917094..c7107c5 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7786.c
@@ -152,8 +152,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("ssi0_fck", &mstp_clks[MSTP020]),
 	CLKDEV_CON_ID("hac1_fck", &mstp_clks[MSTP017]),
 	CLKDEV_CON_ID("hac0_fck", &mstp_clks[MSTP016]),
-	CLKDEV_CON_ID("i2c1_fck", &mstp_clks[MSTP015]),
-	CLKDEV_CON_ID("i2c0_fck", &mstp_clks[MSTP014]),
+	CLKDEV_DEV_ID("i2c-sh_mobile.1", &mstp_clks[MSTP015]),
+	CLKDEV_DEV_ID("i2c-sh_mobile.0", &mstp_clks[MSTP014]),
 
 	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.0", &mstp_clks[MSTP008]),
 	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.1", &mstp_clks[MSTP008]),
@@ -175,8 +175,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_CON_ID("pcie2_fck", &mstp_clks[MSTP110]),
 	CLKDEV_CON_ID("pcie1_fck", &mstp_clks[MSTP109]),
 	CLKDEV_CON_ID("pcie0_fck", &mstp_clks[MSTP108]),
-	CLKDEV_CON_ID("dmac_11_6_fck", &mstp_clks[MSTP105]),
-	CLKDEV_CON_ID("dmac_5_0_fck", &mstp_clks[MSTP104]),
+	CLKDEV_DEV_ID("sh-dma-engine.1", &mstp_clks[MSTP105]),
+	CLKDEV_DEV_ID("sh-dma-engine.0", &mstp_clks[MSTP104]),
 	CLKDEV_CON_ID("du_fck", &mstp_clks[MSTP103]),
 	CLKDEV_CON_ID("ether_fck", &mstp_clks[MSTP102]),
 };
diff --git a/arch/sh/kernel/cpu/sh4a/clock-shx3.c b/arch/sh/kernel/cpu/sh4a/clock-shx3.c
index 0f11b39..be753ee 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-shx3.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-shx3.c
@@ -132,8 +132,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("tmu_fck", "sh_tmu.5", &mstp_clks[MSTP009]),
 
 	CLKDEV_CON_ID("hudi_fck", &mstp_clks[MSTP119]),
-	CLKDEV_CON_ID("dmac_11_6_fck", &mstp_clks[MSTP105]),
-	CLKDEV_CON_ID("dmac_5_0_fck", &mstp_clks[MSTP104]),
+	CLKDEV_DEV_ID("sh-dma-engine.1", &mstp_clks[MSTP105]),
+	CLKDEV_DEV_ID("sh-dma-engine.0", &mstp_clks[MSTP104]),
 };
 
 int __init arch_clk_init(void)
-- 
1.7.2.5

