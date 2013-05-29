From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Wed, 29 May 2013 08:48:56 +0000
Subject: [PATCH] thermal: rcar: set up I/O base before requesting IRQ
Message-Id: <1369817336-1953-1-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It is used by the interrupt handler. Fixes crash when booting via kexec
on APE6 board.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/thermal/rcar_thermal.c |   14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 8d7edd4..7641dcc 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -395,13 +395,6 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 			return -ENODEV;
 		}
 
-		ret = devm_request_irq(dev, irq->start, rcar_thermal_irq, 0,
-				       dev_name(dev), common);
-		if (ret) {
-			dev_err(dev, "irq request failed\n ");
-			return ret;
-		}
-
 		/*
 		 * rcar_has_irq_support() will be enabled
 		 */
@@ -409,6 +402,13 @@ static int rcar_thermal_probe(struct platform_device *pdev)
 		if (IS_ERR(common->base))
 			return PTR_ERR(common->base);
 
+		ret = devm_request_irq(dev, irq->start, rcar_thermal_irq, 0,
+				       dev_name(dev), common);
+		if (ret) {
+			dev_err(dev, "irq request failed\n ");
+			return ret;
+		}
+
 		/* enable temperature comparation */
 		rcar_thermal_common_write(common, ENR, 0x00030303);
 
-- 
1.7.10.4

