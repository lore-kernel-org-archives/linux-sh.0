From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Fri, 28 Dec 2012 22:54:25 +0000
Subject: [PATCH v4 43/81] sh-pfc: Remove platform device registration
Message-Id: <1356735303-29474-44-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The PFC platform device is now registered by arch code, remove the
legacy registration mechanism.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/sh/pfc/core.c  |   12 ------------
 include/linux/sh_pfc.h |   10 ----------
 2 files changed, 0 insertions(+), 22 deletions(-)

diff --git a/drivers/sh/pfc/core.c b/drivers/sh/pfc/core.c
index b2e121d..9456c70 100644
--- a/drivers/sh/pfc/core.c
+++ b/drivers/sh/pfc/core.c
@@ -578,18 +578,6 @@ static struct platform_driver sh_pfc_driver = {
 	},
 };
 
-static struct platform_device sh_pfc_device = {
-	.name		= DRV_NAME,
-	.id		= -1,
-};
-
-int __init register_sh_pfc(struct sh_pfc_platform_data *pdata)
-{
-	sh_pfc_device.dev.platform_data = pdata;
-
-	return platform_device_register(&sh_pfc_device);
-}
-
 static int __init sh_pfc_init(void)
 {
 	return platform_driver_register(&sh_pfc_driver);
diff --git a/include/linux/sh_pfc.h b/include/linux/sh_pfc.h
index f7f01b2..fa1fec0 100644
--- a/include/linux/sh_pfc.h
+++ b/include/linux/sh_pfc.h
@@ -120,16 +120,6 @@ struct sh_pfc_platform_data {
 /* XXX compat for now */
 #define pinmux_info sh_pfc_platform_data
 
-/* drivers/sh/pfc/core.c */
-int register_sh_pfc(struct sh_pfc_platform_data *pfc);
-
-/* xxx */
-static inline int register_pinmux(struct pinmux_info *pip)
-{
-	struct sh_pfc_platform_data *pdata = pip;
-	return register_sh_pfc(pdata);
-}
-
 enum { GPIO_CFG_DRYRUN, GPIO_CFG_REQ, GPIO_CFG_FREE };
 
 /* helper macro for port */
-- 
1.7.8.6

