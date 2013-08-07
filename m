From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 07 Aug 2013 22:56:24 +0000
Subject: [PATCH v2 1/9] ARM: shmobile: r8a7779: Add DU support
Message-Id: <1375916192-22647-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a function to register the DU device with board-specific platform
data. The DU device is named rcar-du-r8a7779, fix the clock entry
accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/clock-r8a7779.c        |  2 +-
 arch/arm/mach-shmobile/include/mach/r8a7779.h |  2 ++
 arch/arm/mach-shmobile/setup-r8a7779.c        | 22 ++++++++++++++++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index 10340f5..21e6364 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -190,7 +190,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.3", &mstp_clks[MSTP320]), /* SDHI3 */
-	CLKDEV_DEV_ID("rcar-du.0", &mstp_clks[MSTP103]), /* DU */
+	CLKDEV_DEV_ID("rcar-du-r8a7779", &mstp_clks[MSTP103]), /* DU */
 };
 
 void __init r8a7779_clock_init(void)
diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index f08d6ec..3bafed3 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -6,6 +6,7 @@
 #include <linux/sh_eth.h>
 
 struct platform_device;
+struct rcar_du_platform_data;
 
 struct r8a7779_pm_ch {
 	unsigned long chan_offs;
@@ -31,6 +32,7 @@ extern void r8a7779_earlytimer_init(void);
 extern void r8a7779_add_early_devices(void);
 extern void r8a7779_add_standard_devices(void);
 extern void r8a7779_add_standard_devices_dt(void);
+extern void r8a7779_add_du_device(const struct rcar_du_platform_data *pdata);
 extern void r8a7779_add_ether_device(struct sh_eth_plat_data *pdata);
 extern void r8a7779_init_late(void);
 extern void r8a7779_clock_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 6a99333..d64209d 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -27,6 +27,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_data/irq-renesas-intc-irqpin.h>
+#include <linux/platform_data/rcar-du.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
 #include <linux/input.h>
@@ -605,6 +606,12 @@ static struct resource ether_resources[] __initdata = {
 	},
 };
 
+/* DU */
+static struct resource du_resources[] __initdata = {
+	DEFINE_RES_MEM(0xfff80000, 0x40000),
+	DEFINE_RES_IRQ(gic_iid(0x3f)),
+};
+
 static struct platform_device *r8a7779_devices_dt[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -640,6 +647,21 @@ void __init r8a7779_add_standard_devices(void)
 			    ARRAY_SIZE(r8a7779_standard_devices));
 }
 
+void __init r8a7779_add_du_device(const struct rcar_du_platform_data *pdata)
+{
+	struct platform_device_info info = {
+		.name = "rcar-du-r8a7779",
+		.id = -1,
+		.res = du_resources,
+		.num_res = ARRAY_SIZE(du_resources),
+		.data = pdata,
+		.size_data = sizeof(*pdata),
+		.dma_mask = DMA_BIT_MASK(32),
+	};
+
+	platform_device_register_full(&info);
+}
+
 void __init r8a7779_add_ether_device(struct sh_eth_plat_data *pdata)
 {
 	platform_device_register_resndata(&platform_bus, "r8a777x-ether", -1,
-- 
1.8.1.5

