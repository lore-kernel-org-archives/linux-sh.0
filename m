From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 May 2014 10:40:49 +0000
Subject: [PATCH 2/3] mmc: sdhi: tidyup mmc_data setting for R-Car SDHI
Message-Id: <87mwdzpn0v.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87ppivpn25.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ppivpn25.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Ball <cjb@laptop.org>
Cc: Simon <horms@verge.net.au>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

R-Car Gen2 SDHI has 2 block read HW bugs.
Current setting is using MMC_CAP2_NO_MULTI_READ,
but it is overkill.
We can use MMC_CAP2_NO_2BLKS_READ instead of it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 91058da..b3baa83 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -55,7 +55,7 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen1_compatible = {
 static const struct sh_mobile_sdhi_of_data of_rcar_gen2_compatible = {
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT | TMIO_MMC_WRPROTECT_DISABLE,
 	.capabilities	= MMC_CAP_SD_HIGHSPEED | MMC_CAP_SDIO_IRQ,
-	.capabilities2	= MMC_CAP2_NO_MULTI_READ,
+	.capabilities2	= MMC_CAP2_NO_2BLKS_READ,
 };
 
 static const struct of_device_id sh_mobile_sdhi_of_match[] = {
-- 
1.7.9.5

