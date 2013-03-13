From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 13 Mar 2013 22:39:34 +0000
Subject: [PATCH 15/25] sh-pfc: Drop unused support for 1:1 physical to virtual memory mappings
Message-Id: <1363214384-3870-16-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Now that all PFC platform devices provide memory resources support for
registers without an associated memory resource isn't used anymore. Drop
it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/core.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index e847d16..cadfb37 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -30,10 +30,8 @@ static int sh_pfc_ioremap(struct sh_pfc *pfc, struct platform_device *pdev)
 	struct resource *res;
 	int k;
 
-	if (pdev->num_resources = 0) {
-		pfc->num_windows = 0;
-		return 0;
-	}
+	if (pdev->num_resources = 0)
+		return -EINVAL;
 
 	pfc->window = devm_kzalloc(pfc->dev, pdev->num_resources *
 				   sizeof(*pfc->window), GFP_NOWAIT);
@@ -59,11 +57,11 @@ static void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc,
 					 unsigned long address)
 {
 	struct sh_pfc_window *window;
-	int k;
+	unsigned int i;
 
 	/* scan through physical windows and convert address */
-	for (k = 0; k < pfc->num_windows; k++) {
-		window = pfc->window + k;
+	for (i = 0; i < pfc->num_windows; i++) {
+		window = pfc->window + i;
 
 		if (address < window->phys)
 			continue;
@@ -74,8 +72,7 @@ static void __iomem *sh_pfc_phys_to_virt(struct sh_pfc *pfc,
 		return window->virt + (address - window->phys);
 	}
 
-	/* no windows defined, register must be 1:1 mapped virt:phys */
-	return (void __iomem *)address;
+	BUG();
 }
 
 struct sh_pfc_pin *sh_pfc_get_pin(struct sh_pfc *pfc, unsigned int pin)
-- 
1.8.1.5

