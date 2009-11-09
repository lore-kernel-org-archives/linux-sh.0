From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Mon, 09 Nov 2009 02:42:47 +0000
Subject: [PATCH] uio: pm_runtime_disable is needed if failed
Message-Id: <ufx8oju54.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
>> Magnus

Please check this patch.
I think pm_runtime_disable is needed here.

 drivers/uio/uio_pdrv_genirq.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/uio/uio_pdrv_genirq.c b/drivers/uio/uio_pdrv_genirq.c
index 02347c5..aa53db9 100644
--- a/drivers/uio/uio_pdrv_genirq.c
+++ b/drivers/uio/uio_pdrv_genirq.c
@@ -178,6 +178,7 @@ static int uio_pdrv_genirq_probe(struct platform_device *pdev)
 	return 0;
  bad1:
 	kfree(priv);
+	pm_runtime_disable(&pdev->dev);
  bad0:
 	return ret;
 }
-- 
1.6.3.3

