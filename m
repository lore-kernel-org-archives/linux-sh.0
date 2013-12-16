From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 16 Dec 2013 19:25:15 +0000
Subject: [PATCH 2/4] pinctrl: sh-pfc: Constify IRQ GPIOs arrays
Message-Id: <1387221917-15437-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The arrays are never modified, make them const.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/gpio.c   | 2 +-
 drivers/pinctrl/sh-pfc/sh_pfc.h | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/gpio.c b/drivers/pinctrl/sh-pfc/gpio.c
index 6348081..a9288ab 100644
--- a/drivers/pinctrl/sh-pfc/gpio.c
+++ b/drivers/pinctrl/sh-pfc/gpio.c
@@ -207,7 +207,7 @@ static int gpio_pin_to_irq(struct gpio_chip *gc, unsigned offset)
 	unsigned int i, k;
 
 	for (i = 0; i < pfc->info->gpio_irq_size; i++) {
-		short *gpios = pfc->info->gpio_irq[i].gpios;
+		const short *gpios = pfc->info->gpio_irq[i].gpios;
 
 		for (k = 0; gpios[k] >= 0; k++) {
 			if (gpios[k] = offset)
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index cdd0338..25496c4 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -95,11 +95,11 @@ struct pinmux_data_reg {
 
 struct pinmux_irq {
 	int irq;
-	short *gpios;
+	const short *gpios;
 };
 
 #define PINMUX_IRQ(irq_nr, ids...)			   \
-	{ .irq = irq_nr, .gpios = (short []) { ids, -1 } }
+	{ .irq = irq_nr, .gpios = (const short []) { ids, -1 } }
 
 struct pinmux_range {
 	u16 begin;
-- 
1.8.3.2

