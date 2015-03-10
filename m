From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 10 Mar 2015 11:14:40 +0000
Subject: [PATCH 2/2] pinctrl: sh-pfc: Remove r8a7790 platform_device_id entry
Message-Id: <1425986080-26648-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1425986080-26648-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1425986080-26648-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

The r8a7790 platform is now DT-only, the driver doesn't need to match
platform devices by name anymore. Remove the corresponding
platform_device_id entry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
The r8a7790 platform is DT-only since v4.0-rc1.

 drivers/pinctrl/sh-pfc/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 0e6083fc3563f4a5..52342a22d40a031f 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -591,9 +591,6 @@ static const struct platform_device_id sh_pfc_id_table[] = {
 #ifdef CONFIG_PINCTRL_PFC_R8A7779
 	{ "pfc-r8a7779", (kernel_ulong_t)&r8a7779_pinmux_info },
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A7790
-	{ "pfc-r8a7790", (kernel_ulong_t)&r8a7790_pinmux_info },
-#endif
 #ifdef CONFIG_PINCTRL_PFC_SH7203
 	{ "pfc-sh7203", (kernel_ulong_t)&sh7203_pinmux_info },
 #endif
-- 
1.9.1

