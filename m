From: Wolfram Sang <wsa@the-dreams.de>
Date: Tue, 19 Jan 2016 16:20:57 +0000
Subject: [RFC 2/6] mmc: sdhi: error message on ENOMEM is superfluous
Message-Id: <1453220461-2598-3-git-send-email-wsa@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

We will get a full dump anyhow.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/host/sh_mobile_sdhi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
index 61671f3fa09a11..5a10fb3c01a1dd 100644
--- a/drivers/mmc/host/sh_mobile_sdhi.c
+++ b/drivers/mmc/host/sh_mobile_sdhi.c
@@ -214,10 +214,8 @@ static int sh_mobile_sdhi_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(struct sh_mobile_sdhi), GFP_KERNEL);
-	if (priv = NULL) {
-		dev_err(&pdev->dev, "kzalloc failed\n");
+	if (!priv)
 		return -ENOMEM;
-	}
 
 	mmc_data = &priv->mmc_data;
 	dma_priv = &priv->dma_priv;
-- 
2.1.4

