From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 06 Feb 2013 19:46:52 +0000
Subject: [PATCH v3 05/13] mmc: sh-mmcif: use mmc_of_parse() to parse standard MMC DT bindings
Message-Id: <1360180020-18555-6-git-send-email-g.liakhovetski@gmx.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Arnd Bergmann <arnd@arndb.de>

Use mmc_of_parse() to get interface capability flags and used GPIOs from
device-tree bindings.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v3: updated on top of "mmc: sh_mmcif: Avoid unnecessary mmc_delay() at
    mmc_card_sleepawake()"

 drivers/mmc/host/sh_mmcif.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 7d05852..adb4f68 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1331,6 +1331,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 		ret = -ENOMEM;
 		goto ealloch;
 	}
+	mmc_of_parse(mmc);
 	host		= mmc_priv(mmc);
 	host->mmc	= mmc;
 	host->addr	= reg;
@@ -1343,7 +1344,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	mmc->ops = &sh_mmcif_ops;
 	sh_mmcif_init_ocr(host);
 
-	mmc->caps = MMC_CAP_MMC_HIGHSPEED | MMC_CAP_WAIT_WHILE_BUSY;
+	mmc->caps |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_WAIT_WHILE_BUSY;
 	if (pd && pd->caps)
 		mmc->caps |= pd->caps;
 	mmc->max_segs = 32;
-- 
1.7.2.5

