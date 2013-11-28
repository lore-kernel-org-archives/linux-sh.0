From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 28 Nov 2013 15:20:04 +0000
Subject: [PATCH 2/2] sh-pfc: sh7372: Fix pin bias setup
Message-Id: <1385652004-7117-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

When computing the pin configuration register offset the bias setup code
erroneously compares the pin number range with the loop index instead of
the pin number. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pfc-sh7372.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-sh7372.c b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
index 70b522d..cc097b6 100644
--- a/drivers/pinctrl/sh-pfc/pfc-sh7372.c
+++ b/drivers/pinctrl/sh-pfc/pfc-sh7372.c
@@ -2584,7 +2584,7 @@ static void __iomem *sh7372_pinmux_portcr(struct sh_pfc *pfc, unsigned int pin)
 		const struct sh7372_portcr_group *group  			&sh7372_portcr_offsets[i];
 
-		if (i <= group->end_pin)
+		if (pin <= group->end_pin)
 			return pfc->window->virt + group->offset + pin;
 	}
 
-- 
1.8.3.2

