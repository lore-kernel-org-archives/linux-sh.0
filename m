From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 22 Aug 2014 08:41:11 +0000
Subject: [PATCH 09/10 v2 resend] mmc: tmio: ensure that the clock has been stopped before set_clock
Message-Id: <87siko6hne.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <d3d6aa34548248768494ad88056cf4bd@SINPR06MB105.apcprd06.prod.outlook.com>
	<87simtenpi.wl%kuninori.morimoto.gx@renesas.com>
	<cb608c5e763f47b597936724ec05b615@SINPR06MB105.apcprd06.prod.outlook.com>
	<87pphxe2q0.wl%kuninori.morimoto.gx@renesas.com>
	<53AD638C.5060907@renesas.com>
	<87egxehsec.wl%kuninori.morimoto.gx@gmail.com>
	<8761hk7wgy.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <8761hk7wgy.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>
Cc: Ian Molton <ian@mnementh.co.uk>, Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch ensures that the clock has been stopped before
it calls tmio_mmc_set_clock().
The clock settings might be failed without this patch

Tested-by: Nguyen Xuan Nui <nx-nui@jinso.co.jp>
Tested-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/mmc/host/tmio_mmc_pio.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index da3c74d..1c5a631 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -895,6 +895,7 @@ static void tmio_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		}
 		if (host->power = TMIO_MMC_OFF_STOP)
 			tmio_mmc_reset(host);
+		tmio_mmc_clk_stop(host);
 		tmio_mmc_set_clock(host, ios->clock);
 		if (host->power = TMIO_MMC_OFF_STOP)
 			/* power up SD card and the bus */
-- 
1.7.9.5

