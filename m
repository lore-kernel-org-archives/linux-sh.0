From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Wed, 18 Dec 2013 12:44:20 +0000
Subject: [PATCH 5/5] arm: shmobile: lager: Add SATA support
Message-Id: <1387370660-20481-6-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds SATA support to Lager board. Only SATA1 port is available.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/mach-shmobile/board-lager.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index af00f1d..287a0a1 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -466,6 +466,21 @@ static void __init lager_add_usb_devices(void)
 	lager_add_usb2_device();
 }
 
+/* SATA1 */
+static const struct resource sata1_resources[] __initconst = {
+	DEFINE_RES_MEM(0xee500000, 0x2000),
+	DEFINE_RES_IRQ(gic_spi(106)),
+};
+
+static const struct platform_device_info sata1_info __initconst = {
+	.parent		= &platform_bus,
+	.name		= "sata-r8a7790",
+	.id		= 1,
+	.res		= sata1_resources,
+	.num_res	= ARRAY_SIZE(sata1_resources),
+	.dma_mask	= DMA_BIT_MASK(32),
+};
+
 static const struct pinctrl_map lager_pinctrl_map[] = {
 	/* DU (CN10: ARGB0, CN13: LVDS) */
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7790", "pfc-r8a7790",
@@ -554,6 +569,8 @@ static void __init lager_add_standard_devices(void)
 				      &vccq_sdhi2_info, sizeof(struct gpio_regulator_config));
 
 	lager_add_usb_devices();
+
+	platform_device_register_full(&sata1_info);
 }
 
 /*
-- 
1.8.3.1

