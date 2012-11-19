From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:20:47 +0000
Subject: [PATCH 098/493] sh: remove use of __devexit_p
Message-Id: <1353349642-3677-98-git-send-email-wfp5p@virginia.edu>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: linux-sh@vger.kernel.org 
---
 drivers/sh/pfc/gpio.c    | 2 +-
 drivers/sh/pfc/pinctrl.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sh/pfc/gpio.c b/drivers/sh/pfc/gpio.c
index 038fa07..d08c978 100644
--- a/drivers/sh/pfc/gpio.c
+++ b/drivers/sh/pfc/gpio.c
@@ -199,7 +199,7 @@ static int __devexit sh_pfc_gpio_remove(struct platform_device *pdev)
 
 static struct platform_driver sh_pfc_gpio_driver = {
 	.probe		= sh_pfc_gpio_probe,
-	.remove		= __devexit_p(sh_pfc_gpio_remove),
+	.remove		= sh_pfc_gpio_remove,
 	.driver		= {
 		.name	= KBUILD_MODNAME,
 		.owner	= THIS_MODULE,
diff --git a/drivers/sh/pfc/pinctrl.c b/drivers/sh/pfc/pinctrl.c
index 0646bf6..99b3b4f 100644
--- a/drivers/sh/pfc/pinctrl.c
+++ b/drivers/sh/pfc/pinctrl.c
@@ -482,7 +482,7 @@ static int __devexit sh_pfc_pinctrl_remove(struct platform_device *pdev)
 
 static struct platform_driver sh_pfc_pinctrl_driver = {
 	.probe		= sh_pfc_pinctrl_probe,
-	.remove		= __devexit_p(sh_pfc_pinctrl_remove),
+	.remove		= sh_pfc_pinctrl_remove,
 	.driver		= {
 		.name	= DRV_NAME,
 		.owner	= THIS_MODULE,
-- 
1.8.0

