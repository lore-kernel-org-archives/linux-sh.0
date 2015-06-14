From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Sun, 14 Jun 2015 17:20:43 +0000
Subject: [PATCH/RFC] mmc: sh_mmcif: Fix suspend process
Message-Id: <1434302443-30905-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sh@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

The clock should be enable when SDHI registers are accessed.

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on mmc-next branch of Ulf Hansson's mmc tree.

* Perhaps this relates to the need to enhance clock management

 drivers/mmc/host/sh_mmcif.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 5a1fdd4..ad9ffea 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1632,7 +1632,9 @@ static int sh_mmcif_suspend(struct device *dev)
 {
 	struct sh_mmcif_host *host = dev_get_drvdata(dev);
 
+	pm_runtime_get_sync(dev);
 	sh_mmcif_writel(host->addr, MMCIF_CE_INT_MASK, MASK_ALL);
+	pm_runtime_put(dev);
 
 	return 0;
 }
-- 
1.9.1

