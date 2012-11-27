From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 27 Nov 2012 00:02:06 +0000
Subject: [PATCH v2 07/77] sh-pfc: Remove check for impossible error condition
Message-Id: <1353974596-30033-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The pfc pointer can't be NULL in the get and set value functions, remove
the error check.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>
---
 drivers/sh/pfc/gpio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sh/pfc/gpio.c b/drivers/sh/pfc/gpio.c
index f22d43a..0a85159 100644
--- a/drivers/sh/pfc/gpio.c
+++ b/drivers/sh/pfc/gpio.c
@@ -51,7 +51,7 @@ static void sh_gpio_set_value(struct sh_pfc *pfc, unsigned gpio, int value)
 	struct pinmux_data_reg *dr = NULL;
 	int bit = 0;
 
-	if (!pfc || sh_pfc_get_data_reg(pfc, gpio, &dr, &bit) != 0)
+	if (sh_pfc_get_data_reg(pfc, gpio, &dr, &bit) != 0)
 		BUG();
 	else
 		sh_pfc_write_bit(dr, bit, value);
@@ -62,7 +62,7 @@ static int sh_gpio_get_value(struct sh_pfc *pfc, unsigned gpio)
 	struct pinmux_data_reg *dr = NULL;
 	int bit = 0;
 
-	if (!pfc || sh_pfc_get_data_reg(pfc, gpio, &dr, &bit) != 0)
+	if (sh_pfc_get_data_reg(pfc, gpio, &dr, &bit) != 0)
 		return -EINVAL;
 
 	return sh_pfc_read_bit(dr, bit);
-- 
1.7.8.6

