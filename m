From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 17 Jun 2015 09:31:29 +0000
Subject: [PATCH 13/15] pinctrl: sh-pfc: Remove obsolete sh73a0 platform_device_id entry
Message-Id: <1434533491-21979-14-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1434533491-21979-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1434533491-21979-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Since the removal of the sh73a0 legacy board code, sh73a0 is only
supported in generic DT-only ARM multi-platform builds.  The driver
doesn't need to match platform devices by name anymore, hence remove the
corresponding platform_device_id entry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
Please do not apply until the legacy sh73a0 SoC code has been removed.
Or just provide an ack, so Simon can apply it when appropriate.
---
 drivers/pinctrl/sh-pfc/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 96556362b28f2caa..3ff523e58c38d123 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -603,9 +603,6 @@ static const struct platform_device_id sh_pfc_id_table[] = {
 #ifdef CONFIG_PINCTRL_PFC_SH7269
 	{ "pfc-sh7269", (kernel_ulong_t)&sh7269_pinmux_info },
 #endif
-#ifdef CONFIG_PINCTRL_PFC_SH73A0
-	{ "pfc-sh73a0", (kernel_ulong_t)&sh73a0_pinmux_info },
-#endif
 #ifdef CONFIG_PINCTRL_PFC_SH7720
 	{ "pfc-sh7720", (kernel_ulong_t)&sh7720_pinmux_info },
 #endif
-- 
1.9.1

