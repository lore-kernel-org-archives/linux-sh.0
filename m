From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 07 Aug 2013 22:56:30 +0000
Subject: [PATCH v2 7/9] ARM: shmobile: lager: Constify platform data and resources
Message-Id: <1375916192-22647-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Platform data and resources for Lager devices are kmemdup()ed when the
corresponding devices are registered and can thus be declared as const.
Do so.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-lager.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 4872939..76363f9 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -55,7 +55,7 @@ static struct gpio_led lager_leds[] = {
 	},
 };
 
-static __initdata struct gpio_led_platform_data lager_leds_pdata = {
+static const __initdata struct gpio_led_platform_data lager_leds_pdata = {
 	.leds		= lager_leds,
 	.num_leds	= ARRAY_SIZE(lager_leds),
 };
@@ -71,7 +71,7 @@ static struct gpio_keys_button gpio_buttons[] = {
 	GPIO_KEY(KEY_1,		RCAR_GP_PIN(1, 14),	"SW2-pin1"),
 };
 
-static __initdata struct gpio_keys_platform_data lager_keys_pdata = {
+static const __initdata struct gpio_keys_platform_data lager_keys_pdata = {
 	.buttons	= gpio_buttons,
 	.nbuttons	= ARRAY_SIZE(gpio_buttons),
 };
@@ -83,17 +83,17 @@ static struct regulator_consumer_supply fixed3v3_power_consumers[]  };
 
 /* MMCIF */
-static struct sh_mmcif_plat_data mmcif1_pdata __initdata = {
+static const struct sh_mmcif_plat_data mmcif1_pdata __initdata = {
 	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
 };
 
-static struct resource mmcif1_resources[] __initdata = {
+static const struct resource mmcif1_resources[] __initdata = {
 	DEFINE_RES_MEM_NAMED(0xee220000, 0x80, "MMCIF1"),
 	DEFINE_RES_IRQ(gic_spi(170)),
 };
 
 /* Ether */
-static struct sh_eth_plat_data ether_pdata __initdata = {
+static const struct sh_eth_plat_data ether_pdata __initdata = {
 	.phy			= 0x1,
 	.edmac_endian		= EDMAC_LITTLE_ENDIAN,
 	.register_type		= SH_ETH_REG_FAST_RCAR,
@@ -101,7 +101,7 @@ static struct sh_eth_plat_data ether_pdata __initdata = {
 	.ether_link_active_low	= 1,
 };
 
-static struct resource ether_resources[] __initdata = {
+static const struct resource ether_resources[] __initdata = {
 	DEFINE_RES_MEM(0xee700000, 0x400),
 	DEFINE_RES_IRQ(gic_spi(162)),
 };
@@ -156,7 +156,7 @@ static void __init lager_add_standard_devices(void)
 					  &ether_pdata, sizeof(ether_pdata));
 }
 
-static const char *lager_boards_compat_dt[] __initdata = {
+static const char * const lager_boards_compat_dt[] __initdata = {
 	"renesas,lager",
 	NULL,
 };
-- 
1.8.1.5

