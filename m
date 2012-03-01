From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 01 Mar 2012 04:25:28 +0000
Subject: [PATCH 2/2] ARM: mach-shmobile: mackerel: Add FSI DMAEngine support
Message-Id: <87k435rlqj.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <w3phbc5yjly.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <w3phbc5yjly.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

We needs un-manualed address to use DMA

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-mackerel.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
index 6e21194..4926fdc 100644
--- a/arch/arm/mach-shmobile/board-mackerel.c
+++ b/arch/arm/mach-shmobile/board-mackerel.c
@@ -955,6 +955,8 @@ fsi_set_rate_end:
 static struct sh_fsi_platform_info fsi_info = {
 	.port_a = {
 		.flags = SH_FSI_BRS_INV,
+		.tx_id = SHDMA_SLAVE_FSIA_TX,
+		.rx_id = SHDMA_SLAVE_FSIA_RX,
 	},
 	.port_b = {
 		.flags = SH_FSI_BRS_INV	|
@@ -967,9 +969,11 @@ static struct sh_fsi_platform_info fsi_info = {
 
 static struct resource fsi_resources[] = {
 	[0] = {
+		/* we need 0xFE1F0000 to access DMA
+		 * instead of 0xFE3C0000 */
 		.name	= "FSI",
-		.start	= 0xFE3C0000,
-		.end	= 0xFE3C0400 - 1,
+		.start  = 0xFE1F0000,
+		.end    = 0xFE1F0400 - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	[1] = {
-- 
1.7.5.4

