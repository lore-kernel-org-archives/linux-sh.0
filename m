From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 11 Jul 2013 08:32:51 +0000
Subject: [PATCH 08/11] ARM: shmobile: r8a7779: cleanup registration of sh_eth
Message-Id: <87bo69fqds.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

No one is using sh_eth on r8a7779 board.
remove it

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/include/mach/r8a7779.h |    1 -
 arch/arm/mach-shmobile/setup-r8a7779.c        |   20 --------------------
 2 files changed, 21 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index f10727f7..213c3942 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -32,7 +32,6 @@ extern void r8a7779_earlytimer_init(void);
 extern void r8a7779_add_early_devices(void);
 extern void r8a7779_add_standard_devices(void);
 extern void r8a7779_add_standard_devices_dt(void);
-extern void r8a7779_add_ether_device(struct sh_eth_plat_data *pdata);
 extern void r8a7779_init_late(void);
 extern void r8a7779_clock_init(void);
 extern void r8a7779_pinmux_init(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 0863aa9..9f28b55 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -537,18 +537,6 @@ static struct platform_device ohci1_device = {
 	.resource	= ohci1_resources,
 };
 
-/* Ether */
-static struct resource ether_resources[] = {
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
 static struct platform_device *r8a7779_devices_dt[] __initdata = {
 	&scif0_device,
 	&scif1_device,
@@ -584,14 +572,6 @@ void __init r8a7779_add_standard_devices(void)
 			    ARRAY_SIZE(r8a7779_standard_devices));
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

