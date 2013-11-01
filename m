From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 01 Nov 2013 01:00:19 +0000
Subject: [PATCH 2/2] ARM: shmobile: r8a7779: cleanup registration of sh_eth
Message-Id: <874n7xylzz.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sh_eth driver which needs platform data at the time of
registration is not used.
Now, ARM/shmobile aims to support DT,
and the C code base board support will be removed
if DT support is completed.
Current driver registration method which needs platform data
and which is not shared complicates codes.
This means legacy C code cleanup after DT supporting
will be more complicated
This patch registers it on board code as cleanup C code

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    2 --
 arch/arm/mach-shmobile/setup-r8a7779.c        |   20 --------------------
 2 files changed, 22 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index 1cab247..5014145 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -3,7 +3,6 @@
 
 #include <linux/sh_clk.h>
 #include <linux/pm_domain.h>
-#include <linux/sh_eth.h>
 
 /* HPB-DMA slave IDs */
 enum {
@@ -39,7 +38,6 @@ extern void r8a7779_earlytimer_init(void);
 extern void r8a7779_add_early_devices(void);
 extern void r8a7779_add_standard_devices(void);
 extern void r8a7779_add_standard_devices_dt(void);
-extern void r8a7779_add_ether_device(struct sh_eth_plat_data *pdata);
 extern void r8a7779_init_late(void);
 extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 51a43c5..8f94531 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -598,18 +598,6 @@ static struct platform_device ohci1_device = {
 	.resource	= ohci1_resources,
 };
 
-/* Ether */
-static struct resource ether_resources[] __initdata = {
-	{
-		.start	= 0xfde00000,
-		.end	= 0xfde003ff,
-		.flags	= IORESOURCE_MEM,
-	}, {
-		.start	= gic_iid(0xb4),
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
 /* HPB-DMA */
 
 /* Asynchronous mode register bits */
@@ -798,14 +786,6 @@ void __init r8a7779_add_standard_devices(void)
 	r8a7779_register_hpb_dmae();
 }
 
-void __init r8a7779_add_ether_device(struct sh_eth_plat_data *pdata)
-{
-	platform_device_register_resndata(&platform_bus, "r8a777x-ether", -1,
-					  ether_resources,
-					  ARRAY_SIZE(ether_resources),
-					  pdata, sizeof(*pdata));
-}
-
 /* do nothing for !CONFIG_SMP or !CONFIG_HAVE_TWD */
 void __init __weak r8a7779_register_twd(void) { }
 
-- 
1.7.9.5

