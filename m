From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Apr 2014 17:35:59 +0000
Subject: [PATCH 3/4] ARM: shmobile: lager legacy: Enable Quad SPI transfers for the SPI FLASH
Message-Id: <1397496960-27848-4-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Magnus Damm <damm@opensource.se>
---
 arch/arm/mach-shmobile/board-lager.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 05c263b5de59..f8b1e05463cc 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -325,12 +325,12 @@ static const struct rspi_plat_data qspi_pdata __initconst = {
 
 static const struct spi_board_info spi_info[] __initconst = {
 	{
-		.modalias               = "m25p80",
-		.platform_data          = &spi_flash_data,
-		.mode                   = SPI_MODE_0,
-		.max_speed_hz           = 30000000,
-		.bus_num                = 0,
-		.chip_select            = 0,
+		.modalias	= "m25p80",
+		.platform_data	= &spi_flash_data,
+		.mode		= SPI_MODE_0 | SPI_TX_QUAD | SPI_RX_QUAD,
+		.max_speed_hz	= 30000000,
+		.bus_num	= 0,
+		.chip_select	= 0,
 	},
 };
 
-- 
1.7.9.5

