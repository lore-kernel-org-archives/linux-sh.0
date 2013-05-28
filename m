From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 28 May 2013 04:22:07 +0000
Subject: [PATCH 1/3 v3] ARM: shmobile: r8a7778: add I2C support
Message-Id: <8738t7ag43.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a platform device for the r8a7778 I2C.

Signed-off-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - __initdata was added

 arch/arm/mach-shmobile/clock-r8a7778.c        |   14 +++++++++++++-
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    2 ++
 arch/arm/mach-shmobile/setup-r8a7778.c        |   25 +++++++++++++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index b251e4d..1386c59 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -105,7 +105,8 @@ static struct clk *main_clks[] = {
 enum {
 	MSTP323, MSTP322, MSTP321,
 	MSTP114,
-	MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
+	MSTP030,
+	MSTP029, MSTP028, MSTP027, MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
 	MSTP016, MSTP015,
 	MSTP_NR };
 
@@ -114,6 +115,10 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP322] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 22, 0), /* SDHI1 */
 	[MSTP321] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 21, 0), /* SDHI2 */
 	[MSTP114] = SH_CLK_MSTP32(&p_clk, MSTPCR1, 14, 0), /* Ether */
+	[MSTP030] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 30, 0), /* I2C0 */
+	[MSTP029] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 29, 0), /* I2C1 */
+	[MSTP028] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 28, 0), /* I2C2 */
+	[MSTP027] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 27, 0), /* I2C3 */
 	[MSTP026] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 26, 0), /* SCIF0 */
 	[MSTP025] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 25, 0), /* SCIF1 */
 	[MSTP024] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 24, 0), /* SCIF2 */
@@ -125,11 +130,18 @@ static struct clk mstp_clks[MSTP_NR] = {
 };
 
 static struct clk_lookup lookups[] = {
+	/* main */
+	CLKDEV_CON_ID("peripheral_clk",	&p_clk),
+
 	/* MSTP32 clocks */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP323]), /* SDHI0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
 	CLKDEV_DEV_ID("sh-eth",	&mstp_clks[MSTP114]), /* Ether */
+	CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP030]), /* I2C0 */
+	CLKDEV_DEV_ID("i2c-rcar.1", &mstp_clks[MSTP029]), /* I2C1 */
+	CLKDEV_DEV_ID("i2c-rcar.2", &mstp_clks[MSTP028]), /* I2C2 */
+	CLKDEV_DEV_ID("i2c-rcar.3", &mstp_clks[MSTP027]), /* I2C3 */
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP026]), /* SCIF0 */
 	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP025]), /* SCIF1 */
 	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP024]), /* SCIF2 */
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index ae65b45..a428bc6 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -24,6 +24,8 @@
 extern void r8a7778_add_standard_devices(void);
 extern void r8a7778_add_standard_devices_dt(void);
 extern void r8a7778_add_ether_device(struct sh_eth_plat_data *pdata);
+extern void r8a7778_add_i2c_device(int id);
+
 extern void r8a7778_init_delay(void);
 extern void r8a7778_init_irq(void);
 extern void r8a7778_init_irq_dt(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 9191acc..eaa6b06 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -173,6 +173,31 @@ void __init r8a7778_sdhi_init(int id,
 		info, sizeof(*info));
 }
 
+/* I2C */
+static struct resource i2c_resources[] __initdata = {
+	/* I2C0 */
+	DEFINE_RES_MEM(0xffc70000, 0x1000),
+	DEFINE_RES_IRQ(gic_iid(0x63)),
+	/* I2C1 */
+	DEFINE_RES_MEM(0xffc71000, 0x1000),
+	DEFINE_RES_IRQ(gic_iid(0x6e)),
+	/* I2C2 */
+	DEFINE_RES_MEM(0xffc72000, 0x1000),
+	DEFINE_RES_IRQ(gic_iid(0x6c)),
+	/* I2C3 */
+	DEFINE_RES_MEM(0xffc73000, 0x1000),
+	DEFINE_RES_IRQ(gic_iid(0x6d)),
+};
+
+void __init r8a7778_add_i2c_device(int id)
+{
+	BUG_ON(id < 0 || id > 3);
+
+	platform_device_register_simple(
+		"i2c-rcar", id,
+		i2c_resources + (2 * id), 2);
+}
+
 void __init r8a7778_add_standard_devices(void)
 {
 	int i;
-- 
1.7.9.5

