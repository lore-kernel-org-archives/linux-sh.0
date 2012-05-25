From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 25 May 2012 15:45:21 +0000
Subject: [PATCH 1/5 v3] mmc: sh_mmcif: remove redundant .down_pwr() callback
Message-Id: <1337960752-4944-7-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1205251727260.13353@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>

From the original version of sh_mmcif the .set_pwr() callback has only been
used to turn the card's power on, and the .down_pwr() callback has been
used to turn it off. .set_pwr() can be used for both these tasks, which is
also how it is implemented by the only user of this API: the SH7724 ecovec
board.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/mmc/host/sh_mmcif.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index bdf42d5..3834b21 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -963,8 +963,8 @@ static void sh_mmcif_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			pm_runtime_put(&host->pd->dev);
 			clk_disable(host->hclk);
 			host->power = false;
-			if (p->down_pwr && ios->power_mode = MMC_POWER_OFF)
-				p->down_pwr(host->pd);
+			if (p->set_pwr && ios->power_mode = MMC_POWER_OFF)
+				p->set_pwr(host->pd, 0);
 		}
 		host->state = STATE_IDLE;
 		return;
-- 
1.7.2.5

--
To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
