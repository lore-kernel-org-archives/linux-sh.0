From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 31 Jan 2014 05:32:03 +0000
Subject: [PATCH 3/4] mmc: SDHI: update sh_mobile_sdhi_of_data for r8a7779
Message-Id: <878utw7m3z.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lhy090m0.wl%kuninori.morimoto.gx@gmail.com>
	<87d2j87m6u.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87d2j87m6u.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>
Cc: Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This patch updates r8a7779 DT data to have SoC specific settings.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 6442286..322cd35 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -58,7 +58,7 @@ static const struct of_device_id sh_mobile_sdhi_of_match[] = {
 	{ .compatible = "renesas,sdhi-r8a73a4", .data = &sh_mobile_sdhi_of_cfg[0], },
 	{ .compatible = "renesas,sdhi-r8a7740", .data = &sh_mobile_sdhi_of_cfg[0], },
 	{ .compatible = "renesas,sdhi-r8a7778", .data = &of_rcar_gen1_compatible, },
-	{ .compatible = "renesas,sdhi-r8a7779", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,sdhi-r8a7779", .data = &of_rcar_gen1_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7790", .data = &sh_mobile_sdhi_of_cfg[0], },
 	{},
 };
-- 
1.7.9.5

