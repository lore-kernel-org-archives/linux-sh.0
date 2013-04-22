From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 23:00:08 +0000
Subject: [PATCH 27/37] sh-pfc: r8a7740: Remove HDMI function GPIOS
Message-Id: <1366671618-8796-28-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

All r8a7740 platforms now use the pinctrl API to control the HDMI pins,
the corresponding function GPIOS are unused. Remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index a93fd84..fb7a3e8 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -3386,10 +3386,6 @@ static const struct pinmux_func pinmux_func_gpios[] = {
 	GPIO_FN(SDENC_CPG),
 	GPIO_FN(SDENC_DV_CLKI),
 
-	/* HDMI */
-	GPIO_FN(HDMI_HPD),
-	GPIO_FN(HDMI_CEC),
-
 	/* SYSC */
 	GPIO_FN(RESETP_PULLUP),
 	GPIO_FN(RESETP_PLAIN),
-- 
1.8.1.5

