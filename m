From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Dec 2012 22:53:58 +0000
Subject: [PATCH v4 16/81] sh-pfc: Let the compiler decide whether to inline functions
Message-Id: <1356735303-29474-17-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The compiler should be smart enough to automatically inline static
functions that are called from a single location.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/sh/pfc/pinctrl.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/sh/pfc/pinctrl.c b/drivers/sh/pfc/pinctrl.c
index b3dbefd..47dbd02 100644
--- a/drivers/sh/pfc/pinctrl.c
+++ b/drivers/sh/pfc/pinctrl.c
@@ -116,7 +116,7 @@ static void sh_pfc_noop_disable(struct pinctrl_dev *pctldev, unsigned func,
 {
 }
 
-static inline int sh_pfc_config_function(struct sh_pfc *pfc, unsigned offset)
+static int sh_pfc_config_function(struct sh_pfc *pfc, unsigned offset)
 {
 	if (sh_pfc_config_gpio(pfc, offset,
 			       PINMUX_TYPE_FUNCTION,
@@ -328,10 +328,8 @@ static struct pinctrl_desc sh_pfc_pinctrl_desc = {
 	.confops	= &sh_pfc_pinconf_ops,
 };
 
-static inline void sh_pfc_map_one_gpio(struct sh_pfc *pfc,
-				       struct sh_pfc_pinctrl *pmx,
-				       struct pinmux_gpio *gpio,
-				       unsigned offset)
+static void sh_pfc_map_one_gpio(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx,
+				struct pinmux_gpio *gpio, unsigned offset)
 {
 	struct pinmux_data_reg *dummy;
 	unsigned long flags;
-- 
1.7.8.6

