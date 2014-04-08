From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 08 Apr 2014 07:15:21 +0000
Subject: [PATCH][RFC] ARM: shmobile: lager: move res/data into init function
Message-Id: <87txa4thq0.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

platform_device_register_xxx() uses kmemdup() for res / data.
This means we can move these codes into init function if
it was defined.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Simon, Magnus

This is not exciting patch, but cleanup code.
This is focusing to lager only at this point.
Actually, I would like to create board_add_xxx() function
for all devices, on all board-xxx.c / setup-xxx.c
Because, board-xxx.c has many global variable, but, almost all are copied
by kmemdup() and removed by __init.
It will be more readable if these are inside board_add_xxx() function.
Yes, not exciting...

 arch/arm/mach-shmobile/board-lager.c |  144 +++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 72 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index f0104bf..78625ff 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -116,17 +116,17 @@ static const struct rcar_du_platform_data lager_du_pdata __initconst = {
 	.num_encoders = ARRAY_SIZE(lager_du_encoders),
 };
 
-static const struct resource du_resources[] __initconst = {
-	DEFINE_RES_MEM(0xfeb00000, 0x70000),
-	DEFINE_RES_MEM_NAMED(0xfeb90000, 0x1c, "lvds.0"),
-	DEFINE_RES_MEM_NAMED(0xfeb94000, 0x1c, "lvds.1"),
-	DEFINE_RES_IRQ(gic_spi(256)),
-	DEFINE_RES_IRQ(gic_spi(268)),
-	DEFINE_RES_IRQ(gic_spi(269)),
-};
-
 static void __init lager_add_du_device(void)
 {
+	struct resource du_resources[] = {
+		DEFINE_RES_MEM(0xfeb00000, 0x70000),
+		DEFINE_RES_MEM_NAMED(0xfeb90000, 0x1c, "lvds.0"),
+		DEFINE_RES_MEM_NAMED(0xfeb94000, 0x1c, "lvds.1"),
+		DEFINE_RES_IRQ(gic_spi(256)),
+		DEFINE_RES_IRQ(gic_spi(268)),
+		DEFINE_RES_IRQ(gic_spi(269)),
+	};
+
 	struct platform_device_info info = {
 		.name = "rcar-du-r8a7790",
 		.id = -1,
@@ -341,18 +341,18 @@ static const struct resource qspi_resources[] __initconst = {
 };
 
 /* VIN */
-static const struct resource vin_resources[] __initconst = {
-	/* VIN0 */
-	DEFINE_RES_MEM(0xe6ef0000, 0x1000),
-	DEFINE_RES_IRQ(gic_spi(188)),
-	/* VIN1 */
-	DEFINE_RES_MEM(0xe6ef1000, 0x1000),
-	DEFINE_RES_IRQ(gic_spi(189)),
-};
-
 static void __init lager_add_vin_device(unsigned idx,
 					struct rcar_vin_platform_data *pdata)
 {
+	struct resource vin_resources[] = {
+		/* VIN0 */
+		DEFINE_RES_MEM(0xe6ef0000, 0x1000),
+		DEFINE_RES_IRQ(gic_spi(188)),
+		/* VIN1 */
+		DEFINE_RES_MEM(0xe6ef1000, 0x1000),
+		DEFINE_RES_IRQ(gic_spi(189)),
+	};
+
 	struct platform_device_info vin_info = {
 		.parent		= &platform_bus,
 		.name		= "r8a7790-vin",
@@ -559,13 +559,6 @@ static struct i2c_board_info i2c2_devices[] = {
 };
 
 /* Sound */
-static struct resource rsnd_resources[] __initdata = {
-	[RSND_GEN2_SCU]  = DEFINE_RES_MEM(0xec500000, 0x1000),
-	[RSND_GEN2_ADG]  = DEFINE_RES_MEM(0xec5a0000, 0x100),
-	[RSND_GEN2_SSIU] = DEFINE_RES_MEM(0xec540000, 0x1000),
-	[RSND_GEN2_SSI]  = DEFINE_RES_MEM(0xec541000, 0x1280),
-};
-
 static struct rsnd_ssi_platform_info rsnd_ssi[] = {
 	RSND_SSI_SET(0, 0, gic_spi(370), RSND_SSI_PLAY),
 	RSND_SSI_SET(0, 0, gic_spi(371), RSND_SSI_CLK_PIN_SHARE),
@@ -583,25 +576,32 @@ static struct rcar_snd_info rsnd_info = {
 	.scu_info_nr	= ARRAY_SIZE(rsnd_scu),
 };
 
-static struct asoc_simple_card_info rsnd_card_info = {
-	.name		= "AK4643",
-	.card		= "SSI01-AK4643",
-	.codec		= "ak4642-codec.2-0012",
-	.platform	= "rcar_sound",
-	.daifmt		= SND_SOC_DAIFMT_LEFT_J,
-	.cpu_dai = {
-		.name	= "rcar_sound",
-		.fmt	= SND_SOC_DAIFMT_CBS_CFS,
-	},
-	.codec_dai = {
-		.name	= "ak4642-hifi",
-		.fmt	= SND_SOC_DAIFMT_CBM_CFM,
-		.sysclk	= 11289600,
-	},
-};
-
 static void __init lager_add_rsnd_device(void)
 {
+	struct resource rsnd_resources[] = {
+		[RSND_GEN2_SCU]  = DEFINE_RES_MEM(0xec500000, 0x1000),
+		[RSND_GEN2_ADG]  = DEFINE_RES_MEM(0xec5a0000, 0x100),
+		[RSND_GEN2_SSIU] = DEFINE_RES_MEM(0xec540000, 0x1000),
+		[RSND_GEN2_SSI]  = DEFINE_RES_MEM(0xec541000, 0x1280),
+	};
+
+	struct asoc_simple_card_info rsnd_card_info = {
+		.name		= "AK4643",
+		.card		= "SSI01-AK4643",
+		.codec		= "ak4642-codec.2-0012",
+		.platform	= "rcar_sound",
+		.daifmt		= SND_SOC_DAIFMT_LEFT_J,
+		.cpu_dai = {
+			.name	= "rcar_sound",
+			.fmt	= SND_SOC_DAIFMT_CBS_CFS,
+		},
+		.codec_dai = {
+			.name	= "ak4642-hifi",
+			.fmt	= SND_SOC_DAIFMT_CBM_CFM,
+			.sysclk	= 11289600,
+		},
+	};
+
 	struct platform_device_info cardinfo = {
 		.parent         = &platform_bus,
 		.name           = "asoc-simple-card",
@@ -651,44 +651,44 @@ static struct resource sdhi2_resources[] __initdata = {
 };
 
 /* Internal PCI1 */
-static const struct resource pci1_resources[] __initconst = {
-	DEFINE_RES_MEM(0xee0b0000, 0x10000),	/* CFG */
-	DEFINE_RES_MEM(0xee0a0000, 0x10000),	/* MEM */
-	DEFINE_RES_IRQ(gic_spi(112)),
-};
-
-static const struct platform_device_info pci1_info __initconst = {
-	.parent		= &platform_bus,
-	.name		= "pci-rcar-gen2",
-	.id		= 1,
-	.res		= pci1_resources,
-	.num_res	= ARRAY_SIZE(pci1_resources),
-	.dma_mask	= DMA_BIT_MASK(32),
-};
-
 static void __init lager_add_usb1_device(void)
 {
+	struct resource pci1_resources[] = {
+		DEFINE_RES_MEM(0xee0b0000, 0x10000),	/* CFG */
+		DEFINE_RES_MEM(0xee0a0000, 0x10000),	/* MEM */
+		DEFINE_RES_IRQ(gic_spi(112)),
+	};
+
+	struct platform_device_info pci1_info = {
+		.parent		= &platform_bus,
+		.name		= "pci-rcar-gen2",
+		.id		= 1,
+		.res		= pci1_resources,
+		.num_res	= ARRAY_SIZE(pci1_resources),
+		.dma_mask	= DMA_BIT_MASK(32),
+	};
+
 	platform_device_register_full(&pci1_info);
 }
 
 /* Internal PCI2 */
-static const struct resource pci2_resources[] __initconst = {
-	DEFINE_RES_MEM(0xee0d0000, 0x10000),	/* CFG */
-	DEFINE_RES_MEM(0xee0c0000, 0x10000),	/* MEM */
-	DEFINE_RES_IRQ(gic_spi(113)),
-};
-
-static const struct platform_device_info pci2_info __initconst = {
-	.parent		= &platform_bus,
-	.name		= "pci-rcar-gen2",
-	.id		= 2,
-	.res		= pci2_resources,
-	.num_res	= ARRAY_SIZE(pci2_resources),
-	.dma_mask	= DMA_BIT_MASK(32),
-};
-
 static void __init lager_add_usb2_device(void)
 {
+	struct resource pci2_resources[] = {
+		DEFINE_RES_MEM(0xee0d0000, 0x10000),	/* CFG */
+		DEFINE_RES_MEM(0xee0c0000, 0x10000),	/* MEM */
+		DEFINE_RES_IRQ(gic_spi(113)),
+	};
+
+	struct platform_device_info pci2_info = {
+		.parent		= &platform_bus,
+		.name		= "pci-rcar-gen2",
+		.id		= 2,
+		.res		= pci2_resources,
+		.num_res	= ARRAY_SIZE(pci2_resources),
+		.dma_mask	= DMA_BIT_MASK(32),
+	};
+
 	platform_device_register_full(&pci2_info);
 }
 
-- 
1.7.9.5

