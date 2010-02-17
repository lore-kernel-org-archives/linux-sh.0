From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Feb 2010 07:37:55 +0000
Subject: [PATCH 02/05] tmio_mmc: Add MMC_CAP_MMC_HIGHSPEED support V2
Message-Id: <20100217073755.32726.32930.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
References: <20100217073735.32726.12020.sendpatchset@t400s>
In-Reply-To: <20100217073735.32726.12020.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: sameo@linux.intel.com, linux-sh@vger.kernel.org, linus.ml.walleij@gmail.com, g.liakhovetski@gmx.de, goda.yusuke@renesas.com, ian@mnementh.co.uk, lethal@linux-sh.org, akpm@linux-foundation.org, Magnus Damm <magnus.damm@gmail.com>

From: Yusuke Goda <goda.yusuke@renesas.com>

Enable MMC_CAP_XX support in the tmio_mmc driver if
pdata->capabilities is set.

Signed-off-by: Yusuke Goda <goda.yusuke@renesas.com>
Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Previously posted by Goda-san to linux-mmc 20100216 as
 "[PATCH v2] tmio_mmc: Add MMC_CAP_MMC_HIGHSPEED support"

 drivers/mmc/host/tmio_mmc.c |    1 +
 include/linux/mfd/tmio.h    |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.c
index e22c3fa..e2c0cc9 100644
--- a/drivers/mmc/host/tmio_mmc.c
+++ b/drivers/mmc/host/tmio_mmc.c
@@ -550,6 +550,7 @@ static int __devinit tmio_mmc_probe(struct platform_device *dev)

 	mmc->ops = &tmio_mmc_ops;
 	mmc->caps = MMC_CAP_4_BIT_DATA;
+	mmc->caps |= pdata->capabilities;
 	mmc->f_max = pdata->hclk;
 	mmc->f_min = mmc->f_max / 512;
 	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 9cb1834..37d9414 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -60,6 +60,7 @@ void tmio_core_mmc_clk_div(void __iomem *cnf, int shift, int state);
  */
 struct tmio_mmc_data {
 	const unsigned int		hclk;
+	unsigned long			capabilities;
 	void (*set_pwr)(struct platform_device *host, int state);
 	void (*set_clk_div)(struct platform_device *host, int state);
 };
-- 
1.6.4.3



