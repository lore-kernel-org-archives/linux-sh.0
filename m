From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 10 Mar 2015 11:14:39 +0000
Subject: [PATCH 1/2] pinctrl: sh-pfc: Remove emev2 platform_device_id entry
Message-Id: <1425986080-26648-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The emev2 platform is now DT-only, the driver doesn't need to match
platform devices by name anymore. Remove the corresponding
platform_device_id entry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
The emev2 platform never had pinctrl support for non-DT.

 drivers/pinctrl/sh-pfc/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 656745f545442d58..0e6083fc3563f4a5 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -579,9 +579,6 @@ static int sh_pfc_remove(struct platform_device *pdev)
 }
 
 static const struct platform_device_id sh_pfc_id_table[] = {
-#ifdef CONFIG_PINCTRL_PFC_EMEV2
-	{ "pfc-emev2", (kernel_ulong_t)&emev2_pinmux_info },
-#endif
 #ifdef CONFIG_PINCTRL_PFC_R8A73A4
 	{ "pfc-r8a73a4", (kernel_ulong_t)&r8a73a4_pinmux_info },
 #endif
-- 
1.9.1

