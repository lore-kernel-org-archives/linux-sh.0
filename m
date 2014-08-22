From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 22 Aug 2014 08:38:00 +0000
Subject: [PATCH 03/10 v2 resend] mmc: tmio: clear error IRQ status
Message-Id: <871ts87wd5.wl%kuninori.morimoto.gx@gmail.com>
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

From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

Next card access will be always
error if it didn't clear error status

Tested-by: Nguyen Xuan Nui <nx-nui@jinso.co.jp>
Tested-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/mmc/host/tmio_mmc_pio.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index faf0924..c3b1b4e 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -557,6 +557,9 @@ static void tmio_mmc_card_irq_status(struct tmio_mmc_host *host,
 
 	pr_debug_status(*status);
 	pr_debug_status(*ireg);
+
+	/* Clear the status except the interrupt status */
+	sd_ctrl_write32(host, CTL_STATUS, TMIO_MASK_IRQ);
 }
 
 static bool __tmio_mmc_card_detect_irq(struct tmio_mmc_host *host,
-- 
1.7.9.5

