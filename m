From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 14 Jul 2015 11:56:55 +0000
Subject: [PATCH v2 4/4] pinctrl: sh-pfc: Remove obsolete r8a7740 platform_device_id entry
Message-Id: <1436875015-13706-5-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1436875015-13706-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1436875015-13706-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Since the removal of the r8a7740 legacy SoC code in commit
44d88c754e57a6d9 ("ARM: shmobile: Remove legacy SoC code for R-Mobile
A1"), r8a7740 is only supported in generic DT-only ARM multi-platform
builds.  The driver doesn't need to match platform devices by name
anymore, hence remove the corresponding platform_device_id entry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
The commit mentioned above is in -next, destined for v4.3. Please apply.

v2:
  - Add Acked-by.
---
 drivers/pinctrl/sh-pfc/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index ceb7dbc1995c7c7f..98d465f37a469743 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -591,9 +591,6 @@ static int sh_pfc_remove(struct platform_device *pdev)
 }
 
 static const struct platform_device_id sh_pfc_id_table[] = {
-#ifdef CONFIG_PINCTRL_PFC_R8A7740
-	{ "pfc-r8a7740", (kernel_ulong_t)&r8a7740_pinmux_info },
-#endif
 #ifdef CONFIG_PINCTRL_PFC_R8A7778
 	{ "pfc-r8a7778", (kernel_ulong_t)&r8a7778_pinmux_info },
 #endif
-- 
1.9.1

