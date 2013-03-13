From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Mar 2013 23:00:03 +0000
Subject: [PATCH v4 58/88] sh-pfc: sh73a0: Remove USB function GPIOS
Message-Id: <1363215633-4264-59-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All sh73a0 platforms now use the pinctrl API to control the USB pins,
the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
index 7b010b6..273345c 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh73a0.c
@@ -2936,11 +2936,10 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(usb),
 };
 
-#define PINMUX_FN_BASE	GPIO_FN_VBUS_0
+#define PINMUX_FN_BASE	GPIO_FN_GPI0
 
 static const struct pinmux_func pinmux_func_gpios[] = {
 	/* Table 25-1 (Functions 0-7) */
-	GPIO_FN(VBUS_0),
 	GPIO_FN(GPI0),
 	GPIO_FN(GPI1),
 	GPIO_FN(GPI2),
-- 
1.8.1.5

