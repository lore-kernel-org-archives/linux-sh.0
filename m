From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 10 Mar 2013 18:58:41 +0000
Subject: [PATCH/RFC 05/12] sh-pfc: Make GPIO support optional
Message-Id: <1362941928-18115-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When implemented as a separate IP block, GPIOs should be handled by a
separate driver. To make this possible GPIO support needs to be optional
in the sh-pfc driver.

If no GPIO data registers are supplied in the SoC information structure
skip registration of the gpiochip.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/gpio.c | 3 +++
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
1.8.1.5

