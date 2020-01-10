From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 10 Jan 2020 13:19:21 +0000
Subject: [PATCH 07/13] pinctrl: sh-pfc: checker: Improve pin function checks
Message-Id: <20200110131927.1029-8-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200110131927.1029-1-geert+renesas@glider.be>
In-Reply-To: <20200110131927.1029-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Improve the checks for pin function descriptors:
  1. Merge declaration and assignment of the local variable for the
     current pin function,
  2. Pin function names must be unique.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 6ff0f19403dc7813..54e433149e9bf715 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -849,7 +849,6 @@ static void __init sh_pfc_check_cfg_reg(const char *drvname,
 
 static void __init sh_pfc_check_info(const struct sh_pfc_soc_info *info)
 {
-	const struct sh_pfc_function *func;
 	const char *drvname = info->name;
 	unsigned int *refcnts;
 	unsigned int i, j, k;
@@ -890,11 +889,17 @@ static void __init sh_pfc_check_info(const struct sh_pfc_soc_info *info)
 		return;
 
 	for (i = 0; i < info->nr_functions; i++) {
-		func = &info->functions[i];
+		const struct sh_pfc_function *func = &info->functions[i];
+
 		if (!func->name) {
 			sh_pfc_err("empty function %u\n", i);
 			continue;
 		}
+		for (j = 0; j < i; j++) {
+			if (same_name(func->name, info->functions[j].name))
+				sh_pfc_err("function %s: name conflict\n",
+					   func->name);
+		}
 		for (j = 0; j < func->nr_groups; j++) {
 			for (k = 0; k < info->nr_groups; k++) {
 				if (same_name(func->groups[j],
-- 
2.17.1
