From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 24 Dec 2009 05:27:47 +0000
Subject: [PATCH] sh: mach-ecovec24: setup.c detailed correction
Message-Id: <u7hsdvt4c.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

o remove unused define
o add device name comment

Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 194aaca..6a8861b 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -128,8 +128,6 @@ static struct platform_device nor_flash_device = {
 
 /* SH Eth */
 #define SH_ETH_ADDR	(0xA4600000)
-#define SH_ETH_MAHR	(SH_ETH_ADDR + 0x1C0)
-#define SH_ETH_MALR	(SH_ETH_ADDR + 0x1C8)
 static struct resource sh_eth_resources[] = {
 	[0] = {
 		.start = SH_ETH_ADDR,
@@ -509,6 +507,7 @@ static struct platform_device sdhi1_device = {
 
 #else
 
+/* MMC SPI */
 static int mmc_spi_get_ro(struct device *dev)
 {
 	return gpio_get_value(GPIO_PTY6);
@@ -542,6 +541,7 @@ static struct spi_board_info spi_bus[] = {
 	},
 };
 
+/* MSIOF0 */
 static struct sh_msiof_spi_info msiof0_data = {
 	.num_chipselect = 1,
 };
-- 
1.6.3.3

