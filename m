From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 22 Apr 2013 22:59:43 +0000
Subject: [PATCH 02/37] sh-pfc: r8a7740: Declare missing INTC function
Message-Id: <1366671618-8796-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When adding the INTC pin groups the INTC function hasn't been added to
the functions list. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 58b0284..da00bc4 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -2694,6 +2694,7 @@ static const char * const sdhi2_groups[] = {
 };
 
 static const struct sh_pfc_function pinmux_functions[] = {
+	SH_PFC_FUNCTION(intc),
 	SH_PFC_FUNCTION(lcd0),
 	SH_PFC_FUNCTION(lcd1),
 	SH_PFC_FUNCTION(mmc0),
-- 
1.8.1.5

