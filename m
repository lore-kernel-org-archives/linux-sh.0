From: Valentine Barshak <valentine.barshak@cogentembedded.com>
Date: Thu, 19 Dec 2013 17:59:05 +0000
Subject: [PATCH 2/2] arm: shmobile: koelsch: Add SATA support
Message-Id: <1387475945-25995-3-git-send-email-valentine.barshak@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201310310219.58963.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201310310219.58963.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This adds SATA support to Koelsch board. Only SATA0 port is available.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
---
 arch/arm/mach-shmobile/board-koelsch.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index de7cc64..2ab5c75 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -148,6 +148,21 @@ static const struct gpio_keys_platform_data koelsch_keys_pdata __initconst = {
 	.nbuttons	= ARRAY_SIZE(gpio_buttons),
 };
 
+/* SATA0 */
+static const struct resource sata0_resources[] __initconst = {
+	DEFINE_RES_MEM(0xee300000, 0x2000),
+	DEFINE_RES_IRQ(gic_spi(105)),
+};
+
+static const struct platform_device_info sata0_info __initconst = {
+	.parent		= &platform_bus,
+	.name		= "sata-r8a7791",
+	.id		= 0,
+	.res		= sata0_resources,
+	.num_res	= ARRAY_SIZE(sata0_resources),
+	.dma_mask	= DMA_BIT_MASK(32),
+};
+
 static const struct pinctrl_map koelsch_pinctrl_map[] = {
 	/* DU */
 	PIN_MAP_MUX_GROUP_DEFAULT("rcar-du-r8a7791", "pfc-r8a7791",
@@ -192,6 +207,8 @@ static void __init koelsch_add_standard_devices(void)
 				      sizeof(koelsch_keys_pdata));
 
 	koelsch_add_du_device();
+
+	platform_device_register_full(&sata0_info);
 }
 
 /*
-- 
1.8.3.1

