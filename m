From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 25 Jul 2013 23:26:47 +0000
Subject: [PATCH 11/12] mmc: tmio-mmc: Remove .get_cd() callback from platform data
Message-Id: <1374794808-21890-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1374794808-21890-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1374794808-21890-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

All platforms pass the CD GPIO number to the driver in the .cd_gpio
field. The .get_cd() callback isn't used anymore, remove it

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 16 +---------------
 include/linux/mfd/tmio.h        |  1 -
 2 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index b72edb7..a335fb8 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -932,25 +932,11 @@ static int tmio_mmc_get_ro(struct mmc_host *mmc)
 		 (sd_ctrl_read32(host, CTL_STATUS) & TMIO_STAT_WRPROTECT));
 }
 
-static int tmio_mmc_get_cd(struct mmc_host *mmc)
-{
-	struct tmio_mmc_host *host = mmc_priv(mmc);
-	struct tmio_mmc_data *pdata = host->pdata;
-	int ret = mmc_gpio_get_cd(mmc);
-	if (ret >= 0)
-		return ret;
-
-	if (!pdata->get_cd)
-		return -ENOSYS;
-	else
-		return pdata->get_cd(host->pdev);
-}
-
 static const struct mmc_host_ops tmio_mmc_ops = {
 	.request	= tmio_mmc_request,
 	.set_ios	= tmio_mmc_set_ios,
 	.get_ro         = tmio_mmc_get_ro,
-	.get_cd		= tmio_mmc_get_cd,
+	.get_cd		= mmc_gpio_get_cd,
 	.enable_sdio_irq = tmio_mmc_enable_sdio_irq,
 };
 
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index ce35113..b22883d 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -108,7 +108,6 @@ struct tmio_mmc_data {
 	unsigned int			cd_gpio;
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
-	int (*get_cd)(struct platform_device *host);
 	int (*write16_hook)(struct tmio_mmc_host *host, int addr);
 	/* clock management callbacks */
 	int (*clk_enable)(struct platform_device *pdev, unsigned int *f);
-- 
1.8.1.5

