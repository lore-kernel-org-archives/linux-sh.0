From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 28 Nov 2013 15:20:03 +0000
Subject: [PATCH 1/2] sh-pfc: r8a7740: Fix pin bias setup
Message-Id: <1385652004-7117-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
index 009174d..bc5eb45 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7740.c
@@ -3720,7 +3720,7 @@ static void __iomem *r8a7740_pinmux_portcr(struct sh_pfc *pfc, unsigned int pin)
 		const struct r8a7740_portcr_group *group  			&r8a7740_portcr_offsets[i];
 
-		if (i <= group->end_pin)
+		if (pin <= group->end_pin)
 			return pfc->window->virt + group->offset + pin;
 	}
 
-- 
1.8.3.2

