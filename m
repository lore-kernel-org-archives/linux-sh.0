From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Sun, 14 Jun 2015 17:22:45 +0000
Subject: [PATCH/RFC] mmc: tmio: Fix suspend process
Message-Id: <1434302565-30996-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: Ian Molton <ian.molton@codethink.co.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

The clock should be enable when SDHI registers are accessed.

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on mmc-next branch of Ulf Hansson's mmc tree.

* Perhaps this relates to the need to enhance clock management

 drivers/mmc/host/tmio_mmc_pio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index e3dcf31..ec10bcd 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -1240,7 +1240,9 @@ int tmio_mmc_host_runtime_suspend(struct device *dev)
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
 
+	pm_runtime_get_sync(dev);
 	tmio_mmc_disable_mmc_irqs(host, TMIO_MASK_ALL);
+	pm_runtime_put(dev);
 
 	if (host->clk_cache)
 		tmio_mmc_clk_stop(host);
-- 
1.9.1

