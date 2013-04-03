From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 03 Apr 2013 02:04:48 +0000
Subject: [PATCH 10/28] sh-pfc: Make GPIO support optional
Message-Id: <1364954706-14727-11-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1364954706-14727-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1364954706-14727-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

When implemented as a separate IP block, GPIOs should be handled by a
separate driver. To make this possible GPIO support needs to be optional
in the sh-pfc driver.

If no GPIO data registers are supplied in the SoC information structure
skip registration of the gpiochip.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/pinctrl/sh-pfc/gpio.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index 7a54ec7..317cebb 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -354,6 +354,9 @@ int sh_pfc_register_gpiochip(struct sh_pfc *pfc)
 	unsigned int i;
 	int ret;
 
+	if (pfc->info->data_regs = NULL)
+		return 0;
+
 	/* Register the real GPIOs chip. */
 	chip = sh_pfc_add_gpiochip(pfc, gpio_pin_setup);
 	if (IS_ERR(chip))
-- 
1.7.10.4

