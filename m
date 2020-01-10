From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 10 Jan 2020 13:19:26 +0000
Subject: [PATCH 12/13] pinctrl: sh-pfc: checker: Add data register checks
Message-Id: <20200110131927.1029-13-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200110131927.1029-1-geert+renesas@glider.be>
In-Reply-To: <20200110131927.1029-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add checks for data register descriptors:
  1. Register addresses must be unique.
  2. Enum ID values must be unique.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index eb2b0860378407e5..34d3d210c7347336 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -1004,6 +1004,14 @@ static void __init sh_pfc_check_info(const struct sh_pfc_soc_info *info)
 	/* Check ioctrl registers */
 	for (i = 0; info->ioctrl_regs && info->ioctrl_regs[i].reg; i++)
 		sh_pfc_check_reg(drvname, info->ioctrl_regs[i].reg);
+
+	/* Check data registers */
+	for (i = 0; info->data_regs && info->data_regs[i].reg; i++) {
+		sh_pfc_check_reg(drvname, info->data_regs[i].reg);
+		sh_pfc_check_reg_enums(drvname, info->data_regs[i].reg,
+				       info->data_regs[i].enum_ids,
+				       info->data_regs[i].reg_width);
+	}
 }
 
 static void __init sh_pfc_check_driver(const struct platform_driver *pdrv)
-- 
2.17.1
