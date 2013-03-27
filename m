From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 27 Mar 2013 19:21:12 +0000
Subject: [PATCH v2 1/2] ARM: mach-shmobile: r8a7779: Add DU support
Message-Id: <1364412073-12322-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add a function to register the DU device with board-specific platform
data.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/include/mach/common.h |  1 +
 arch/arm/mach-shmobile/setup-r8a7779.c       | 30 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 03f73de..4531872 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -68,6 +68,7 @@ extern void r8a7779_earlytimer_init(void);
 extern void r8a7779_add_early_devices(void);
 extern void r8a7779_add_standard_devices(void);
 extern void r8a7779_add_standard_devices_dt(void);
+extern void r8a7779_add_du_device(void *pdata);
 extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
 extern void r8a7779_pm_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index a460ba3..2f817d8 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -393,6 +393,29 @@ static struct platform_device sata_device = {
 	},
 };
 
+static struct resource du_resources[] = {
+	[0] = {
+		.name	= "Display Unit",
+		.start	= 0xfff80000,
+		.end	= 0xfffb1007,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= gic_iid(0x3f),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device du_device = {
+	.name		= "rcar-du",
+	.num_resources	= ARRAY_SIZE(du_resources),
+	.resource	= du_resources,
+	.id		= 0,
+	.dev	= {
+		.coherent_dma_mask = ~0,
+	},
+};
+
 static struct platform_device *r8a7779_devices_dt[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -428,6 +451,13 @@ void __init r8a7779_add_standard_devices(void)
 			    ARRAY_SIZE(r8a7779_late_devices));
 }
 
+void __init r8a7779_add_du_device(void *pdata)
+{
+	du_device.dev.platform_data = pdata;
+
+	platform_device_register(&du_device);
+}
+
 /* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
 void __init __weak r8a7779_register_twd(void) { }
 
-- 
1.8.1.5

