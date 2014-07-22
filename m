From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 Jul 2014 05:34:58 +0000
Subject: [PATCH 08/10] mmc: tmio: remove Renesas specific #ifdef
Message-Id: <8738duhs74.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <d3d6aa34548248768494ad88056cf4bd@SINPR06MB105.apcprd06.prod.outlook.com>
	<87simtenpi.wl%kuninori.morimoto.gx@renesas.com>
	<cb608c5e763f47b597936724ec05b615@SINPR06MB105.apcprd06.prod.outlook.com>
	<87pphxe2q0.wl%kuninori.morimoto.gx@renesas.com>
	<53AD638C.5060907@renesas.com>
	<87egxehsec.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87egxehsec.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>
Cc: TOSHIAKI KOMATSU <toshiaki.komatsu.ud@renesas.com>, NAOYA SHIIBA <naoya.shiiba.nx@renesas.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, "goda (Renesas)" <yusuke.goda.sx@renesas.com>, linux-mmc@vger.kernel.org, ryo.kataoka.wt@renesas.com, shinobu.uehara.xc@renesas.com, kouei.abe.cp@renesas.com

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch adds new TMIO_MMC_HAVE_CTL_DMA_REG flag,
and remove Renesas specific #ifdef from tmio driver

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    5 +++++
 drivers/mmc/host/tmio_mmc_dma.c   |    6 ++----
 include/linux/mfd/tmio.h          |    5 +++++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 8b3c6cd..b16f1bb 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -236,6 +236,11 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	 */
 	mmc_data->flags |= TMIO_MMC_SDIO_STATUS_QUIRK;
 
+	/*
+	 * All SDHI have DMA control register
+	 */
+	mmc_data->flags |= TMIO_MMC_HAVE_CTL_DMA_REG;
+
 	if (of_id && of_id->data) {
 		const struct sh_mobile_sdhi_of_data *of_data = of_id->data;
 		mmc_data->flags |= of_data->tmio_flags;
diff --git a/drivers/mmc/host/tmio_mmc_dma.c b/drivers/mmc/host/tmio_mmc_dma.c
index 1925170..8b1121e 100644
--- a/drivers/mmc/host/tmio_mmc_dma.c
+++ b/drivers/mmc/host/tmio_mmc_dma.c
@@ -28,10 +28,8 @@ void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool enable)
 	if (!host->chan_tx || !host->chan_rx)
 		return;
 
-#if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
-	/* Switch DMA mode on or off - SuperH specific? */
-	sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? 2 : 0);
-#endif
+	if (host->pdata->flags & TMIO_MMC_HAVE_CTL_DMA_REG)
+		sd_ctrl_write16(host, CTL_DMA_ENABLE, enable ? 2 : 0);
 }
 
 void tmio_mmc_abort_dma(struct tmio_mmc_host *host)
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index a7493ae..adcb0cd 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -94,6 +94,11 @@
  */
 #define TMIO_MMC_SDIO_STATUS_QUIRK	(1 << 8)
 
+/*
+ * Some controllers have DMA enable/disable register
+ */
+#define TMIO_MMC_HAVE_CTL_DMA_REG	(1 << 9)
+
 int tmio_core_mmc_enable(void __iomem *cnf, int shift, unsigned long base);
 int tmio_core_mmc_resume(void __iomem *cnf, int shift, unsigned long base);
 void tmio_core_mmc_pwr(void __iomem *cnf, int shift, int state);
-- 
1.7.9.5

