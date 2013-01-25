From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 25 Jan 2013 02:24:18 +0000
Subject: [PATCH 42/80] sh-pfc: Remove platform device registration
Message-Id: <1359080696-31489-43-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1359080696-31489-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The PFC platform device is now registered by arch code, remove the
legacy registration mechanism.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Paul Mundt <lethal@linux-sh.org>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/sh/pfc/core.c  |   12 ------------
 include/linux/sh_pfc.h |   10 ----------
 2 files changed, 22 deletions(-)

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
1.7.10.4

