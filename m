From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Mon, 16 Dec 2013 04:49:22 +0000
Subject: [PATCH 1/6][RFC] mmc: SDHI: tidyup sh_mobile_sdhi_of_match position
Message-Id: <878uvl1ju9.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

it is easy to read if sh_mobile_sdhi_of_cfg and
sh_mobile_sdhi_of_match are closer

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 2d6ce25..8901acd 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -45,6 +45,19 @@ static const struct sh_mobile_sdhi_of_data sh_mobile_sdhi_of_cfg[] = {
 	},
 };
 
+static const struct of_device_id sh_mobile_sdhi_of_match[] = {
+	{ .compatible = "renesas,sdhi-shmobile" },
+	{ .compatible = "renesas,sdhi-sh7372" },
+	{ .compatible = "renesas,sdhi-sh73a0", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,sdhi-r8a73a4", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,sdhi-r8a7740", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,sdhi-r8a7778", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,sdhi-r8a7779", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{ .compatible = "renesas,sdhi-r8a7790", .data = &sh_mobile_sdhi_of_cfg[0], },
+	{},
+};
+MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
+
 struct sh_mobile_sdhi {
 	struct clk *clk;
 	struct tmio_mmc_data mmc_data;
@@ -114,19 +127,6 @@ static const struct sh_mobile_sdhi_ops sdhi_ops = {
 	.cd_wakeup = sh_mobile_sdhi_cd_wakeup,
 };
 
-static const struct of_device_id sh_mobile_sdhi_of_match[] = {
-	{ .compatible = "renesas,sdhi-shmobile" },
-	{ .compatible = "renesas,sdhi-sh7372" },
-	{ .compatible = "renesas,sdhi-sh73a0", .data = &sh_mobile_sdhi_of_cfg[0], },
-	{ .compatible = "renesas,sdhi-r8a73a4", .data = &sh_mobile_sdhi_of_cfg[0], },
-	{ .compatible = "renesas,sdhi-r8a7740", .data = &sh_mobile_sdhi_of_cfg[0], },
-	{ .compatible = "renesas,sdhi-r8a7778", .data = &sh_mobile_sdhi_of_cfg[0], },
-	{ .compatible = "renesas,sdhi-r8a7779", .data = &sh_mobile_sdhi_of_cfg[0], },
-	{ .compatible = "renesas,sdhi-r8a7790", .data = &sh_mobile_sdhi_of_cfg[0], },
-	{},
-};
-MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
-
 static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *of_id -- 
1.7.9.5

