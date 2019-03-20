From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 20 Mar 2019 10:21:39 +0000
Subject: [PATCH v3 08/10 PARTIAL] pinctrl: sh-pfc: Absorb enum IDs in PINMUX_DATA_REG() macro
Message-Id: <20190320102141.19316-9-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <20190320102141.19316-1-geert+renesas@glider.be>
In-Reply-To: <20190320102141.19316-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Currently the PINMUX_DATA_REG() macro must be followed by initialization
data, specifying all enum IDs.  Hence the macro itself does not know
anything about the enum IDs, preventing the macro from performing any
validation on it.

Make the macro accept the enum IDs as a parameter, and update all users.
Note that array data enclosed by curly braces cannot be passed to a
macro as a parameter, hence the enum IDs are wrapped using the GROUP()
macro.

No functional changes.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This patch is incomplete!
It contains only the generic and r8a73a4 parts.

v3:
  - No changes,

v2:
  - New.
---
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |  44 ++++++------
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c |  40 +++++------
 drivers/pinctrl/sh-pfc/pfc-sh7203.c  |  28 ++++----
 drivers/pinctrl/sh-pfc/pfc-sh7264.c  |  48 ++++++-------
 drivers/pinctrl/sh-pfc/pfc-sh7269.c  |  48 ++++++-------
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  |  40 +++++------
 drivers/pinctrl/sh-pfc/pfc-sh7720.c  |  72 +++++++++----------
 drivers/pinctrl/sh-pfc/pfc-sh7722.c  |  92 ++++++++++++------------
 drivers/pinctrl/sh-pfc/pfc-sh7723.c  |  92 ++++++++++++------------
 drivers/pinctrl/sh-pfc/pfc-sh7724.c  |  92 ++++++++++++------------
 drivers/pinctrl/sh-pfc/pfc-sh7734.c  |  14 ++--
 drivers/pinctrl/sh-pfc/pfc-sh7757.c  | 104 +++++++++++++--------------
 drivers/pinctrl/sh-pfc/pfc-sh7785.c  |  64 ++++++++---------
 drivers/pinctrl/sh-pfc/pfc-sh7786.c  |  36 +++++-----
 drivers/pinctrl/sh-pfc/pfc-shx3.c    |  16 ++---
 drivers/pinctrl/sh-pfc/sh_pfc.h      |  10 +--
 16 files changed, 420 insertions(+), 420 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
