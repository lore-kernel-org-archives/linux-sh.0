From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 03 Jan 2013 18:17:39 +0000
Subject: [PATCH 08/22] sh-pfc: Initialize pinmux_gpio flags statically
Message-Id: <1357237073-15600-9-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All function GPIO entries are initialized with the GPIO_FN macro that
expands to the PINMUX_GPIO macro, used to initialize real GPIOs. Create
a PINMUX_GPIO_FN macro that duplicates PINMUX_GPIO and sets flags to
PINMUX_TYPE_FUNCTION and use it in GPIO_FN, and make PINMUX_GPIO set
flags to PINMUX_TYPE_GPIO.

This removes the need to initialize GPIO flags at runtime and thus
simplifies the code, preparing for the GPIO and functions split.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pinctrl.c |   19 ++-----------------
 drivers/pinctrl/sh-pfc/sh_pfc.h  |   16 +++++++++++++---
 2 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 33ac4f7..8a13dff 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -325,22 +325,6 @@ static struct pinctrl_desc sh_pfc_pinctrl_desc = {
 	.confops	= &sh_pfc_pinconf_ops,
 };
 
-static void sh_pfc_map_one_gpio(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx,
-				struct pinmux_gpio *gpio, unsigned offset)
-{
-	struct pinmux_data_reg *dummy;
-	int bit;
-
-	gpio->flags &= ~PINMUX_FLAG_TYPE;
-
-	if (sh_pfc_get_data_reg(pfc, offset, &dummy, &bit) = 0)
-		gpio->flags |= PINMUX_TYPE_GPIO;
-	else {
-		gpio->flags |= PINMUX_TYPE_FUNCTION;
-		pmx->nr_functions++;
-	}
-}
-
 /* pinmux ranges -> pinctrl pin descs */
 static int sh_pfc_map_gpios(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 {
@@ -366,7 +350,8 @@ static int sh_pfc_map_gpios(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 		if (unlikely(!gpio->enum_id))
 			continue;
 
-		sh_pfc_map_one_gpio(pfc, pmx, gpio, i);
+		if ((gpio->flags & PINMUX_FLAG_TYPE) = PINMUX_TYPE_FUNCTION)
+			pmx->nr_functions++;
 	}
 
 	sh_pfc_pinctrl_desc.pins = pmx->pads;
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 2627a89..e150395 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -41,8 +41,18 @@ struct pinmux_gpio {
 	const char *name;
 };
 
-#define PINMUX_GPIO(gpio, data_or_mark) \
-	[gpio] = { .name = __stringify(gpio), .enum_id = data_or_mark, .flags = PINMUX_TYPE_NONE }
+#define PINMUX_GPIO(gpio, data_or_mark)			\
+	[gpio] = {					\
+		.name = __stringify(gpio),		\
+		.enum_id = data_or_mark,		\
+		.flags = PINMUX_TYPE_GPIO		\
+	}
+#define PINMUX_GPIO_FN(gpio, data_or_mark)		\
+	[gpio] = {					\
+		.name = __stringify(gpio),		\
+		.enum_id = data_or_mark,		\
+		.flags = PINMUX_TYPE_FUNCTION		\
+	}
 
 #define PINMUX_DATA(data_or_mark, ids...) data_or_mark, ids, 0
 
@@ -135,7 +145,7 @@ enum { GPIO_CFG_DRYRUN, GPIO_CFG_REQ, GPIO_CFG_FREE };
 #define _GPIO_PORT(pfx, sfx) PINMUX_GPIO(GPIO_PORT##pfx, PORT##pfx##_DATA)
 #define PORT_ALL(str)	CPU_ALL_PORT(_PORT_ALL, PORT, str)
 #define GPIO_PORT_ALL()	CPU_ALL_PORT(_GPIO_PORT, , unused)
-#define GPIO_FN(str) PINMUX_GPIO(GPIO_FN_##str, str##_MARK)
+#define GPIO_FN(str) PINMUX_GPIO_FN(GPIO_FN_##str, str##_MARK)
 
 /* helper macro for pinmux_enum_t */
 #define PORT_DATA_I(nr)	\
-- 
1.7.8.6

