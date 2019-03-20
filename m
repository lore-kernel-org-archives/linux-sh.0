From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 20 Mar 2019 10:21:40 +0000
Subject: [PATCH v3 09/10] pinctrl: sh-pfc: Validate enum IDs for regs with fixed-width fields
Message-Id: <20190320102141.19316-10-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20190320102141.19316-1-geert+renesas@glider.be>
In-Reply-To: <20190320102141.19316-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Add build-time checks to the PINMUX_CFG_REG() and PINMUX_DATA_REG()
macros, to ensure the number of provided enum IDs is correct.

This helps catching bugs early.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v3:
  - No changes,

v2:
  - Convert from run-time to build-time check.
  - Add check for PINMUX_DATA_REG().
---
 drivers/pinctrl/sh-pfc/sh_pfc.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 57e13b623b2e87ec..31acde5032a0691a 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -130,7 +130,9 @@ struct pinmux_cfg_reg {
  */
 #define PINMUX_CFG_REG(name, r, r_width, f_width, ids)			\
 	.reg = r, .reg_width = r_width,					\
-	.field_width = f_width + BUILD_BUG_ON_ZERO(r_width % f_width),	\
+	.field_width = f_width + BUILD_BUG_ON_ZERO(r_width % f_width) +	\
+	BUILD_BUG_ON_ZERO(sizeof((const u16 []) { ids }) / sizeof(u16) != \
+			  (r_width / f_width) * (1 << f_width)),	\
 	.enum_ids = (const u16 [(r_width / f_width) * (1 << f_width)])	\
 		{ ids }
 
@@ -196,7 +198,9 @@ struct pinmux_data_reg {
  *          enum ID must be specified, all wrapped using the GROUP() macro.
  */
 #define PINMUX_DATA_REG(name, r, r_width, ids)				\
-	.reg = r, .reg_width = r_width,					\
+	.reg = r, .reg_width = r_width +				\
+	BUILD_BUG_ON_ZERO(sizeof((const u16 []) { ids }) / sizeof(u16) != \
+			  r_width),					\
 	.enum_ids = (const u16 [r_width]) { ids }
 
 struct pinmux_irq {
-- 
2.17.1
