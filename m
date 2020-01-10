From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 10 Jan 2020 13:19:25 +0000
Subject: [PATCH 11/13] pinctrl: sh-pfc: checker: Add ioctrl register checks
Message-Id: <20200110131927.1029-12-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200110131927.1029-1-geert+renesas@glider.be>
In-Reply-To: <20200110131927.1029-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add checks for generic control register descriptors:
  1. Register addresses must be unique.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index b737aa5978b7daa4..eb2b0860378407e5 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -1000,6 +1000,10 @@ static void __init sh_pfc_check_info(const struct sh_pfc_soc_info *info)
 	/* Check bias registers */
 	for (i = 0; info->bias_regs && info->bias_regs[i].puen; i++)
 		sh_pfc_check_bias_reg(info, &info->bias_regs[i]);
+
+	/* Check ioctrl registers */
+	for (i = 0; info->ioctrl_regs && info->ioctrl_regs[i].reg; i++)
+		sh_pfc_check_reg(drvname, info->ioctrl_regs[i].reg);
 }
 
 static void __init sh_pfc_check_driver(const struct platform_driver *pdrv)
-- 
2.17.1
