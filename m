From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 25 Jan 2016 19:15:15 +0000
Subject: [PATCH 8/9] mmc: tmio: disable clock before changing it
Message-Id: <1453749316-1848-9-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1453749316-1848-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Dirk Behme <dirk.behme@gmail.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

Rcar2 & 3 docs state that for going to and coming from the 0xff setting,
the clock must first be disabled before the DIV bits are changed.
Instead of tracking this, let's just do this unconditionally.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/tmio_mmc_pio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 7f6b5adf12094b..03f6e74c190691 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -174,6 +174,8 @@ static void tmio_mmc_set_clock(struct tmio_mmc_host *host,
 	if (host->set_clk_div)
 		host->set_clk_div(host->pdev, (clk >> 22) & 1);
 
+	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, ~CLK_CTL_SCLKEN &
+			sd_ctrl_read16(host, CTL_SD_CARD_CLK_CTL));
 	sd_ctrl_write16(host, CTL_SD_CARD_CLK_CTL, clk & CLK_CTL_DIV_MASK);
 	if (!(host->pdata->flags & TMIO_MMC_FAST_CLK_CHG))
 		msleep(10);
-- 
2.1.4

