From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Dec 2014 02:28:15 +0000
Subject: [PATCH 3/7] mmc: sh_mobile_sdhi: tidyup mmc_data->bus_shift for latest SoC
Message-Id: <87a92pve7i.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87egs1ve96.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87egs1ve96.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <cjb@laptop.org>
Cc: Simon <horms@verge.net.au>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Latest SDHI on Renesas has expand register mapping.
update mmc_data->bus_shift for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 00c8ebd..1c1e919 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -272,7 +272,10 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 	}
 
 	/* SD control register space size is 0x100, 0x200 for bus_shift=1 */
-	mmc_data->bus_shift = resource_size(res) >> 9;
+	if (resource_size(res) > 0x100)
+		mmc_data->bus_shift = 1;
+	else
+		mmc_data->bus_shift = 0;
 
 	ret = tmio_mmc_host_probe(&host, pdev, mmc_data);
 	if (ret < 0)
-- 
1.7.9.5

