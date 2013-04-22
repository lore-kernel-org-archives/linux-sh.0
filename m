From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 22:59:56 +0000
Subject: [PATCH 15/37] ARM: shmobile: armadillo800eva: Replace GPIO_PORTx with GPIO port numbers
Message-Id: <1366671618-8796-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The PFC GPIO API implementation moved to using port numbers. Replace all
GPIO_PORTx enum usage with the corresponding port number. The GPIO_PORTx
enum values are identical to the port number on this platform.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index e034953..ff04d1e 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -579,7 +579,7 @@ static struct regulator_init_data vcc_sdhi0_init_data = {
 static struct fixed_voltage_config vcc_sdhi0_info = {
 	.supply_name = "SDHI0 Vcc",
 	.microvolts = 3300000,
-	.gpio = GPIO_PORT75,
+	.gpio = 75,
 	.enable_high = 1,
 	.init_data = &vcc_sdhi0_init_data,
 };
@@ -610,7 +610,7 @@ static struct regulator_init_data vccq_sdhi0_init_data = {
 };
 
 static struct gpio vccq_sdhi0_gpios[] = {
-	{GPIO_PORT17, GPIOF_OUT_INIT_LOW, "vccq-sdhi0" },
+	{17, GPIOF_OUT_INIT_LOW, "vccq-sdhi0" },
 };
 
 static struct gpio_regulator_state vccq_sdhi0_states[] = {
@@ -621,7 +621,7 @@ static struct gpio_regulator_state vccq_sdhi0_states[] = {
 static struct gpio_regulator_config vccq_sdhi0_info = {
 	.supply_name = "vqmmc",
 
-	.enable_gpio = GPIO_PORT74,
+	.enable_gpio = 74,
 	.enable_high = 1,
 	.enabled_at_boot = 0,
 
@@ -659,7 +659,7 @@ static struct regulator_init_data vcc_sdhi1_init_data = {
 static struct fixed_voltage_config vcc_sdhi1_info = {
 	.supply_name = "SDHI1 Vcc",
 	.microvolts = 3300000,
-	.gpio = GPIO_PORT16,
+	.gpio = 16,
 	.enable_high = 1,
 	.init_data = &vcc_sdhi1_init_data,
 };
@@ -688,7 +688,7 @@ static struct sh_mobile_sdhi_info sdhi0_info = {
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ |
 			  MMC_CAP_POWER_OFF_CARD,
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_USE_GPIO_CD,
-	.cd_gpio	= GPIO_PORT167,
+	.cd_gpio	= 167,
 };
 
 static struct resource sdhi0_resources[] = {
@@ -731,7 +731,7 @@ static struct sh_mobile_sdhi_info sdhi1_info = {
 			  MMC_CAP_POWER_OFF_CARD,
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_USE_GPIO_CD,
 	/* Port72 cannot generate IRQs, will be used in polling mode. */
-	.cd_gpio	= GPIO_PORT72,
+	.cd_gpio	= 72,
 };
 
 static struct resource sdhi1_resources[] = {
-- 
1.8.1.5

