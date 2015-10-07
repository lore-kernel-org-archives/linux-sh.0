From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 07 Oct 2015 10:28:39 +0000
Subject: [PATCH 1/2] pinctrl: sh-pfc: Remove obsolete r8a7779 platform_device_id entry
Message-Id: <1444213720-26770-2-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1444213720-26770-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1444213720-26770-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-gpio@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Since the removal of the r8a7779 legacy SoC code in commit
c99cd90d98a98aa1 ("ARM: shmobile: r8a7779: Remove legacy SoC code"),
r8a7779 is only supported in generic DT-only ARM multi-platform builds.
The driver doesn't need to match platform devices by name anymore, hence
remove the corresponding platform_device_id entry.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index bcf3017318db..a0c5e9ef7433 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -596,9 +596,6 @@ static const struct platform_device_id sh_pfc_id_table[] = {
 #ifdef CONFIG_PINCTRL_PFC_R8A7778
 	{ "pfc-r8a7778", (kernel_ulong_t)&r8a7778_pinmux_info },
 #endif
-#ifdef CONFIG_PINCTRL_PFC_R8A7779
-	{ "pfc-r8a7779", (kernel_ulong_t)&r8a7779_pinmux_info },
-#endif
 #ifdef CONFIG_PINCTRL_PFC_SH7203
 	{ "pfc-sh7203", (kernel_ulong_t)&sh7203_pinmux_info },
 #endif
-- 
1.9.1

