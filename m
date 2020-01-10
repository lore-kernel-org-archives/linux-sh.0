From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 10 Jan 2020 13:19:16 +0000
Subject: [PATCH 02/13] pinctrl: sh-pfc: checker: Add helpers for reporting
Message-Id: <20200110131927.1029-3-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200110131927.1029-1-geert+renesas@glider.be>
In-Reply-To: <20200110131927.1029-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add helpers to report errors and warnings, and to increase the
corresponding counters.  This simplifies callers.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/core.c | 96 ++++++++++++++++-------------------
 1 file changed, 44 insertions(+), 52 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index a565effbff12f5a9..45bdaf88819fa498 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -729,6 +729,17 @@ static int sh_pfc_suspend_init(struct sh_pfc *pfc) { return 0; }
 static unsigned int sh_pfc_errors __initdata = 0;
 static unsigned int sh_pfc_warnings __initdata = 0;
 
+#define sh_pfc_err(fmt, ...)					 \
+	do {							 \
+		pr_err("%s: " fmt, drvname, ##__VA_ARGS__);	\
+		sh_pfc_errors++;				\
+	} while (0)
+#define sh_pfc_warn(fmt, ...)					 \
+	do {							 \
+		pr_warn("%s: " fmt, drvname, ##__VA_ARGS__);	\
+		sh_pfc_warnings++;				\
+	} while (0)
+
 static bool __init is0s(const u16 *enum_ids, unsigned int n)
 {
 	unsigned int i;
@@ -751,26 +762,20 @@ static void __init sh_pfc_check_cfg_reg(const char *drvname,
 	}
 
 	for (i = 0, n = 0, rw = 0; (fw = cfg_reg->var_field_width[i]); i++) {
-		if (fw > 3 && is0s(&cfg_reg->enum_ids[n], 1 << fw)) {
-			pr_warn("%s: reg 0x%x: reserved field [%u:%u] can be split to reduce table size\n",
-				drvname, cfg_reg->reg, rw, rw + fw - 1);
-			sh_pfc_warnings++;
-		}
+		if (fw > 3 && is0s(&cfg_reg->enum_ids[n], 1 << fw))
+			sh_pfc_warn("reg 0x%x: reserved field [%u:%u] can be split to reduce table size\n",
+				    cfg_reg->reg, rw, rw + fw - 1);
 		n += 1 << fw;
 		rw += fw;
 	}
 
-	if (rw != cfg_reg->reg_width) {
-		pr_err("%s: reg 0x%x: var_field_width declares %u instead of %u bits\n",
-		       drvname, cfg_reg->reg, rw, cfg_reg->reg_width);
-		sh_pfc_errors++;
-	}
+	if (rw != cfg_reg->reg_width)
+		sh_pfc_err("reg 0x%x: var_field_width declares %u instead of %u bits\n",
+			   cfg_reg->reg, rw, cfg_reg->reg_width);
 
-	if (n != cfg_reg->nr_enum_ids) {
-		pr_err("%s: reg 0x%x: enum_ids[] has %u instead of %u values\n",
-		       drvname, cfg_reg->reg, cfg_reg->nr_enum_ids, n);
-		sh_pfc_errors++;
-	}
+	if (n != cfg_reg->nr_enum_ids)
+		sh_pfc_err("reg 0x%x: enum_ids[] has %u instead of %u values\n",
+			   cfg_reg->reg, cfg_reg->nr_enum_ids, n);
 }
 
 static void __init sh_pfc_check_info(const struct sh_pfc_soc_info *info)
@@ -785,29 +790,24 @@ static void __init sh_pfc_check_info(const struct sh_pfc_soc_info *info)
 	/* Check pins */
 	for (i = 0; i < info->nr_pins; i++) {
 		for (j = 0; j < i; j++) {
-			if (!strcmp(info->pins[i].name, info->pins[j].name)) {
-				pr_err("%s: pin %s/%s: name conflict\n",
-				       drvname, info->pins[i].name,
-				       info->pins[j].name);
-				sh_pfc_errors++;
-			}
+			if (!strcmp(info->pins[i].name, info->pins[j].name))
+				sh_pfc_err("pin %s/%s: name conflict\n",
+					   info->pins[i].name,
+					   info->pins[j].name);
 
 			if (info->pins[i].pin != (u16)-1 &&
-			    info->pins[i].pin = info->pins[j].pin) {
-				pr_err("%s: pin %s/%s: pin %u conflict\n",
-				       drvname, info->pins[i].name,
-				       info->pins[j].name, info->pins[i].pin);
-				sh_pfc_errors++;
-			}
+			    info->pins[i].pin = info->pins[j].pin)
+				sh_pfc_err("pin %s/%s: pin %u conflict\n",
+					   info->pins[i].name,
+					   info->pins[j].name,
+					   info->pins[i].pin);
 
 			if (info->pins[i].enum_id &&
-			    info->pins[i].enum_id = info->pins[j].enum_id) {
-				pr_err("%s: pin %s/%s: enum_id %u conflict\n",
-				       drvname, info->pins[i].name,
-				       info->pins[j].name,
-				       info->pins[i].enum_id);
-				sh_pfc_errors++;
-			}
+			    info->pins[i].enum_id = info->pins[j].enum_id)
+				sh_pfc_err("pin %s/%s: enum_id %u conflict\n",
+					   info->pins[i].name,
+					   info->pins[j].name,
+					   info->pins[i].enum_id);
 		}
 	}
 
@@ -819,8 +819,7 @@ static void __init sh_pfc_check_info(const struct sh_pfc_soc_info *info)
 	for (i = 0; i < info->nr_functions; i++) {
 		func = &info->functions[i];
 		if (!func->name) {
-			pr_err("%s: empty function %u\n", drvname, i);
-			sh_pfc_errors++;
+			sh_pfc_err("empty function %u\n", i);
 			continue;
 		}
 		for (j = 0; j < func->nr_groups; j++) {
@@ -833,29 +832,22 @@ static void __init sh_pfc_check_info(const struct sh_pfc_soc_info *info)
 				}
 			}
 
-			if (k = info->nr_groups) {
-				pr_err("%s: function %s: group %s not found\n",
-				       drvname, func->name, func->groups[j]);
-				sh_pfc_errors++;
-			}
+			if (k = info->nr_groups)
+				sh_pfc_err("function %s: group %s not found\n",
+					   func->name, func->groups[j]);
 		}
 	}
 
 	for (i = 0; i < info->nr_groups; i++) {
 		if (!info->groups[i].name) {
-			pr_err("%s: empty group %u\n", drvname, i);
-			sh_pfc_errors++;
+			sh_pfc_err("empty group %u\n", i);
 			continue;
 		}
-		if (!refcnts[i]) {
-			pr_err("%s: orphan group %s\n", drvname,
-			       info->groups[i].name);
-			sh_pfc_errors++;
-		} else if (refcnts[i] > 1) {
-			pr_warn("%s: group %s referenced by %u functions\n",
-				drvname, info->groups[i].name, refcnts[i]);
-			sh_pfc_warnings++;
-		}
+		if (!refcnts[i])
+			sh_pfc_err("orphan group %s\n", info->groups[i].name);
+		else if (refcnts[i] > 1)
+			sh_pfc_warn("group %s referenced by %u functions\n",
+				    info->groups[i].name, refcnts[i]);
 	}
 
 	kfree(refcnts);
-- 
2.17.1
