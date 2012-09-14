From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 14 Sep 2012 18:25:48 +0000
Subject: [PATCH] sh: pfc: Release spinlock in sh_pfc_gpio_request_enable() error path
Message-Id: <1347647148-28117-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The sh_pfc_gpio_request_enable() function acquires a spinlock but fails
to release it before returning if the requested mux type is not
supported. Fix this.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/sh/pfc/pinctrl.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

This is a v3.6 regression.

diff --git a/drivers/sh/pfc/pinctrl.c b/drivers/sh/pfc/pinctrl.c
index 2804eaa..a3ac39b 100644
--- a/drivers/sh/pfc/pinctrl.c
+++ b/drivers/sh/pfc/pinctrl.c
@@ -211,7 +211,8 @@ static int sh_pfc_gpio_request_enable(struct pinctrl_dev *pctldev,
 		break;
 	default:
 		pr_err("Unsupported mux type (%d), bailing...\n", pinmux_type);
-		return -ENOTSUPP;
+		ret = -ENOTSUPP;
+		goto err;
 	}
 
 	ret = 0;
-- 
Regards,

Laurent Pinchart

