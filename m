From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Dec 2014 02:28:25 +0000
Subject: [PATCH 4/7] mmc: sh_mobile_sdhi: add new macro for mmc_host to sh_mobile_sdhi
Message-Id: <878ui9ve78.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87egs1ve96.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87egs1ve96.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

getting struct sh_mobile_sdhi from struct mmc_host needs to use
complex container_of(). This patch adds new host_to_priv macro to
get it easily.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 1c1e919..c0ef63b 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -35,6 +35,8 @@
 
 #define EXT_ACC           0xe4
 
+#define host_to_priv(host) container_of((host)->pdata, struct sh_mobile_sdhi, mmc_data)
+
 struct sh_mobile_sdhi_of_data {
 	unsigned long tmio_flags;
 	unsigned long capabilities;
@@ -88,7 +90,7 @@ static int sh_mobile_sdhi_clk_enable(struct platform_device *pdev, unsigned int
 {
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
-	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct sh_mobile_sdhi, mmc_data);
+	struct sh_mobile_sdhi *priv = host_to_priv(host);
 	int ret = clk_prepare_enable(priv->clk);
 	if (ret < 0)
 		return ret;
@@ -101,7 +103,7 @@ static void sh_mobile_sdhi_clk_disable(struct platform_device *pdev)
 {
 	struct mmc_host *mmc = platform_get_drvdata(pdev);
 	struct tmio_mmc_host *host = mmc_priv(mmc);
-	struct sh_mobile_sdhi *priv = container_of(host->pdata, struct sh_mobile_sdhi, mmc_data);
+	struct sh_mobile_sdhi *priv = host_to_priv(host);
 	clk_disable_unprepare(priv->clk);
 }
 
-- 
1.7.9.5

