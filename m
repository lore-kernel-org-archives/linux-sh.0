From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 10 Jan 2020 13:19:22 +0000
Subject: [PATCH 08/13] pinctrl: sh-pfc: checker: Improve pin group checks
Message-Id: <20200110131927.1029-9-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200110131927.1029-1-geert+renesas@glider.be>
In-Reply-To: <20200110131927.1029-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Improve the checks for pin group descriptors:
  1. Introduce a local variable for the current group, to make the
     checks easier to read,
  2. Pin group names must be unique.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 54e433149e9bf715..4642959714f97102 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -916,15 +916,22 @@ static void __init sh_pfc_check_info(const struct sh_pfc_soc_info *info)
 	}
 
 	for (i = 0; i < info->nr_groups; i++) {
-		if (!info->groups[i].name) {
+		const struct sh_pfc_pin_group *group = &info->groups[i];
+
+		if (!group->name) {
 			sh_pfc_err("empty group %u\n", i);
 			continue;
 		}
+		for (j = 0; j < i; j++) {
+			if (same_name(group->name, info->groups[j].name))
+				sh_pfc_err("group %s: name conflict\n",
+					   group->name);
+		}
 		if (!refcnts[i])
-			sh_pfc_err("orphan group %s\n", info->groups[i].name);
+			sh_pfc_err("orphan group %s\n", group->name);
 		else if (refcnts[i] > 1)
 			sh_pfc_warn("group %s referenced by %u functions\n",
-				    info->groups[i].name, refcnts[i]);
+				    group->name, refcnts[i]);
 	}
 
 	kfree(refcnts);
-- 
2.17.1
