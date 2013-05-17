From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 17 May 2013 14:55:20 +0000
Subject: [PATCH 9/9] ARM: shmobile: APE6EVM: add MMCIF and SDHI devices
Message-Id: <1368802520-16378-10-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Add platform devices for MMCIF and SDHI interfaces, used on APE6EVM,
regulators and pinmux data.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
---
 arch/arm/mach-shmobile/board-ape6evm.c |  121 ++++++++++++++++++++++++++++++++
 1 files changed, 121 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm.c b/arch/arm/mach-shmobile/board-ape6evm.c
index 9c69643..73fb063 100644
--- a/arch/arm/mach-shmobile/board-ape6evm.c
+++ b/arch/arm/mach-shmobile/board-ape6evm.c
@@ -22,15 +22,21 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/kernel.h>
+#include <linux/mfd/tmio.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sh_mmcif.h>
+#include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/fixed.h>
 #include <linux/regulator/machine.h>
 #include <linux/sh_clk.h>
 #include <linux/smsc911x.h>
+
 #include <mach/common.h>
 #include <mach/irqs.h>
 #include <mach/r8a73a4.h>
+
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
@@ -65,6 +71,98 @@ static struct platform_device lan9220_device = {
 	},
 };
 
+/* Fixed 3.3V regulator to be used by SDHI0,1, MMCIF0 */
+static struct regulator_consumer_supply fixed3v3_power_consumers[] = {
+	REGULATOR_SUPPLY("vmmc", "sh_mmcif.0"),
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.0"),
+	REGULATOR_SUPPLY("vmmc", "sh_mobile_sdhi.1"),
+};
+
+/* SDHI0 */
+static struct sh_mobile_sdhi_info sdhi0_info = {
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE,
+};
+
+static struct resource sdhi0_resources[] = {
+	{
+		.name	= "SDHI0",
+		.start	= 0xee100000,
+		.end	= 0xee100100 - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= gic_spi(165),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sdhi0_device = {
+	.name		= "sh_mobile_sdhi",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &sdhi0_info,
+	},
+	.num_resources	= ARRAY_SIZE(sdhi0_resources),
+	.resource	= sdhi0_resources,
+};
+
+/* SDHI1 */
+static struct sh_mobile_sdhi_info sdhi1_info = {
+	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ | MMC_CAP_NEEDS_POLL,
+	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE,
+};
+
+static struct resource sdhi1_resources[] = {
+	{
+		.name	= "SDHI1",
+		.start	= 0xee120000,
+		.end	= 0xee120100 - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= gic_spi(166),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device sdhi1_device = {
+	.name		= "sh_mobile_sdhi",
+	.id		= 1,
+	.dev		= {
+		.platform_data	= &sdhi1_info,
+	},
+	.num_resources	= ARRAY_SIZE(sdhi1_resources),
+	.resource	= sdhi1_resources,
+};
+
+/* MMCIF0 */
+static struct sh_mmcif_plat_data mmcif0_pdata = {
+	.caps		= MMC_CAP_4_BIT_DATA |
+			  MMC_CAP_8_BIT_DATA |
+			  MMC_CAP_NONREMOVABLE,
+};
+
+static struct resource mmcif0_resources[] = {
+	{
+		.name	= "MMCIF0",
+		.start	= 0xee200000,
+		.end	= 0xee200100 - 1,
+		.flags	= IORESOURCE_MEM,
+	}, {
+		.start	= gic_spi(169),
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device mmcif0_device = {
+	.name		= "sh_mmcif",
+	.id		= 0,
+	.dev		= {
+		.platform_data	= &mmcif0_pdata,
+	},
+	.num_resources	= ARRAY_SIZE(mmcif0_resources),
+	.resource	= mmcif0_resources,
+};
+
 static const struct pinctrl_map ape6evm_pinctrl_map[] = {
 	/* SCIFA0 console */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.0", "pfc-r8a73a4",
@@ -72,6 +170,23 @@ static const struct pinctrl_map ape6evm_pinctrl_map[] = {
 	/* SMSC */
 	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-r8a73a4",
 				  "irqc_irq40", "irqc"),
+	/* SDHI0: uSD: no WP */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a73a4",
+				  "sdhi0_data4", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a73a4",
+				  "sdhi0_ctrl", "sdhi0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a73a4",
+				  "sdhi0_cd", "sdhi0"),
+	/* SDHI1 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-r8a73a4",
+				  "sdhi1_data4", "sdhi1"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.1", "pfc-r8a73a4",
+				  "sdhi1_ctrl", "sdhi1"),
+	/* MMCIF0 */
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-r8a73a4",
+				  "mmc0_data8", "mmc0"),
+	PIN_MAP_MUX_GROUP_DEFAULT("sh_mmcif.0", "pfc-r8a73a4",
+				  "mmc0_ctrl", "mmc0"),
 };
 
 /*
@@ -79,6 +194,9 @@ static const struct pinctrl_map ape6evm_pinctrl_map[] = {
  */
 static struct platform_device *ape6evm_devices[] __initdata = {
 	&lan9220_device,
+	&sdhi0_device,
+	&sdhi1_device,
+	&mmcif0_device,
 };
 
 static void __init ape6evm_add_standard_devices(void)
@@ -108,6 +226,9 @@ static void __init ape6evm_add_standard_devices(void)
 
 	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 
+	regulator_register_always_on(1, "fixed-3.3V", fixed3v3_power_consumers,
+				     ARRAY_SIZE(fixed3v3_power_consumers), 3300000);
+
 	platform_add_devices(ape6evm_devices,
 			     ARRAY_SIZE(ape6evm_devices));
 }
-- 
1.7.2.5

