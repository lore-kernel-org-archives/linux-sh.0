From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 13 Dec 2018 18:27:13 +0000
Subject: [PATCH 14/15] [RFC] pinctrl: sh-pfc: Absorb enum IDs in PINMUX_CFG_REG_VAR() macro
Message-Id: <20181213182714.26094-15-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20181213182714.26094-1-geert+renesas@glider.be>
In-Reply-To: <20181213182714.26094-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Currently the PINMUX_CFG_REG_VAR() macro must be followed by
initialization data, specifying all enum IDs.  Hence the macro itself
does not know anything about the enum IDs, preventing the macro from
performing any validation on it.

Make the macro accept the enum IDs as a parameter, and update all users.
Note that array data enclosed by curly braces cannot be passed to a
macro as a parameter, hence both the register field widths and the enum
IDs are wrapped using the GROUP() macro.

No functional changes.

Not-yet-signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This patch is incomplete!
It contains only the generic and r8a7795 parts.

 drivers/pinctrl/sh-pfc/pfc-emev2.c       |  47 +++++----
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c    | 111 +++++++++++---------
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c     |  81 +++++++++------
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c     |  89 +++++++++-------
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c     | 107 ++++++++++++--------
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c     | 123 ++++++++++++++---------
 drivers/pinctrl/sh-pfc/pfc-r8a7792.c     |  86 +++++++++-------
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c     |  98 ++++++++++--------
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c |  20 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c     |  21 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c     |  21 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c    |  21 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a77970.c    |   7 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77980.c    |   7 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c    |  14 +--
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c    |  13 +--
 drivers/pinctrl/sh-pfc/pfc-sh7734.c      |  81 +++++++++------
 drivers/pinctrl/sh-pfc/sh_pfc.h          |  25 +++--
 18 files changed, 571 insertions(+), 401 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
index 2c1d5d56628a1156..abf6e0167ef6053a 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7795.c
@@ -5669,8 +5669,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 #define F_(x, y)	x,
 #define FM(x)		FN_##x,
 	{ PINMUX_CFG_REG_VAR("MOD_SEL0", 0xe6060500, 32,
-			     3, 2, 3, 1, 1, 1, 1, 1, 2, 1,
-			     1, 2, 1, 1, 1, 2, 2, 1, 2, 3) {
+			     GROUP(3, 2, 3, 1, 1, 1, 1, 1, 2, 1, 1, 2,
+				   1, 1, 1, 2, 2, 1, 2, 3),
+			     GROUP(
 		MOD_SEL0_31_30_29
 		MOD_SEL0_28_27
 		MOD_SEL0_26_25_24
@@ -5691,11 +5692,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL0_5
 		MOD_SEL0_4_3
 		/* RESERVED 2, 1, 0 */
-		0, 0, 0, 0, 0, 0, 0, 0 }
+		0, 0, 0, 0, 0, 0, 0, 0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL1", 0xe6060504, 32,
-			     2, 3, 1, 2, 3, 1, 1, 2, 1,
-			     2, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1) {
+			     GROUP(2, 3, 1, 2, 3, 1, 1, 2, 1, 2, 1, 1,
+				   1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1),
+			     GROUP(
 		MOD_SEL1_31_30
 		MOD_SEL1_29_28_27
 		MOD_SEL1_26
@@ -5718,11 +5720,12 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		MOD_SEL1_3
 		MOD_SEL1_2
 		MOD_SEL1_1
-		MOD_SEL1_0 }
+		MOD_SEL1_0 ))
 	},
 	{ PINMUX_CFG_REG_VAR("MOD_SEL2", 0xe6060508, 32,
-			     1, 1, 1, 2, 1, 3, 1, 1, 1, 1, 1, 1, 1,
-			     4, 4, 4, 3, 1) {
+			     GROUP(1, 1, 1, 2, 1, 3, 1, 1, 1, 1, 1, 1,
+				   1, 4, 4, 4, 3, 1),
+			     GROUP(
 		MOD_SEL2_31
 		MOD_SEL2_30
 		MOD_SEL2_29
@@ -5749,7 +5752,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		0, 0, 0, 0, 0, 0, 0, 0,
 		/* RESERVED 3, 2, 1 */
 		0, 0, 0, 0, 0, 0, 0, 0,
-		MOD_SEL2_0 }
+		MOD_SEL2_0 ))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 84468bba9c30e675..584d58d954961018 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -138,16 +138,17 @@ struct pinmux_cfg_reg {
  *   - name: Register name (unused, for documentation purposes only)
  *   - r: Physical register address
  *   - r_width: Width of the register (in bits)
- *   - var_fw0, var_fwn...: List of widths of the register fields (in bits),
- *                          From left to right (i.e. MSB to LSB)
- * This macro must be followed by initialization data: For each register field
- * (from left to right, i.e. MSB to LSB), 2^var_fwi enum IDs must be specified,
- * one for each possible combination of the register field bit values.
+ *   - f_widths: List of widths of the register fields (in bits), from left
+ *               to right (i.e. MSB to LSB), wrapped using the GROUP() macro.
+ *   - ids: For each register field (from left to right, i.e. MSB to LSB),
+ *          2^f_widths[i] enum IDs must be specified, one for each possible
+ *          combination of the register field bit values, wrapped using the
+ *          GROUP() macro.
  */
-#define PINMUX_CFG_REG_VAR(name, r, r_width, var_fw0, var_fwn...) \
-	.reg = r, .reg_width = r_width,	\
-	.var_field_width = (const u8 []) { var_fw0, var_fwn, 0 }, \
-	.enum_ids = (const u16 [])
+#define PINMUX_CFG_REG_VAR(name, r, r_width, f_widths, ids)		\
+	.reg = r, .reg_width = r_width,					\
+	.var_field_width = (const u8 []) { f_widths, 0 },		\
+	.enum_ids = (const u16 []) { ids }
 
 struct pinmux_drive_reg_field {
 	u16 pin;
@@ -666,7 +667,9 @@ extern const struct sh_pfc_soc_info shx3_pinmux_info;
  */
 #define PORTCR(nr, reg)							\
 	{								\
-		PINMUX_CFG_REG_VAR("PORT" nr "CR", reg, 8, 2, 2, 1, 3) {\
+		PINMUX_CFG_REG_VAR("PORT" nr "CR", reg, 8,		\
+				   GROUP(2, 2, 1, 3),			\
+				   GROUP(				\
 			/* PULMD[1:0], handled by .set_bias() */	\
 			0, 0, 0, 0,					\
 			/* IE and OE */					\
@@ -678,7 +681,7 @@ extern const struct sh_pfc_soc_info shx3_pinmux_info;
 			PORT##nr##_FN2, PORT##nr##_FN3,			\
 			PORT##nr##_FN4, PORT##nr##_FN5,			\
 			PORT##nr##_FN6, PORT##nr##_FN7			\
-		}							\
+		))							\
 	}
 
 /*
-- 
2.17.1
