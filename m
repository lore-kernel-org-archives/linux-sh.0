From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 21 Nov 2012 02:53:22 +0000
Subject: [PATCH 06/42] sh-pfc: Let the compiler decide whether to inline functions
Message-Id: <1353466438-10929-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The compiler should be smart enough to automatically inline static
functions that are called from a single location.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/sh/pfc/pinctrl.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/sh/pfc/pinctrl.c b/drivers/sh/pfc/pinctrl.c
index 1c93e3c..21b8678 100644
--- a/drivers/sh/pfc/pinctrl.c
+++ b/drivers/sh/pfc/pinctrl.c
@@ -115,7 +115,7 @@ static void sh_pfc_noop_disable(struct pinctrl_dev *pctldev, unsigned func,
 {
 }
 
-static inline int sh_pfc_config_function(struct sh_pfc *pfc, unsigned offset)
+static int sh_pfc_config_function(struct sh_pfc *pfc, unsigned offset)
 {
 	if (sh_pfc_config_gpio(pfc, offset,
 			       PINMUX_TYPE_FUNCTION,
@@ -327,10 +327,10 @@ static struct pinctrl_desc sh_pfc_pinctrl_desc = {
 	.confops	= &sh_pfc_pinconf_ops,
 };
 
-static inline void __devinit sh_pfc_map_one_gpio(struct sh_pfc *pfc,
-						 struct sh_pfc_pinctrl *pmx,
-						 struct pinmux_gpio *gpio,
-						 unsigned offset)
+static void __devinit sh_pfc_map_one_gpio(struct sh_pfc *pfc,
+					  struct sh_pfc_pinctrl *pmx,
+					  struct pinmux_gpio *gpio,
+					  unsigned offset)
 {
 	struct pinmux_data_reg *dummy;
 	unsigned long flags;
-- 
1.7.8.6

