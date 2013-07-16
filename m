From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 16 Jul 2013 00:11:06 +0000
Subject: [PATCH v2 14/27] sh-pfc: Don't overallocate memory for the GPIO chip pins array
Message-Id: <1373933479-17727-15-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The GPIO driver uses an array of sh_pfc_gpio_pin structures to store
per-GPIO pin data. The array size is miscomputed at allocation time by
using the number of the last pin instead of the number of pins. When the
pin space contains holes this leads to memory overallocation. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index d37efa7..3620bd8 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -224,8 +224,8 @@ static int gpio_pin_setup(struct sh_pfc_chip *chip)
 	struct gpio_chip *gc = &chip->gpio_chip;
 	int ret;
 
-	chip->pins = devm_kzalloc(pfc->dev, pfc->nr_pins * sizeof(*chip->pins),
-				  GFP_KERNEL);
+	chip->pins = devm_kzalloc(pfc->dev, pfc->info->nr_pins *
+				  sizeof(*chip->pins), GFP_KERNEL);
 	if (chip->pins = NULL)
 		return -ENOMEM;
 
-- 
1.8.1.5

