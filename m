From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 Apr 2013 06:40:57 +0000
Subject: [PATCH 1/3] gpio-rcar: R-Car GPIO IRQ share interrupt
Message-Id: <87ehe8s5my.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

R-Car H1 or Gen2 GPIO interrupts are assigned per each GPIO domain,
but, Gen1 E1/M1 GPIO interrupts are shared for all GPIO domain.
gpio-rcar driver needs IRQF_SHARED flags for these.
This patch was tested on Bock-W board

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/gpio/gpio-rcar.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index b4ca450..0f3d647 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -333,7 +333,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 	}
 
 	if (devm_request_irq(&pdev->dev, irq->start,
-			     gpio_rcar_irq_handler, 0, name, p)) {
+			     gpio_rcar_irq_handler, IRQF_SHARED, name, p)) {
 		dev_err(&pdev->dev, "failed to request IRQ\n");
 		ret = -ENOENT;
 		goto err1;
-- 
1.7.9.5

