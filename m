From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 03 Apr 2013 02:04:47 +0000
Subject: [PATCH 09/28] sh-pfc: Make function GPIOs support optional
Message-Id: <1364954706-14727-10-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1364954706-14727-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1364954706-14727-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The target is to get rid of function GPIOs completely. To reach this,
make function GPIOs support optional by skipping the function GPIO chip
registration if no function GPIOS are defined in SoC data.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/gpio.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index d7acb06..7a54ec7 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -384,6 +384,9 @@ int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
 	}
 
 	/* Register the function GPIOs chip. */
+	if (pfc->info->nr_func_gpios = 0)
+		return 0;
+
 	chip = sh_pfc_add_gpiochip(pfc, gpio_function_setup);
 	if (IS_ERR(chip))
 		return PTR_ERR(chip);
-- 
1.7.10.4

