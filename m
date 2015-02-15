From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Date: Sun, 15 Feb 2015 15:46:22 +0000
Subject: [PATCH/RFC] gpio: rcar: Add clock support
Message-Id: <1424015182-20447-1-git-send-email-ykaneko0929@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-gpio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

The clock of GPIO is an initial value of enable. However,
since correction which sets the clock to disable was added
by the boot loader, the clock control was added.

Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on for-next branch of Linus Walleij's gpio tree.

 drivers/gpio/gpio-rcar.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
index c49522e..6d4a0bc 100644
--- a/drivers/gpio/gpio-rcar.c
+++ b/drivers/gpio/gpio-rcar.c
@@ -14,6 +14,7 @@
  * GNU General Public License for more details.
  */
 
+#include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/init.h>
@@ -37,6 +38,7 @@ struct gpio_rcar_priv {
 	struct platform_device *pdev;
 	struct gpio_chip gpio_chip;
 	struct irq_chip irq_chip;
+	struct clk *clk;
 };
 
 #define IOINTSEL 0x00
@@ -367,6 +369,13 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, p);
 
+	p->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(p->clk)) {
+		dev_err(&pdev->dev, "failed to get access to GPIO clock\n");
+		return PTR_ERR(p->clk);
+	}
+	clk_prepare_enable(p->clk);
+
 	pm_runtime_enable(dev);
 	pm_runtime_get_sync(dev);
 
@@ -449,6 +458,7 @@ static int gpio_rcar_probe(struct platform_device *pdev)
 err1:
 	gpiochip_remove(&p->gpio_chip);
 err0:
+	clk_disable_unprepare(p->clk);
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
 	return ret;
@@ -460,6 +470,7 @@ static int gpio_rcar_remove(struct platform_device *pdev)
 
 	gpiochip_remove(&p->gpio_chip);
 
+	clk_disable_unprepare(p->clk);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	return 0;
-- 
1.9.1

