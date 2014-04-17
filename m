From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 17 Apr 2014 22:45:03 +0000
Subject: [PATCH 14/14] ARM: shmobile: lager legacy: Enable Quad SPI transfers for the SPI FLASH
Message-Id: <a09b2f0ba170dc89a67d6c4c4f027b37a085dad9.1397774191.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1397774190.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1397774190.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-lager.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 6af09e1..6c4fcfe 100644
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
1.8.4

