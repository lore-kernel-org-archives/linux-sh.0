From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 26 Mar 2013 02:20:14 +0000
Subject: [PATCH 1/2] sh-pfc: Fix compiler warning when BUG()
Message-Id: <1364264415-6020-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The sh_pfc_phys_to_virt() function ends with a BUG() statement without a
return. When CONFIG_BUG isn't set the function will thus have no return
value. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index feef897..97e6ea3 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -72,6 +72,7 @@ static void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc,
 	}
 
 	BUG();
+	return NULL;
 }
 
 int sh_pfc_get_pin_index(struct sh_pfc *pfc, unsigned int pin)
-- 
1.8.1.5

