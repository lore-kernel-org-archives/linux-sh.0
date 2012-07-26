From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Date: Thu, 26 Jul 2012 03:14:11 +0000
Subject: [PATCH] sh: pfc: Remove unused pfc in sh_pfc_pinconf_set function
Message-Id: <1343272451-16306-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

pfc is never used, remove it.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
---
 drivers/sh/pfc/pinctrl.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/sh/pfc/pinctrl.c b/drivers/sh/pfc/pinctrl.c
index 10a56d7..814b292 100644
--- a/drivers/sh/pfc/pinctrl.c
+++ b/drivers/sh/pfc/pinctrl.c
@@ -276,7 +276,6 @@ static int sh_pfc_pinconf_set(struct pinctrl_dev *pctldev, unsigned pin,
 			      unsigned long config)
 {
 	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
-	struct sh_pfc *pfc = pmx->pfc;
 
 	/* Validate the new type */
 	if (config >= PINMUX_FLAG_TYPE)
-- 
1.7.10

