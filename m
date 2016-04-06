From: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 06 Apr 2016 09:25:29 +0000
Subject: [PATCH 1/6] mmc: sh_mobile_sdhi: don't use array for DT configs
Message-Id: <1459934734-3613-2-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1459934734-3613-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1459934734-3613-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Simon Horman <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We won't access an index based array to get our DT config, but create
seperate structs instead. So, remove the array which only wastes memory.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index cf10f8cca9ee2d..9beee48d2e280d 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -51,10 +51,8 @@ struct sh_mobile_sdhi_of_data {
 	unsigned bus_shift;
 };
 
-static const struct sh_mobile_sdhi_of_data sh_mobile_sdhi_of_cfg[] = {
-	{
-		.tmio_flags = TMIO_MMC_HAS_IDLE_WAIT,
-	},
+static const struct sh_mobile_sdhi_of_data of_default_cfg = {
+	.tmio_flags = TMIO_MMC_HAS_IDLE_WAIT,
 };
 
 static const struct sh_mobile_sdhi_of_data of_rcar_gen1_compatible = {
@@ -81,9 +79,9 @@ static const struct sh_mobile_sdhi_of_data of_rcar_gen3_compatible = {
 static const struct of_device_id sh_mobile_sdhi_of_match[] = {
 	{ .compatible = "renesas,sdhi-shmobile" },
 	{ .compatible = "renesas,sdhi-sh7372" },
-	{ .compatible = "renesas,sdhi-sh73a0", .data = &sh_mobile_sdhi_of_cfg[0], },
-	{ .compatible = "renesas,sdhi-r8a73a4", .data = &sh_mobile_sdhi_of_cfg[0], },
-	{ .compatible = "renesas,sdhi-r8a7740", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,sdhi-sh73a0", .data = &of_default_cfg, },
+	{ .compatible = "renesas,sdhi-r8a73a4", .data = &of_default_cfg, },
+	{ .compatible = "renesas,sdhi-r8a7740", .data = &of_default_cfg, },
 	{ .compatible = "renesas,sdhi-r8a7778", .data = &of_rcar_gen1_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7779", .data = &of_rcar_gen1_compatible, },
 	{ .compatible = "renesas,sdhi-r8a7790", .data = &of_rcar_gen2_compatible, },
-- 
2.7.0

