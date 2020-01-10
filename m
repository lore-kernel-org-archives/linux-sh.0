From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 10 Jan 2020 13:19:15 +0000
Subject: [PATCH 01/13] pinctrl: sh-pfc: checker: Move data before code
Message-Id: <20200110131927.1029-2-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20200110131927.1029-1-geert+renesas@glider.be>
In-Reply-To: <20200110131927.1029-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Restructure the checker to move all data definitions to the top, before
the code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/sh-pfc/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
index 82209116955b153a..a565effbff12f5a9 100644
--- a/drivers/pinctrl/sh-pfc/core.c
+++ b/drivers/pinctrl/sh-pfc/core.c
@@ -726,6 +726,9 @@ static int sh_pfc_suspend_init(struct sh_pfc *pfc) { return 0; }
 #endif /* CONFIG_PM_SLEEP && CONFIG_ARM_PSCI_FW */
 
 #ifdef DEBUG
+static unsigned int sh_pfc_errors __initdata = 0;
+static unsigned int sh_pfc_warnings __initdata = 0;
+
 static bool __init is0s(const u16 *enum_ids, unsigned int n)
 {
 	unsigned int i;
@@ -737,9 +740,6 @@ static bool __init is0s(const u16 *enum_ids, unsigned int n)
 	return true;
 }
 
-static unsigned int sh_pfc_errors __initdata = 0;
-static unsigned int sh_pfc_warnings __initdata = 0;
-
 static void __init sh_pfc_check_cfg_reg(const char *drvname,
 					const struct pinmux_cfg_reg *cfg_reg)
 {
-- 
2.17.1
