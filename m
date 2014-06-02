From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Mon, 02 Jun 2014 13:40:24 +0000
Subject: [PATCH 4/4] ARM: shmobile: koelsch legacy: Enable DMA for QSPI
Message-Id: <1401716424-29740-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1401716424-29740-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1401716424-29740-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/board-koelsch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index c6c68892caa3..171ce3ea162a 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -182,6 +182,8 @@ static const struct resource qspi_resources[] __initconst = {
 
 static const struct rspi_plat_data qspi_pdata __initconst = {
 	.num_chipselect = 1,
+	.dma_tx_id	= SYS_DMAC_SLAVE_QSPI_TX,
+	.dma_rx_id	= SYS_DMAC_SLAVE_QSPI_RX,
 };
 
 /* SPI Flash memory (Spansion S25FL512SAGMFIG11 64 MiB) */
-- 
1.9.1

