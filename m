From: Bill Pemberton <wfp5p@virginia.edu>
Date: Mon, 19 Nov 2012 18:26:15 +0000
Subject: [PATCH 426/493] sh: remove use of __devexit
Message-Id: <1353349642-3677-426-git-send-email-wfp5p@virginia.edu>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

CONFIG_HOTPLUG is going away as an option so __devexit is no
longer needed.

Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
Cc: linux-sh@vger.kernel.org 
---
 drivers/sh/pfc/gpio.c    | 2 +-
 drivers/sh/pfc/pinctrl.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/sh/pfc/gpio.c b/drivers/sh/pfc/gpio.c
index 8f4f431..6a24f07 100644
--- a/drivers/sh/pfc/gpio.c
+++ b/drivers/sh/pfc/gpio.c
@@ -184,7 +184,7 @@ static int sh_pfc_gpio_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static int __devexit sh_pfc_gpio_remove(struct platform_device *pdev)
+static int sh_pfc_gpio_remove(struct platform_device *pdev)
 {
 	struct sh_pfc_chip *chip = platform_get_drvdata(pdev);
 	int ret;
diff --git a/drivers/sh/pfc/pinctrl.c b/drivers/sh/pfc/pinctrl.c
index 5dd1806..50e3556 100644
--- a/drivers/sh/pfc/pinctrl.c
+++ b/drivers/sh/pfc/pinctrl.c
@@ -465,7 +465,7 @@ free_pads:
 	return ret;
 }
 
-static int __devexit sh_pfc_pinctrl_remove(struct platform_device *pdev)
+static int sh_pfc_pinctrl_remove(struct platform_device *pdev)
 {
 	struct sh_pfc_pinctrl *pmx = platform_get_drvdata(pdev);
 
-- 
1.8.0

