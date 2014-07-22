From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 22 Jul 2014 05:33:35 +0000
Subject: [PATCH 01/10] mmc: sh_mobile_sdhi: Add EXT_ACC register busy check
Message-Id: <87d2cyhs9e.wl%kuninori.morimoto.gx@renesas.com>
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

From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 91058da..18cf462 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -126,6 +126,7 @@ static int sh_mobile_sdhi_write16_hook(struct tmio_mmc_host *host, int addr)
 	case CTL_SD_MEM_CARD_OPT:
 	case CTL_TRANSACTION_CTL:
 	case CTL_DMA_ENABLE:
+	case EXT_ACC:
 		return sh_mobile_sdhi_wait_idle(host);
 	}
 
-- 
1.7.9.5

