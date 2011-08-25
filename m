From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 25 Aug 2011 04:06:02 +0000
Subject: [PATCH 6/7] ARM: mach-shmobile: kota2: Add comment out separator
Message-Id: <87ty96t9so.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-kota2.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kota2.c b/arch/arm/mach-shmobile/board-kota2.c
index adc7312..bd9a784 100644
--- a/arch/arm/mach-shmobile/board-kota2.c
+++ b/arch/arm/mach-shmobile/board-kota2.c
@@ -48,6 +48,7 @@
 #include <asm/hardware/cache-l2x0.h>
 #include <asm/traps.h>
 
+/* SMSC 9220 */
 static struct resource smsc9220_resources[] = {
 	[0] = {
 		.start		= 0x14000000, /* CS5A */
@@ -77,6 +78,7 @@ static struct platform_device eth_device = {
 	.num_resources	= ARRAY_SIZE(smsc9220_resources),
 };
 
+/* KEYSC */
 static struct sh_keysc_info keysc_platdata = {
 	.mode		= SH_KEYSC_MODE_6,
 	.scan_timing	= 3,
@@ -120,6 +122,7 @@ static struct platform_device keysc_device = {
 	},
 };
 
+/* GPIO KEY */
 #define GPIO_KEY(c, g, d) { .code = c, .gpio = g, .desc = d, .active_low = 1 }
 
 static struct gpio_keys_button gpio_buttons[] = {
@@ -150,6 +153,7 @@ static struct platform_device gpio_keys_device = {
 	},
 };
 
+/* GPIO LED */
 #define GPIO_LED(n, g) { .name = n, .gpio = g }
 
 static struct gpio_led gpio_leds[] = {
@@ -175,6 +179,7 @@ static struct platform_device gpio_leds_device = {
 	},
 };
 
+/* MMCIF */
 static struct resource mmcif_resources[] = {
 	[0] = {
 		.name   = "MMCIF",
@@ -207,6 +212,7 @@ static struct platform_device mmcif_device = {
 	.resource       = mmcif_resources,
 };
 
+/* SDHI0 */
 static struct sh_mobile_sdhi_info sdhi0_info = {
 	.tmio_caps      = MMC_CAP_SD_HIGHSPEED,
 	.tmio_flags     = TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_HAS_IDLE_WAIT,
@@ -243,6 +249,7 @@ static struct platform_device sdhi0_device = {
 	},
 };
 
+/* SDHI1 */
 static struct sh_mobile_sdhi_info sdhi1_info = {
 	.tmio_caps      = MMC_CAP_NONREMOVABLE | MMC_CAP_SDIO_IRQ,
 	.tmio_flags     = TMIO_MMC_WRPROTECT_DISABLE | TMIO_MMC_HAS_IDLE_WAIT,
-- 
1.7.4.1

