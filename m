From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 24 Jan 2014 12:49:50 +0000
Subject: [PATCH 14/15] ARM: shmobile: koelsch legacy: Enable Quad SPI transfers for the SPI FLASH
Message-Id: <1390567791-8988-15-git-send-email-geert@linux-m68k.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1390567791-8988-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1390567791-8988-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
This depends on spi-rspi and m25p80 updates

 arch/arm/mach-shmobile/board-koelsch.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index 56020d9fa841..4cb8674bc4a8 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -195,7 +195,7 @@ static const struct spi_board_info spi_info[] __initconst = {
 	{
 		.modalias	= "m25p80",
 		.platform_data	= &spi_flash_data,
-		.mode		= SPI_MODE_0,
+		.mode		= SPI_MODE_0 | SPI_TX_QUAD | SPI_RX_QUAD,
 		.max_speed_hz	= 30000000,
 		.bus_num	= 0,
 		.chip_select	= 0,
-- 
1.7.9.5

