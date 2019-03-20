From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 20 Mar 2019 10:21:37 +0000
Subject: [PATCH v3 06/10 PARTIAL] pinctrl: sh-pfc: Absorb enum IDs in PINMUX_CFG_REG() macro
Message-Id: <20190320102141.19316-7-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20190320102141.19316-1-geert+renesas@glider.be>
In-Reply-To: <20190320102141.19316-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Currently the PINMUX_CFG_REG() macro must be followed by initialization
data, specifying all enum IDs.  Hence the macro itself does not know
anything about the enum IDs, preventing the macro from performing any
validation on it.

Make the macro accept the enum IDs as a parameter, and update all users.
Note that array data enclosed by curly braces cannot be passed to a
macro as a parameter, hence the enum IDs are wrapped using a new macro
GROUPS().

No functional changes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This patch is incomplete!
It contains only the generic and r8a7791 parts.

v3:
  - Drop change that belonged in the next patch, and broke bisection,

v2:
  - Improve comment.
---
 drivers/pinctrl/sh-pfc/pfc-emev2.c       |  20 +--
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c     |  20 +--
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c     |  16 +-
 drivers/pinctrl/sh-pfc/pfc-r8a77470.c    |  24 +--
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c     |  20 +--
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c     |  28 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c     |  24 +--
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c     |  32 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7792.c     |  48 +++---
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c     |  28 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a7795-es1.c | 104 ++++++------
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c     | 108 ++++++------
 drivers/pinctrl/sh-pfc/pfc-r8a7796.c     | 108 ++++++------
 drivers/pinctrl/sh-pfc/pfc-r8a77965.c    | 108 ++++++------
 drivers/pinctrl/sh-pfc/pfc-r8a77970.c    |  60 +++----
 drivers/pinctrl/sh-pfc/pfc-r8a77980.c    |  68 ++++----
 drivers/pinctrl/sh-pfc/pfc-r8a77990.c    |  92 +++++-----
 drivers/pinctrl/sh-pfc/pfc-r8a77995.c    |  84 +++++-----
 drivers/pinctrl/sh-pfc/pfc-sh7203.c      | 124 +++++++-------
 drivers/pinctrl/sh-pfc/pfc-sh7264.c      | 184 ++++++++++----------
 drivers/pinctrl/sh-pfc/pfc-sh7269.c      | 204 +++++++++++------------
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c      |  12 +-
 drivers/pinctrl/sh-pfc/pfc-sh7720.c      |  72 ++++----
 drivers/pinctrl/sh-pfc/pfc-sh7722.c      | 128 +++++++-------
 drivers/pinctrl/sh-pfc/pfc-sh7723.c      | 108 ++++++------
 drivers/pinctrl/sh-pfc/pfc-sh7724.c      | 112 ++++++-------
 drivers/pinctrl/sh-pfc/pfc-sh7734.c      |  43 ++---
 drivers/pinctrl/sh-pfc/pfc-sh7757.c      | 140 ++++++++--------
 drivers/pinctrl/sh-pfc/pfc-sh7785.c      |  72 ++++----
 drivers/pinctrl/sh-pfc/pfc-sh7786.c      |  44 ++---
 drivers/pinctrl/sh-pfc/pfc-shx3.c        |  16 +-
 drivers/pinctrl/sh-pfc/sh_pfc.h          |  14 +-
 32 files changed, 1137 insertions(+), 1128 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index d21a520695db1ae4..b96c9a207cf8971d 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -5428,7 +5428,7 @@ static const struct {
 };
 
 static const struct pinmux_cfg_reg pinmux_config_regs[] = {
-	{ PINMUX_CFG_REG("GPSR0", 0xE6060004, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR0", 0xE6060004, 32, 1, GROUP(
 		GP_0_31_FN, FN_IP1_22_20,
 		GP_0_30_FN, FN_IP1_19_17,
 		GP_0_29_FN, FN_IP1_16_14,
@@ -5460,9 +5460,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_0_3_FN, FN_IP0_3,
 		GP_0_2_FN, FN_IP0_2,
 		GP_0_1_FN, FN_IP0_1,
-		GP_0_0_FN, FN_IP0_0, }
+		GP_0_0_FN, FN_IP0_0, ))
 	},
-	{ PINMUX_CFG_REG("GPSR1", 0xE6060008, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR1", 0xE6060008, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -5494,9 +5494,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_1_3_FN, FN_IP2_2_0,
 		GP_1_2_FN, FN_IP1_31_29,
 		GP_1_1_FN, FN_IP1_28_26,
-		GP_1_0_FN, FN_IP1_25_23, }
+		GP_1_0_FN, FN_IP1_25_23, ))
 	},
-	{ PINMUX_CFG_REG("GPSR2", 0xE606000C, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR2", 0xE606000C, 32, 1, GROUP(
 		GP_2_31_FN, FN_IP6_7_6,
 		GP_2_30_FN, FN_IP6_5_3,
 		GP_2_29_FN, FN_IP6_2_0,
@@ -5528,9 +5528,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_2_3_FN, FN_IP4_4_2,
 		GP_2_2_FN, FN_IP4_1_0,
 		GP_2_1_FN, FN_IP3_30_28,
-		GP_2_0_FN, FN_IP3_27_25 }
+		GP_2_0_FN, FN_IP3_27_25 ))
 	},
