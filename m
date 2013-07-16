From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 16 Jul 2013 00:11:01 +0000
Subject: [PATCH v2 09/27] sh-pfc: Remove unused input_pd and input_pu ranges
Message-Id: <1373933479-17727-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

The ranges are not used anymore, remove them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/pinctrl/sh-pfc/core.c   | 8 --------
 drivers/pinctrl/sh-pfc/sh_pfc.h | 4 ----
 2 files changed, 12 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index f3fc66b..1c8597c 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -283,14 +283,6 @@ int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type)
 		range = &pfc->info->input;
 		break;
 
-	case PINMUX_TYPE_INPUT_PULLUP:
-		range = &pfc->info->input_pu;
-		break;
-
-	case PINMUX_TYPE_INPUT_PULLDOWN:
-		range = &pfc->info->input_pd;
-		break;
-
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 830ae1f..64219f6 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -25,8 +25,6 @@ enum {
 	PINMUX_TYPE_GPIO,
 	PINMUX_TYPE_OUTPUT,
 	PINMUX_TYPE_INPUT,
-	PINMUX_TYPE_INPUT_PULLUP,
-	PINMUX_TYPE_INPUT_PULLDOWN,
 
 	PINMUX_FLAG_TYPE,	/* must be last */
 };
@@ -141,8 +139,6 @@ struct sh_pfc_soc_info {
 	const struct sh_pfc_soc_operations *ops;
 
 	struct pinmux_range input;
-	struct pinmux_range input_pd;
-	struct pinmux_range input_pu;
 	struct pinmux_range output;
 	struct pinmux_range function;
 
-- 
1.8.1.5

