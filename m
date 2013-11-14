From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 14 Nov 2013 10:23:23 +0000
Subject: [PATCH 03/17] mmc: tmio: Fix odd size access
Message-Id: <87fvqzz3hk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com>
	<87habfz3kd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87habfz3kd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chris Ball <cjb@laptop.org>
Cc: Simon <horms@verge.net.au>, Laurent <laurent.pinchart@ideasonboard.com>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org

From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>

Current sd_ctrl_read/write16_rep() doesn't care odd size

Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/mmc/host/tmio_mmc_pio.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index b380225..05ae15c 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -386,9 +386,11 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host *host)
 
 	/* Transfer the data */
 	if (data->flags & MMC_DATA_READ)
-		sd_ctrl_read16_rep(host, CTL_SD_DATA_PORT, buf, count >> 1);
+		sd_ctrl_read16_rep(host,
+			CTL_SD_DATA_PORT, buf, (count + 1) >> 1);
 	else
-		sd_ctrl_write16_rep(host, CTL_SD_DATA_PORT, buf, count >> 1);
+		sd_ctrl_write16_rep(host,
+			CTL_SD_DATA_PORT, buf, (count + 1) >> 1);
 
 	host->sg_off += count;
 
-- 
1.7.9.5

