From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 05 Jun 2013 08:25:51 +0000
Subject: [PATCH 060/130] sh-pfc: r8a7740: Declare missing INTC function
Message-Id: <1370420821-28420-61-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1370420821-28420-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

When adding the INTC pin groups the INTC function hasn't been added to
the functions list. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
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
1.8.2.1

