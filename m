From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 10 May 2010 14:01:22 +0000
Subject: [PATCH 03/07] sh: tie in hwblk clocks using clkdev
Message-Id: <20100510140122.32745.18444.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Use clkdev for lookup of hwblk clocks on
sh7722/sh7723/sh7724.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7722.c |   25 +++++++++++++++-
 arch/sh/kernel/cpu/sh4a/clock-sh7723.c |   48 +++++++++++++++++++++++++++++-
 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |   50 +++++++++++++++++++++++++++++++-
 3 files changed, 119 insertions(+), 4 deletions(-)

--- 0003/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7722.c	2010-05-10 21:30:13.000000000 +0900
@@ -186,7 +186,12 @@ static struct clk mstp_clks[HWBLK_NR] = 
 	SH_HWBLK_CLK("lcdc0", -1, P_CLK, HWBLK_LCDC, 0),
 };
 
+#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+
 static struct clk_lookup lookups[] = {
+	/* MSTP clocks */
+	CLKDEV_CON_ID("uram0", &mstp_clks[HWBLK_URAM]),
+	CLKDEV_CON_ID("xymem0", &mstp_clks[HWBLK_XYMEM]),
 	{
 		/* TMU0 */
 		.dev_id		= "sh_tmu.0",
@@ -202,7 +207,11 @@ static struct clk_lookup lookups[] = {
 		.dev_id		= "sh_tmu.2",
 		.con_id		= "tmu_fck",
 		.clk		= &mstp_clks[HWBLK_TMU],
-	}, {
+	},
+	CLKDEV_CON_ID("cmt_fck", &mstp_clks[HWBLK_CMT]),
+	CLKDEV_CON_ID("rwdt0", &mstp_clks[HWBLK_RWDT]),
+	CLKDEV_CON_ID("flctl0", &mstp_clks[HWBLK_FLCTL]),
+	{
 		/* SCIF0 */
 		.dev_id		= "sh-sci.0",
 		.con_id		= "sci_fck",
@@ -218,6 +227,20 @@ static struct clk_lookup lookups[] = {
 		.con_id		= "sci_fck",
 		.clk		= &mstp_clks[HWBLK_SCIF2],
 	},
+	CLKDEV_CON_ID("i2c0", &mstp_clks[HWBLK_IIC]),
+	CLKDEV_CON_ID("rtc0", &mstp_clks[HWBLK_RTC]),
+	CLKDEV_CON_ID("sdhi0", &mstp_clks[HWBLK_SDHI]),
+	CLKDEV_CON_ID("keysc0", &mstp_clks[HWBLK_KEYSC]),
+	CLKDEV_CON_ID("usbf0", &mstp_clks[HWBLK_USBF]),
+	CLKDEV_CON_ID("2dg0", &mstp_clks[HWBLK_2DG]),
+	CLKDEV_CON_ID("siu0", &mstp_clks[HWBLK_SIU]),
+	CLKDEV_CON_ID("vou0", &mstp_clks[HWBLK_VOU]),
+	CLKDEV_CON_ID("jpu0", &mstp_clks[HWBLK_JPU]),
+	CLKDEV_CON_ID("beu0", &mstp_clks[HWBLK_BEU]),
+	CLKDEV_CON_ID("ceu0", &mstp_clks[HWBLK_CEU]),
+	CLKDEV_CON_ID("veu0", &mstp_clks[HWBLK_VEU]),
+	CLKDEV_CON_ID("vpu0", &mstp_clks[HWBLK_VPU]),
+	CLKDEV_CON_ID("lcdc0", &mstp_clks[HWBLK_LCDC]),
 };
 
 int __init arch_clk_init(void)
--- 0003/arch/sh/kernel/cpu/sh4a/clock-sh7723.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7723.c	2010-05-10 21:28:48.000000000 +0900
@@ -213,7 +213,21 @@ static struct clk mstp_clks[] = {
 	SH_HWBLK_CLK("lcdc0", -1, B_CLK, HWBLK_LCDC, 0),
 };
 
+#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+
 static struct clk_lookup lookups[] = {
+	/* MSTP clocks */
+	CLKDEV_CON_ID("tlb0", &mstp_clks[HWBLK_TLB]),
+	CLKDEV_CON_ID("ic0", &mstp_clks[HWBLK_IC]),
+	CLKDEV_CON_ID("oc0", &mstp_clks[HWBLK_OC]),
+	CLKDEV_CON_ID("l2c0", &mstp_clks[HWBLK_L2C]),
+	CLKDEV_CON_ID("ilmem0", &mstp_clks[HWBLK_ILMEM]),
+	CLKDEV_CON_ID("fpu0", &mstp_clks[HWBLK_FPU]),
+	CLKDEV_CON_ID("intc0", &mstp_clks[HWBLK_INTC]),
+	CLKDEV_CON_ID("dmac0", &mstp_clks[HWBLK_DMAC0]),
+	CLKDEV_CON_ID("sh0", &mstp_clks[HWBLK_SHYWAY]),
+	CLKDEV_CON_ID("hudi0", &mstp_clks[HWBLK_HUDI]),
+	CLKDEV_CON_ID("ubc0", &mstp_clks[HWBLK_UBC]),
 	{
 		/* TMU0 */
 		.dev_id		= "sh_tmu.0",
@@ -229,7 +243,11 @@ static struct clk_lookup lookups[] = {
 		.dev_id		= "sh_tmu.2",
 		.con_id		= "tmu_fck",
 		.clk		= &mstp_clks[HWBLK_TMU0],
-	}, {
+	},
+	CLKDEV_CON_ID("cmt_fck", &mstp_clks[HWBLK_CMT]),
+	CLKDEV_CON_ID("rwdt0", &mstp_clks[HWBLK_RWDT]),
+	CLKDEV_CON_ID("dmac1", &mstp_clks[HWBLK_DMAC1]),
+	{
 		/* TMU3 */
 		.dev_id		= "sh_tmu.3",
 		.con_id		= "tmu_fck",
@@ -244,7 +262,9 @@ static struct clk_lookup lookups[] = {
 		.dev_id		= "sh_tmu.5",
 		.con_id		= "tmu_fck",
 		.clk		= &mstp_clks[HWBLK_TMU1],
-	}, {
+	},
+	CLKDEV_CON_ID("flctl0", &mstp_clks[HWBLK_FLCTL]),
+	{
 		/* SCIF0 */
 		.dev_id		= "sh-sci.0",
 		.con_id		= "sci_fck",
@@ -275,6 +295,30 @@ static struct clk_lookup lookups[] = {
 		.con_id		= "sci_fck",
 		.clk		= &mstp_clks[HWBLK_SCIF5],
 	},
+	CLKDEV_CON_ID("msiof0", &mstp_clks[HWBLK_MSIOF0]),
+	CLKDEV_CON_ID("msiof1", &mstp_clks[HWBLK_MSIOF1]),
+	CLKDEV_CON_ID("meram0", &mstp_clks[HWBLK_MERAM]),
+	CLKDEV_CON_ID("i2c0", &mstp_clks[HWBLK_IIC]),
+	CLKDEV_CON_ID("rtc0", &mstp_clks[HWBLK_RTC]),
+	CLKDEV_CON_ID("atapi0", &mstp_clks[HWBLK_ATAPI]),
+	CLKDEV_CON_ID("adc0", &mstp_clks[HWBLK_ADC]),
+	CLKDEV_CON_ID("tpu0", &mstp_clks[HWBLK_TPU]),
+	CLKDEV_CON_ID("irda0", &mstp_clks[HWBLK_IRDA]),
+	CLKDEV_CON_ID("tsif0", &mstp_clks[HWBLK_TSIF]),
+	CLKDEV_CON_ID("icb0", &mstp_clks[HWBLK_ICB]),
+	CLKDEV_CON_ID("sdhi0", &mstp_clks[HWBLK_SDHI0]),
+	CLKDEV_CON_ID("sdhi1", &mstp_clks[HWBLK_SDHI1]),
+	CLKDEV_CON_ID("keysc0", &mstp_clks[HWBLK_KEYSC]),
+	CLKDEV_CON_ID("usb0", &mstp_clks[HWBLK_USB]),
+	CLKDEV_CON_ID("2dg0", &mstp_clks[HWBLK_2DG]),
+	CLKDEV_CON_ID("siu0", &mstp_clks[HWBLK_SIU]),
+	CLKDEV_CON_ID("veu1", &mstp_clks[HWBLK_VEU2H1]),
+	CLKDEV_CON_ID("vou0", &mstp_clks[HWBLK_VOU]),
+	CLKDEV_CON_ID("beu0", &mstp_clks[HWBLK_BEU]),
+	CLKDEV_CON_ID("ceu0", &mstp_clks[HWBLK_CEU]),
+	CLKDEV_CON_ID("veu0", &mstp_clks[HWBLK_VEU2H0]),
+	CLKDEV_CON_ID("vpu0", &mstp_clks[HWBLK_VPU]),
+	CLKDEV_CON_ID("lcdc0", &mstp_clks[HWBLK_LCDC]),
 };
 
 int __init arch_clk_init(void)
--- 0003/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2010-05-10 21:21:50.000000000 +0900
@@ -235,7 +235,22 @@ static struct clk mstp_clks[HWBLK_NR] = 
 	SH_HWBLK_CLK("lcdc0", -1, B_CLK, HWBLK_LCDC, 0),
 };
 
+#define CLKDEV_CON_ID(_id, _clk) { .con_id = _id, .clk = _clk }
+
 static struct clk_lookup lookups[] = {
+	/* MSTP clocks */
+	CLKDEV_CON_ID("tlb0", &mstp_clks[HWBLK_TLB]),
+	CLKDEV_CON_ID("ic0", &mstp_clks[HWBLK_IC]),
+	CLKDEV_CON_ID("oc0", &mstp_clks[HWBLK_OC]),
+	CLKDEV_CON_ID("rs0", &mstp_clks[HWBLK_RSMEM]),
+	CLKDEV_CON_ID("ilmem0", &mstp_clks[HWBLK_ILMEM]),
+	CLKDEV_CON_ID("l2c0", &mstp_clks[HWBLK_L2C]),
+	CLKDEV_CON_ID("fpu0", &mstp_clks[HWBLK_FPU]),
+	CLKDEV_CON_ID("intc0", &mstp_clks[HWBLK_INTC]),
+	CLKDEV_CON_ID("dmac0", &mstp_clks[HWBLK_DMAC0]),
+	CLKDEV_CON_ID("sh0", &mstp_clks[HWBLK_SHYWAY]),
+	CLKDEV_CON_ID("hudi0", &mstp_clks[HWBLK_HUDI]),
+	CLKDEV_CON_ID("ubc0", &mstp_clks[HWBLK_UBC]),
 	{
 		/* TMU0 */
 		.dev_id		= "sh_tmu.0",
@@ -256,7 +271,11 @@ static struct clk_lookup lookups[] = {
 		.dev_id		= "sh_tmu.3",
 		.con_id		= "tmu_fck",
 		.clk		= &mstp_clks[HWBLK_TMU1],
-	}, {
+	},
+	CLKDEV_CON_ID("cmt_fck", &mstp_clks[HWBLK_CMT]),
+	CLKDEV_CON_ID("rwdt0", &mstp_clks[HWBLK_RWDT]),
+	CLKDEV_CON_ID("dmac1", &mstp_clks[HWBLK_DMAC1]),
+	{
 		/* TMU4 */
 		.dev_id		= "sh_tmu.4",
 		.con_id		= "tmu_fck",
@@ -297,6 +316,35 @@ static struct clk_lookup lookups[] = {
 		.con_id		= "sci_fck",
 		.clk		= &mstp_clks[HWBLK_SCIF5],
 	},
+	CLKDEV_CON_ID("msiof0", &mstp_clks[HWBLK_MSIOF0]),
+	CLKDEV_CON_ID("msiof1", &mstp_clks[HWBLK_MSIOF1]),
+	CLKDEV_CON_ID("keysc0", &mstp_clks[HWBLK_KEYSC]),
+	CLKDEV_CON_ID("rtc0", &mstp_clks[HWBLK_RTC]),
+	CLKDEV_CON_ID("i2c0", &mstp_clks[HWBLK_IIC0]),
+	CLKDEV_CON_ID("i2c1", &mstp_clks[HWBLK_IIC1]),
+	CLKDEV_CON_ID("mmc0", &mstp_clks[HWBLK_MMC]),
+	CLKDEV_CON_ID("eth0", &mstp_clks[HWBLK_ETHER]),
+	CLKDEV_CON_ID("atapi0", &mstp_clks[HWBLK_ATAPI]),
+	CLKDEV_CON_ID("tpu0", &mstp_clks[HWBLK_TPU]),
+	CLKDEV_CON_ID("irda0", &mstp_clks[HWBLK_IRDA]),
+	CLKDEV_CON_ID("tsif0", &mstp_clks[HWBLK_TSIF]),
+	CLKDEV_CON_ID("usb1", &mstp_clks[HWBLK_USB1]),
+	CLKDEV_CON_ID("usb0", &mstp_clks[HWBLK_USB0]),
+	CLKDEV_CON_ID("2dg0", &mstp_clks[HWBLK_2DG]),
+	CLKDEV_CON_ID("sdhi0", &mstp_clks[HWBLK_SDHI0]),
+	CLKDEV_CON_ID("sdhi1", &mstp_clks[HWBLK_SDHI1]),
+	CLKDEV_CON_ID("veu1", &mstp_clks[HWBLK_VEU1]),
+	CLKDEV_CON_ID("ceu1", &mstp_clks[HWBLK_CEU1]),
+	CLKDEV_CON_ID("beu1", &mstp_clks[HWBLK_BEU1]),
+	CLKDEV_CON_ID("2ddmac0", &mstp_clks[HWBLK_2DDMAC]),
+	CLKDEV_CON_ID("spu0", &mstp_clks[HWBLK_SPU]),
+	CLKDEV_CON_ID("jpu0", &mstp_clks[HWBLK_JPU]),
+	CLKDEV_CON_ID("vou0", &mstp_clks[HWBLK_VOU]),
+	CLKDEV_CON_ID("beu0", &mstp_clks[HWBLK_BEU0]),
+	CLKDEV_CON_ID("ceu0", &mstp_clks[HWBLK_CEU0]),
+	CLKDEV_CON_ID("veu0", &mstp_clks[HWBLK_VEU0]),
+	CLKDEV_CON_ID("vpu0", &mstp_clks[HWBLK_VPU]),
+	CLKDEV_CON_ID("lcdc0", &mstp_clks[HWBLK_LCDC]),
 };
 
 int __init arch_clk_init(void)
