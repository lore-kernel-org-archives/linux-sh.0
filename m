From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 10 Jan 2020 13:19:17 +0000
Subject: [PATCH 03/13] pinctrl: sh-pfc: checker: Add helper for safe name comparison
Message-Id: <20200110131927.1029-4-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200110131927.1029-1-geert+renesas@glider.be>
In-Reply-To: <20200110131927.1029-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add a helper to check if two strings are identical, skipping NULL
pointers.  This simplifies callers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/core.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 45bdaf88819fa498..fe11841e8ce81dbb 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -751,6 +751,14 @@ static bool __init is0s(const u16 *enum_ids, unsigned int n)
 	return true;
 }
 
+static bool __init same_name(const char *a, const char *b)
+{
+	if (!a || !b)
+		return false;
+
+	return !strcmp(a, b);
+}
+
 static void __init sh_pfc_check_cfg_reg(const char *drvname,
 					const struct pinmux_cfg_reg *cfg_reg)
 {
@@ -790,7 +798,7 @@ static void __init sh_pfc_check_info(const struct sh_pfc_soc_info *info)
 	/* Check pins */
 	for (i = 0; i < info->nr_pins; i++) {
 		for (j = 0; j < i; j++) {
-			if (!strcmp(info->pins[i].name, info->pins[j].name))
+			if (same_name(info->pins[i].name, info->pins[j].name))
 				sh_pfc_err("pin %s/%s: name conflict\n",
 					   info->pins[i].name,
 					   info->pins[j].name);
@@ -824,9 +832,8 @@ static void __init sh_pfc_check_info(const struct sh_pfc_soc_info *info)
 		}
 		for (j = 0; j < func->nr_groups; j++) {
 			for (k = 0; k < info->nr_groups; k++) {
-				if (info->groups[k].name &&
-				    !strcmp(func->groups[j],
-					    info->groups[k].name)) {
+				if (same_name(func->groups[j],
+					      info->groups[k].name)) {
 					refcnts[k]++;
 					break;
 				}
-- 
2.17.1