index f07b33c614db2a9e..bf12849defdb74a5 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
@@ -2464,7 +2464,7 @@ static const struct pinmux_cfg_reg pinmux_config_regs[] = {
 
 static const struct pinmux_data_reg pinmux_data_regs[] = {
 
-	{ PINMUX_DATA_REG("PORTL031_000DR", 0xe6054000, 32) {
+	{ PINMUX_DATA_REG("PORTL031_000DR", 0xe6054000, 32, GROUP(
 			0, PORT30_DATA, PORT29_DATA, PORT28_DATA,
 			PORT27_DATA, PORT26_DATA, PORT25_DATA, PORT24_DATA,
 			PORT23_DATA, PORT22_DATA, PORT21_DATA, PORT20_DATA,
@@ -2473,9 +2473,9 @@ static const struct pinmux_data_reg pinmux_data_regs[] = {
 			PORT11_DATA, PORT10_DATA, PORT9_DATA, PORT8_DATA,
 			PORT7_DATA, PORT6_DATA, PORT5_DATA, PORT4_DATA,
 			PORT3_DATA, PORT2_DATA, PORT1_DATA, PORT0_DATA,
-		}
+		))
 	},
-	{ PINMUX_DATA_REG("PORTD063_032DR", 0xe6055000, 32) {
+	{ PINMUX_DATA_REG("PORTD063_032DR", 0xe6055000, 32, GROUP(
 			0, 0, 0, 0,
 			0, 0, 0, 0,
 			0, 0, 0, 0,
@@ -2484,9 +2484,9 @@ static const struct pinmux_data_reg pinmux_data_regs[] = {
 			0, 0, 0, PORT40_DATA,
 			PORT39_DATA, PORT38_DATA, PORT37_DATA, PORT36_DATA,
 			PORT35_DATA, PORT34_DATA, PORT33_DATA, PORT32_DATA,
-		}
+		))
 	},
-	{ PINMUX_DATA_REG("PORTL095_064DR", 0xe6054004, 32) {
+	{ PINMUX_DATA_REG("PORTL095_064DR", 0xe6054004, 32, GROUP(
 			0, 0, 0, 0,
 			0, 0, 0, 0,
 			0, 0, PORT85_DATA, PORT84_DATA,
@@ -2495,9 +2495,9 @@ static const struct pinmux_data_reg pinmux_data_regs[] = {
 			PORT75_DATA, PORT74_DATA, PORT73_DATA, PORT72_DATA,
 			PORT71_DATA, PORT70_DATA, PORT69_DATA, PORT68_DATA,
 			PORT67_DATA, PORT66_DATA, PORT65_DATA, PORT64_DATA,
-		}
+		))
 	},
-	{ PINMUX_DATA_REG("PORTD127_096DR", 0xe6055004, 32) {
+	{ PINMUX_DATA_REG("PORTD127_096DR", 0xe6055004, 32, GROUP(
 			0, PORT126_DATA, PORT125_DATA, PORT124_DATA,
 			PORT123_DATA, PORT122_DATA, PORT121_DATA, PORT120_DATA,
 			PORT119_DATA, PORT118_DATA, PORT117_DATA, PORT116_DATA,
@@ -2506,9 +2506,9 @@ static const struct pinmux_data_reg pinmux_data_regs[] = {
 			PORT107_DATA, PORT106_DATA, PORT105_DATA, PORT104_DATA,
 			PORT103_DATA, PORT102_DATA, PORT101_DATA, PORT100_DATA,
 			PORT99_DATA, PORT98_DATA, PORT97_DATA, PORT96_DATA,
-		}
+		))
 	},
-	{ PINMUX_DATA_REG("PORTD159_128DR", 0xe6055008, 32) {
+	{ PINMUX_DATA_REG("PORTD159_128DR", 0xe6055008, 32, GROUP(
 			0, 0, 0, 0,
 			0, 0, 0, 0,
 			0, 0, 0, 0,
@@ -2517,9 +2517,9 @@ static const struct pinmux_data_reg pinmux_data_regs[] = {
 			0, 0, 0, 0,
 			0, PORT134_DATA, PORT133_DATA, PORT132_DATA,
 			PORT131_DATA, PORT130_DATA, PORT129_DATA, PORT128_DATA,
-		}
+		))
 	},
-	{ PINMUX_DATA_REG("PORTR191_160DR", 0xe6056000, 32) {
+	{ PINMUX_DATA_REG("PORTR191_160DR", 0xe6056000, 32, GROUP(
 			0, 0, 0, 0,
 			0, 0, 0, 0,
 			0, 0, 0, 0,
@@ -2528,9 +2528,9 @@ static const struct pinmux_data_reg pinmux_data_regs[] = {
 			PORT171_DATA, PORT170_DATA, PORT169_DATA, PORT168_DATA,
 			PORT167_DATA, PORT166_DATA, PORT165_DATA, PORT164_DATA,
 			PORT163_DATA, PORT162_DATA, PORT161_DATA, PORT160_DATA,
-		}
+		))
 	},
-	{ PINMUX_DATA_REG("PORTR223_192DR", 0xe6056004, 32) {
+	{ PINMUX_DATA_REG("PORTR223_192DR", 0xe6056004, 32, GROUP(
 			0, PORT222_DATA, PORT221_DATA, PORT220_DATA,
 			PORT219_DATA, PORT218_DATA, PORT217_DATA, PORT216_DATA,
 			PORT215_DATA, PORT214_DATA, PORT213_DATA, PORT212_DATA,
@@ -2539,9 +2539,9 @@ static const struct pinmux_data_reg pinmux_data_regs[] = {
 			PORT203_DATA, PORT202_DATA, PORT201_DATA, PORT200_DATA,
 			PORT199_DATA, PORT198_DATA, PORT197_DATA, PORT196_DATA,
 			PORT195_DATA, PORT194_DATA, PORT193_DATA, PORT192_DATA,
-		}
+		))
 	},
-	{ PINMUX_DATA_REG("PORTR255_224DR", 0xe6056008, 32) {
+	{ PINMUX_DATA_REG("PORTR255_224DR", 0xe6056008, 32, GROUP(
 			0, 0, 0, 0,
 			0, PORT250_DATA, PORT249_DATA, PORT248_DATA,
 			PORT247_DATA, PORT246_DATA, PORT245_DATA, PORT244_DATA,
@@ -2550,9 +2550,9 @@ static const struct pinmux_data_reg pinmux_data_regs[] = {
 			PORT235_DATA, PORT234_DATA, PORT233_DATA, PORT232_DATA,
 			PORT231_DATA, PORT230_DATA, PORT229_DATA, PORT228_DATA,
 			PORT227_DATA, PORT226_DATA, PORT225_DATA, PORT224_DATA,
-		}
+		))
 	},
-	{ PINMUX_DATA_REG("PORTR287_256DR", 0xe605600C, 32) {
+	{ PINMUX_DATA_REG("PORTR287_256DR", 0xe605600C, 32, GROUP(
 			0, 0, 0, 0,
 			PORT283_DATA, PORT282_DATA, PORT281_DATA, PORT280_DATA,
 			PORT279_DATA, PORT278_DATA, PORT277_DATA, PORT276_DATA,
@@ -2561,9 +2561,9 @@ static const struct pinmux_data_reg pinmux_data_regs[] = {
 			PORT267_DATA, PORT266_DATA, PORT265_DATA, PORT264_DATA,
 			PORT263_DATA, PORT262_DATA, PORT261_DATA, PORT260_DATA,
 			PORT259_DATA, PORT258_DATA, PORT257_DATA, PORT256_DATA,
-		}
+		))
 	},
-	{ PINMUX_DATA_REG("PORTU319_288DR", 0xe6057000, 32) {
+	{ PINMUX_DATA_REG("PORTU319_288DR", 0xe6057000, 32, GROUP(
 			0, 0, 0, 0,
 			0, 0, 0, 0,
 			0, 0, 0, PORT308_DATA,
@@ -2572,9 +2572,9 @@ static const struct pinmux_data_reg pinmux_data_regs[] = {
 			PORT299_DATA, PORT298_DATA, PORT297_DATA, PORT296_DATA,
 			PORT295_DATA, PORT294_DATA, PORT293_DATA, PORT292_DATA,
 			PORT291_DATA, PORT290_DATA, PORT289_DATA, PORT288_DATA,
-		}
+		))
 	},
-	{ PINMUX_DATA_REG("PORTU351_320DR", 0xe6057004, 32) {
+	{ PINMUX_DATA_REG("PORTU351_320DR", 0xe6057004, 32, GROUP(
 			0, 0, 0, 0,
 			0, 0, 0, 0,
 			0, 0, 0, 0,
@@ -2583,7 +2583,7 @@ static const struct pinmux_data_reg pinmux_data_regs[] = {
 			0, 0, PORT329_DATA, PORT328_DATA,
 			PORT327_DATA, PORT326_DATA, PORT325_DATA, PORT324_DATA,
 			PORT323_DATA, PORT322_DATA, PORT321_DATA, PORT320_DATA,
-		}
+		))
 	},
 	{ },
 };
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index 95eb51168ed83856..57e13b623b2e87ec 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -192,12 +192,12 @@ struct pinmux_data_reg {
  *   - name: Register name (unused, for documentation purposes only)
  *   - r: Physical register address
  *   - r_width: Width of the register (in bits)
- * This macro must be followed by initialization data: For each register bit
- * (from left to right, i.e. MSB to LSB), one enum ID must be specified.
+ *   - ids: For each register bit (from left to right, i.e. MSB to LSB), one
+ *          enum ID must be specified, all wrapped using the GROUP() macro.
  */
-#define PINMUX_DATA_REG(name, r, r_width) \
-	.reg = r, .reg_width = r_width,	\
-	.enum_ids = (const u16 [r_width]) \
+#define PINMUX_DATA_REG(name, r, r_width, ids)				\
+	.reg = r, .reg_width = r_width,					\
+	.enum_ids = (const u16 [r_width]) { ids }
 
 struct pinmux_irq {
 	const short *gpios;
-- 
2.17.1
