From: Simon Horman <horms@verge.net.au>
Date: Thu, 09 Jan 2014 08:33:42 +0000
Subject: Re: [PATCH 2/2] arm: shmobile: lager: Add SATA support
Message-Id: <20140109083342.GG9267@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 19, 2013 at 09:57:23PM +0400, Valentine Barshak wrote:
> This adds SATA support to Lager board. Only SATA1 port is available.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>

Thanks, I have queued up the following.
Please check that it is correct.

From: Valentine Barshak <valentine.barshak@cogentembedded.com>

arm: shmobile: lager: Add SATA support

This adds SATA support to Lager board. Only SATA1 port is available.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
Acked-by: Magnus Damm <damm@opensource.se>
[horms+renesas@verge.net.au: resolved trivial conflicts]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 91e19cc..470775f 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -349,6 +349,21 @@ static void __init lager_add_camera1_device(void)
 	lager_add_vin_device(1, &vin1_pdata);
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
@@ -444,6 +459,8 @@ static void __init lager_add_standard_devices(void)
 				      &vccq_sdhi2_info, sizeof(struct gpio_regulator_config));
 
 	lager_add_camera1_device();
+
+	platform_device_register_full(&sata1_info);
 }
 
 /*
