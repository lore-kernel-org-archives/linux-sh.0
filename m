From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 02 Sep 2014 02:03:23 +0000
Subject: [PATCH 7/7 v2] mmc: remove MMC_CAP2_NO_MULTI_READ flags
Message-Id: <87bnqykcd2.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87r3zvzohj.wl%kuninori.morimoto.gx@gmail.com>
	<87lhq2kcif.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87lhq2kcif.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>, Simon <horms@verge.net.au>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Now, mmc framework uses blk_size_workaround
for block size HW bug workaround.
MMC_CAP2_NO_MULTI_READ flag is no longer needed

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v1 -> v2

- no change

 drivers/mmc/card/block.c |    5 -----
 include/linux/mmc/host.h |    1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index e946067..7b09ac3 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -1398,11 +1398,6 @@ static void mmc_blk_rw_rq_prep(struct mmc_queue_req *mqrq,
 		if (disable_multi)
 			brq->data.blocks = 1;
 
-		/* Some controllers can't do multiblock reads due to hw bugs */
-		if (card->host->caps2 & MMC_CAP2_NO_MULTI_READ &&
-		    rq_data_dir(req) = READ)
-			brq->data.blocks = 1;
-
 		/* Some controllers needs workaround */
 		if (card->host->ops->blk_size_workaround)
 			brq->data.blocks = card->host->ops->blk_size_workaround(
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 95bd903..70d2cfc 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -269,7 +269,6 @@ struct mmc_host {
 
 #define MMC_CAP2_BOOTPART_NOACC	(1 << 0)	/* Boot partition no access */
 #define MMC_CAP2_FULL_PWR_CYCLE	(1 << 2)	/* Can do full power cycle */
-#define MMC_CAP2_NO_MULTI_READ	(1 << 3)	/* Multiblock reads don't work */
 #define MMC_CAP2_HS200_1_8V_SDR	(1 << 5)        /* can support */
 #define MMC_CAP2_HS200_1_2V_SDR	(1 << 6)        /* can support */
 #define MMC_CAP2_HS200		(MMC_CAP2_HS200_1_8V_SDR | \
-- 
1.7.9.5

