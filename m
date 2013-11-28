From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 28 Nov 2013 01:39:43 +0000
Subject: [PATCH 2/2] spi: sh-msiof: Convert to clk_prepare/unprepare
Message-Id: <1385602783-3439-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1385602783-3439-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385602783-3439-1-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Get the driver ready for the migration to the common clock framework by
calling clk_prepare() and clk_unprepare(). The calls are added in the
probe and remove handlers as the clk_enable() and clk_disable() calls
are located in atomic context and there's no callback function in
non-atomic context that can be used to prepare/unprepare the clock.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/spi/spi-sh-msiof.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 541e1ec..fbbe949 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -682,6 +682,12 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
+	ret = clk_prepare(p->clk);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "unable to prepare clock\n");
+		goto err1;
+	}
+
 	p->pdev = pdev;
 	pm_runtime_enable(&pdev->dev);
 
@@ -718,6 +724,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 		return 0;
 
 	pm_runtime_disable(&pdev->dev);
+	clk_unprepare(p->clk);
  err1:
 	spi_master_put(master);
 	return ret;
@@ -731,6 +738,7 @@ static int sh_msiof_spi_remove(struct platform_device *pdev)
 	ret = spi_bitbang_stop(&p->bitbang);
 	if (!ret) {
 		pm_runtime_disable(&pdev->dev);
+		clk_unprepare(p->clk);
 		spi_master_put(p->bitbang.master);
 	}
 	return ret;
-- 
1.8.3.2

