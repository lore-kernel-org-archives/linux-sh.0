From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 10 May 2010 11:23:49 +0000
Subject: [PATCH 04/13] sh: Use clkdev for sh7724 hwblk clocks
Message-Id: <20100510112349.14587.87227.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the sh7724 clock code to allow clkdev lookup
of the MSTP clocks. Needs to be done for all cpus.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/sh/kernel/cpu/sh4a/clock-sh7724.c |   50 ++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

--- 0004/arch/sh/kernel/cpu/sh4a/clock-sh7724.c
+++ work/arch/sh/kernel/cpu/sh4a/clock-sh7724.c	2010-05-10 18:53:08.000000000 +0900
@@ -235,6 +235,12 @@ static struct clk mstp_clks[HWBLK_NR] = 
 	SH_HWBLK_CLK("lcdc0", -1, B_CLK, HWBLK_LCDC, 0),
 };
 
+#define CLKDEV_NO_DEV(_name, _clk)		\
+{						\
+	.con_id = _name,			\
+	.clk = _clk,				\
+}
+
 static struct clk_lookup lookups[] = {
 	{
 		/* TMU0 */
@@ -297,6 +303,50 @@ static struct clk_lookup lookups[] = {
 		.con_id		= "sci_fck",
 		.clk		= &mstp_clks[HWBLK_SCIF5],
 	},
+	CLKDEV_NO_DEV("tlb0", &mstp_clks[HWBLK_TLB]),
+	CLKDEV_NO_DEV("ic0", &mstp_clks[HWBLK_IC]),
+	CLKDEV_NO_DEV("oc0", &mstp_clks[HWBLK_OC]),
+	CLKDEV_NO_DEV("rs0", &mstp_clks[HWBLK_RSMEM]),
+	CLKDEV_NO_DEV("ilmem0", &mstp_clks[HWBLK_ILMEM]),
+	CLKDEV_NO_DEV("l2c0", &mstp_clks[HWBLK_L2C]),
+	CLKDEV_NO_DEV("fpu0", &mstp_clks[HWBLK_FPU]),
+	CLKDEV_NO_DEV("intc0", &mstp_clks[HWBLK_INTC]),
+	CLKDEV_NO_DEV("dmac0", &mstp_clks[HWBLK_DMAC0]),
+	CLKDEV_NO_DEV("sh0", &mstp_clks[HWBLK_SHYWAY]),
+	CLKDEV_NO_DEV("hudi0", &mstp_clks[HWBLK_HUDI]),
+	CLKDEV_NO_DEV("ubc0", &mstp_clks[HWBLK_UBC]),
+	CLKDEV_NO_DEV("cmt_fck", &mstp_clks[HWBLK_CMT]),
+	CLKDEV_NO_DEV("rwdt0", &mstp_clks[HWBLK_RWDT]),
+	CLKDEV_NO_DEV("dmac1", &mstp_clks[HWBLK_DMAC1]),
+	CLKDEV_NO_DEV("msiof0", &mstp_clks[HWBLK_MSIOF0]),
+	CLKDEV_NO_DEV("msiof1", &mstp_clks[HWBLK_MSIOF1]),
+	CLKDEV_NO_DEV("keysc0", &mstp_clks[HWBLK_KEYSC]),
+	CLKDEV_NO_DEV("rtc0", &mstp_clks[HWBLK_RTC]),
+	CLKDEV_NO_DEV("i2c0", &mstp_clks[HWBLK_IIC0]),
+	CLKDEV_NO_DEV("i2c1", &mstp_clks[HWBLK_IIC1]),
+	CLKDEV_NO_DEV("mmc0", &mstp_clks[HWBLK_MMC]),
+	CLKDEV_NO_DEV("eth0", &mstp_clks[HWBLK_ETHER]),
+	CLKDEV_NO_DEV("atapi0", &mstp_clks[HWBLK_ATAPI]),
+	CLKDEV_NO_DEV("tpu0", &mstp_clks[HWBLK_TPU]),
+	CLKDEV_NO_DEV("irda0", &mstp_clks[HWBLK_IRDA]),
+	CLKDEV_NO_DEV("tsif0", &mstp_clks[HWBLK_TSIF]),
+	CLKDEV_NO_DEV("usb1", &mstp_clks[HWBLK_USB1]),
+	CLKDEV_NO_DEV("usb0", &mstp_clks[HWBLK_USB0]),
+	CLKDEV_NO_DEV("2dg0", &mstp_clks[HWBLK_2DG]),
+	CLKDEV_NO_DEV("sdhi0", &mstp_clks[HWBLK_SDHI0]),
+	CLKDEV_NO_DEV("sdhi1", &mstp_clks[HWBLK_SDHI1]),
+	CLKDEV_NO_DEV("veu1", &mstp_clks[HWBLK_VEU1]),
+	CLKDEV_NO_DEV("ceu1", &mstp_clks[HWBLK_CEU1]),
+	CLKDEV_NO_DEV("beu1", &mstp_clks[HWBLK_BEU1]),
+	CLKDEV_NO_DEV("2ddmac0", &mstp_clks[HWBLK_2DDMAC]),
+	CLKDEV_NO_DEV("spu0", &mstp_clks[HWBLK_SPU]),
+	CLKDEV_NO_DEV("jpu0", &mstp_clks[HWBLK_JPU]),
+	CLKDEV_NO_DEV("vou0", &mstp_clks[HWBLK_VOU]),
+	CLKDEV_NO_DEV("beu0", &mstp_clks[HWBLK_BEU0]),
+	CLKDEV_NO_DEV("ceu0", &mstp_clks[HWBLK_CEU0]),
+	CLKDEV_NO_DEV("veu0", &mstp_clks[HWBLK_VEU0]),
+	CLKDEV_NO_DEV("vpu0", &mstp_clks[HWBLK_VPU]),
+	CLKDEV_NO_DEV("lcdc0", &mstp_clks[HWBLK_LCDC]),
 };
 
 int __init arch_clk_init(void)
