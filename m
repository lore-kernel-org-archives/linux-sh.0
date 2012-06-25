From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Jun 2012 10:39:39 +0000
Subject: [PATCH 3/3] ARM: shmobile: kzm9g: enable DMAEngine on MMCIF
Message-Id: <87obo7k74o.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874npzllwk.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874npzllwk.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It is possible to reduce CPU load if MMCIF used DMAEngine.
This patch enabled it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-kzm9g.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 212c524..a16c970 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -343,6 +343,8 @@ static struct resource sh_mmcif_resources[] = {
 static struct sh_mmcif_plat_data sh_mmcif_platdata = {
 	.ocr		= MMC_VDD_165_195,
 	.caps		= MMC_CAP_8_BIT_DATA | MMC_CAP_NONREMOVABLE,
+	.slave_id_tx	= SHDMA_SLAVE_MMCIF_TX,
+	.slave_id_rx	= SHDMA_SLAVE_MMCIF_RX,
 };
 
 static struct platform_device mmc_device = {
-- 
1.7.5.4

