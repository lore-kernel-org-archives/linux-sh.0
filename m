From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 25 Aug 2014 03:02:16 +0000
Subject: [PATCH 7/9 v3] mmc: tmio: remove SCLKEN bit setting from tmio_mmc_set_clock()
Message-Id: <871ts5tgp6.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <d3d6aa34548248768494ad88056cf4bd@SINPR06MB105.apcprd06.prod.outlook.com>
	<87simtenpi.wl%kuninori.morimoto.gx@renesas.com>
	<cb608c5e763f47b597936724ec05b615@SINPR06MB105.apcprd06.prod.outlook.com>
	<87pphxe2q0.wl%kuninori.morimoto.gx@renesas.com>
	<53AD638C.5060907@renesas.com>
	<87egxehsec.wl%kuninori.morimoto.gx@gmail.com>
	<87bnr9tgwj.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87bnr9tgwj.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ian Molton <ian@mnementh.co.uk>, Morimoto <kuninori.morimoto.gx@renesas.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

TMIO clock is set via tmio_mmc_set_clock() -> tmio_mmc_clk_start(),
and SCLKEN bit will be set on tmio_mmc_clk_start().
It is not needed on tmio_mmc_set_clock() function.
The required clock setting will not be able to set
in some clocks without this patch.

Tested-by: Nguyen Xuan Nui <nx-nui@jinso.co.jp>
Tested-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
v2 -> v3

 - no change

 drivers/mmc/host/tmio_mmc_pio.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index b19d0cd..da3c74d 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -150,7 +150,6 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host, int new_clock)
 		for (clock = host->mmc->f_min, clk = 0x80000080;
 			new_clock >= (clock<<1); clk >>= 1)
 			clock <<= 1;
-		clk |= 0x100;
 	}
 
 	if (host->set_clk_div)
-- 
1.7.9.5

