From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 10 Jan 2015 18:22:36 +0000
Subject: [PATCH 2/2] sh-pfc: r8a7791: add MLB+ pin group
Message-Id: <1771436.VTFsboh7mX@wasted.cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linus.walleij@linaro.org, linux-sh@vger.kernel.org, laurent.pinchart@ideasonboard.com, linux-gpio@vger.kernel.org

Add MLB+ 3-pin mode pin group to R8A7791 PFC driver.

Based on original patch by Andrey Gusakov <andrey.gusakov@cogentembedded.com>.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
The patch is against the 'devel' branch of Linus W.'s 'linux-pinctrl.git' repo.

 drivers/pinctrl/sh-pfc/pfc-r8a7791.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
=================================--- linux-pinctrl.orig/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ linux-pinctrl/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -2391,6 +2391,13 @@ static const unsigned int intc_irq3_pins
 static const unsigned int intc_irq3_mux[] = {
 	IRQ3_MARK,
 };
+/* - MLB+ ------------------------------------------------------------------- */
+static const unsigned int mlb_3pin_pins[] = {
+	RCAR_GP_PIN(7, 7), RCAR_GP_PIN(7, 8), RCAR_GP_PIN(7, 9),
+};
+static const unsigned int mlb_3pin_mux[] = {
+	MLB_CLK_MARK, MLB_SIG_MARK, MLB_DAT_MARK,
+};
 /* - MMCIF ------------------------------------------------------------------ */
 static const unsigned int mmc_data1_pins[] = {
 	/* D[0] */
@@ -4267,6 +4274,7 @@ static const struct sh_pfc_pin_group pin
 	SH_PFC_PIN_GROUP(intc_irq1),
 	SH_PFC_PIN_GROUP(intc_irq2),
 	SH_PFC_PIN_GROUP(intc_irq3),
+	SH_PFC_PIN_GROUP(mlb_3pin),
 	SH_PFC_PIN_GROUP(mmc_data1),
 	SH_PFC_PIN_GROUP(mmc_data4),
 	SH_PFC_PIN_GROUP(mmc_data8),
@@ -4648,6 +4656,10 @@ static const char * const intc_groups[]
 	"intc_irq3",
 };
 
+static const char * const mlb_groups[] = {
+	"mlb_3pin",
+};
+
 static const char * const mmc_groups[] = {
 	"mmc_data1",
 	"mmc_data4",
@@ -4972,6 +4984,7 @@ static const struct sh_pfc_function pinm
 	SH_PFC_FUNCTION(i2c7),
 	SH_PFC_FUNCTION(i2c8),
 	SH_PFC_FUNCTION(intc),
+	SH_PFC_FUNCTION(mlb),
 	SH_PFC_FUNCTION(mmc),
 	SH_PFC_FUNCTION(msiof0),
 	SH_PFC_FUNCTION(msiof1),

