From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 10 Jan 2020 13:19:24 +0000
Subject: [PATCH 10/13] pinctrl: sh-pfc: checker: Add bias register checks
Message-Id: <20200110131927.1029-11-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200110131927.1029-1-geert+renesas@glider.be>
In-Reply-To: <20200110131927.1029-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add checks for bias register descriptors:
  1. Pull-up and optional pull-down register addresses must be unique,
  2. Referred pins must exist.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index a1667a29dd69c3ff..b737aa5978b7daa4 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -888,6 +888,18 @@ static void __init sh_pfc_check_drive_reg(const struct sh_pfc_soc_info *info,
 	}
 }
 
+static void __init sh_pfc_check_bias_reg(const struct sh_pfc_soc_info *info,
+					 const struct pinmux_bias_reg *bias)
+{
+	unsigned int i;
+
+	sh_pfc_check_reg(info->name, bias->puen);
+	if (bias->pud)
+		sh_pfc_check_reg(info->name, bias->pud);
+	for (i = 0; i < ARRAY_SIZE(bias->pins); i++)
+		sh_pfc_check_pin(info, bias->puen, bias->pins[i]);
+}
+
 static void __init sh_pfc_check_info(const struct sh_pfc_soc_info *info)
 {
 	const char *drvname = info->name;
@@ -984,6 +996,10 @@ static void __init sh_pfc_check_info(const struct sh_pfc_soc_info *info)
 	/* Check drive strength registers */
 	for (i = 0; info->drive_regs && info->drive_regs[i].reg; i++)
 		sh_pfc_check_drive_reg(info, &info->drive_regs[i]);
+
+	/* Check bias registers */
+	for (i = 0; info->bias_regs && info->bias_regs[i].puen; i++)
+		sh_pfc_check_bias_reg(info, &info->bias_regs[i]);
 }
 
 static void __init sh_pfc_check_driver(const struct platform_driver *pdrv)
-- 
2.17.1