-	{ PINMUX_CFG_REG("GPSR3", 0xE6060010, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR3", 0xE6060010, 32, 1, GROUP(
 		GP_3_31_FN, FN_IP9_18_17,
 		GP_3_30_FN, FN_IP9_16,
 		GP_3_29_FN, FN_IP9_15_13,
@@ -5562,9 +5562,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_3_3_FN, FN_IP7_12_11,
 		GP_3_2_FN, FN_IP7_10_9,
 		GP_3_1_FN, FN_IP7_8_6,
-		GP_3_0_FN, FN_IP7_5_3 }
+		GP_3_0_FN, FN_IP7_5_3 ))
 	},
-	{ PINMUX_CFG_REG("GPSR4", 0xE6060014, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR4", 0xE6060014, 32, 1, GROUP(
 		GP_4_31_FN, FN_IP15_5_4,
 		GP_4_30_FN, FN_IP15_3_2,
 		GP_4_29_FN, FN_IP15_1_0,
@@ -5596,9 +5596,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_4_3_FN, FN_IP9_24_23,
 		GP_4_2_FN, FN_IP9_22_21,
 		GP_4_1_FN, FN_IP9_20_19,
-		GP_4_0_FN, FN_VI0_CLK }
+		GP_4_0_FN, FN_VI0_CLK ))
 	},
-	{ PINMUX_CFG_REG("GPSR5", 0xE6060018, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR5", 0xE6060018, 32, 1, GROUP(
 		GP_5_31_FN, FN_IP3_24_22,
 		GP_5_30_FN, FN_IP13_9_7,
 		GP_5_29_FN, FN_IP13_6_5,
@@ -5630,9 +5630,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_5_3_FN, FN_IP11_18_17,
 		GP_5_2_FN, FN_IP11_16_15,
 		GP_5_1_FN, FN_IP11_14_12,
-		GP_5_0_FN, FN_IP11_11_9 }
+		GP_5_0_FN, FN_IP11_11_9 ))
 	},
-	{ PINMUX_CFG_REG("GPSR6", 0xE606001C, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR6", 0xE606001C, 32, 1, GROUP(
 		GP_6_31_FN, FN_DU0_DOTCLKIN,
 		GP_6_30_FN, FN_USB1_OVC,
 		GP_6_29_FN, FN_IP14_31_29,
@@ -5664,9 +5664,9 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_6_3_FN, FN_IP13_13,
 		GP_6_2_FN, FN_IP13_12,
 		GP_6_1_FN, FN_IP13_11,
-		GP_6_0_FN, FN_IP13_10 }
+		GP_6_0_FN, FN_IP13_10 ))
 	},
-	{ PINMUX_CFG_REG("GPSR7", 0xE6060074, 32, 1) {
+	{ PINMUX_CFG_REG("GPSR7", 0xE6060074, 32, 1, GROUP(
 		0, 0,
 		0, 0,
 		0, 0,
@@ -5698,7 +5698,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 		GP_7_3_FN, FN_IP15_26_24,
 		GP_7_2_FN, FN_IP15_23_21,
 		GP_7_1_FN, FN_IP15_20_18,
-		GP_7_0_FN, FN_IP15_17_15 }
+		GP_7_0_FN, FN_IP15_17_15 ))
 	},
 	{ PINMUX_CFG_REG_VAR("IPSR0", 0xE6060020, 32,
 			     1, 2, 2, 2, 2, 2, 2, 3, 1, 1, 1, 1, 1, 1, 1, 1,
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 754e325d0bdbb48d..3848c104543d383e 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -115,20 +115,24 @@ struct pinmux_cfg_reg {
 	const u8 *var_field_width;
 };
 
+#define GROUP(...)	__VA_ARGS__
+
 /*
  * Describe a config register consisting of several fields of the same width
  *   - name: Register name (unused, for documentation purposes only)
  *   - r: Physical register address
  *   - r_width: Width of the register (in bits)
  *   - f_width: Width of the fixed-width register fields (in bits)
- * This macro must be followed by initialization data: For each register field
- * (from left to right, i.e. MSB to LSB), 2^f_width enum IDs must be specified,
- * one for each possible combination of the register field bit values.
+ *   - ids: For each register field (from left to right, i.e. MSB to LSB),
+ *          2^f_width enum IDs must be specified, one for each possible
+ *          combination of the register field bit values, all wrapped using
+ *          the GROUP() macro.
  */
-#define PINMUX_CFG_REG(name, r, r_width, f_width) \
+#define PINMUX_CFG_REG(name, r, r_width, f_width, ids)			\
 	.reg = r, .reg_width = r_width,					\
 	.field_width = f_width + BUILD_BUG_ON_ZERO(r_width % f_width),	\
-	.enum_ids = (const u16 [(r_width / f_width) * (1 << f_width)])
+	.enum_ids = (const u16 [(r_width / f_width) * (1 << f_width)])	\
+		{ ids }
 
 /*
  * Describe a config register consisting of several fields of different widths
-- 
2.17.1
