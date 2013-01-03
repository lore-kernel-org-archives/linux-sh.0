From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 03 Jan 2013 18:17:33 +0000
Subject: [PATCH 02/22] sh-pfc: Don't take the sh_pfc spinlock in sh_pfc_map_gpios()
Message-Id: <1357237073-15600-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The sh_pfc_map_gpios() function is only called at initialization time
when no other task can access the sh_pfc fields. Don't protect the
operation with a spinlock.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/pinctrl.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pinctrl.c b/drivers/pinctrl/sh-pfc/pinctrl.c
index 472fcf5..67d576c 100644
--- a/drivers/pinctrl/sh-pfc/pinctrl.c
+++ b/drivers/pinctrl/sh-pfc/pinctrl.c
@@ -344,7 +344,6 @@ static void sh_pfc_map_one_gpio(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx,
 /* pinmux ranges -> pinctrl pin descs */
 static int sh_pfc_map_gpios(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 {
-	unsigned long flags;
 	int i;
 
 	pmx->nr_pads = pfc->info->last_gpio - pfc->info->first_gpio + 1;
@@ -356,8 +355,6 @@ static int sh_pfc_map_gpios(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 		return -ENOMEM;
 	}
 
-	spin_lock_irqsave(&pfc->lock, flags);
-
 	/*
 	 * We don't necessarily have a 1:1 mapping between pin and linux
 	 * GPIO number, as the latter maps to the associated enum_id.
@@ -378,8 +375,6 @@ static int sh_pfc_map_gpios(struct sh_pfc *pfc, struct sh_pfc_pinctrl *pmx)
 		sh_pfc_map_one_gpio(pfc, pmx, gpio, i);
 	}
 
-	spin_unlock_irqrestore(&pfc->lock, flags);
-
 	sh_pfc_pinctrl_desc.pins = pmx->pads;
 	sh_pfc_pinctrl_desc.npins = pmx->nr_pads;
 
-- 
1.7.8.6

