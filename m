From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 14 May 2015 10:48:54 +0000
Subject: [PATCH] sh-pfc: r8a7790: Add PWM pin groups and functions
Message-Id: <1431600534-4360-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: laurent.pinchart@ideasonboard.com, linus.walleij@linaro.org
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 This patch is based on linux-pinctrl.git / for-next branch.
 (commit id = 1050c8f7b3f8f97ed3514ce800e7206207d5bbf9)

 I will write a patch for r8a7791 PWM later because I'm not sure that
 this patch is good or not.

 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 101 +++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
index 22a5470..baab81e 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7790.c
@@ -2664,6 +2664,61 @@ static const unsigned int msiof3_tx_b_pins[] = {
 static const unsigned int msiof3_tx_b_mux[] = {
 	MSIOF3_TXD_B_MARK,
 };
+/* - PWM -------------------------------------------------------------------- */
+static const unsigned int pwm0_pins[] = {
+	RCAR_GP_PIN(5, 29),
+};
+static const unsigned int pwm0_mux[] = {
+	PWM0_MARK,
+};
+static const unsigned int pwm0_b_pins[] = {
+	RCAR_GP_PIN(4, 30),
+};
+static const unsigned int pwm0_b_mux[] = {
+	PWM0_B_MARK,
+};
+static const unsigned int pwm1_pins[] = {
+	RCAR_GP_PIN(5, 30),
+};
+static const unsigned int pwm1_mux[] = {
+	PWM1_MARK,
+};
+static const unsigned int pwm1_b_pins[] = {
+	RCAR_GP_PIN(4, 31),
+};
+static const unsigned int pwm1_b_mux[] = {
+	PWM1_B_MARK,
+};
+static const unsigned int pwm2_pins[] = {
+	RCAR_GP_PIN(5, 31),
+};
+static const unsigned int pwm2_mux[] = {
+	PWM2_MARK,
+};
+static const unsigned int pwm3_pins[] = {
+	RCAR_GP_PIN(0, 16),
+};
+static const unsigned int pwm3_mux[] = {
+	PWM3_MARK,
+};
+static const unsigned int pwm4_pins[] = {
+	RCAR_GP_PIN(0, 17),
+};
+static const unsigned int pwm4_mux[] = {
+	PWM4_MARK,
+};
+static const unsigned int pwm5_pins[] = {
+	RCAR_GP_PIN(0, 18),
+};
+static const unsigned int pwm5_mux[] = {
+	PWM5_MARK,
+};
+static const unsigned int pwm6_pins[] = {
+	RCAR_GP_PIN(0, 19),
+};
+static const unsigned int pwm6_mux[] = {
+	PWM6_MARK,
+};
 /* - QSPI ------------------------------------------------------------------- */
 static const unsigned int qspi_ctrl_pins[] = {
 	/* SPCLK, SSL */
@@ -4008,6 +4063,15 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(msiof3_sync_b),
 	SH_PFC_PIN_GROUP(msiof3_rx_b),
 	SH_PFC_PIN_GROUP(msiof3_tx_b),
+	SH_PFC_PIN_GROUP(pwm0),
+	SH_PFC_PIN_GROUP(pwm0_b),
+	SH_PFC_PIN_GROUP(pwm1),
+	SH_PFC_PIN_GROUP(pwm1_b),
+	SH_PFC_PIN_GROUP(pwm2),
+	SH_PFC_PIN_GROUP(pwm3),
+	SH_PFC_PIN_GROUP(pwm4),
+	SH_PFC_PIN_GROUP(pwm5),
+	SH_PFC_PIN_GROUP(pwm6),
 	SH_PFC_PIN_GROUP(qspi_ctrl),
 	SH_PFC_PIN_GROUP(qspi_data2),
 	SH_PFC_PIN_GROUP(qspi_data4),
@@ -4364,6 +4428,36 @@ static const char * const msiof3_groups[] = {
 	"msiof3_tx_b",
 };
 
+static const char * const pwm0_groups[] = {
+	"pwm0",
+	"pwm0_b",
+};
+
+static const char * const pwm1_groups[] = {
+	"pwm1",
+	"pwm1_b",
+};
+
+static const char * const pwm2_groups[] = {
+	"pwm2",
+};
+
+static const char * const pwm3_groups[] = {
+	"pwm3",
+};
+
+static const char * const pwm4_groups[] = {
+	"pwm4",
+};
+
+static const char * const pwm5_groups[] = {
+	"pwm5",
+};
+
+static const char * const pwm6_groups[] = {
+	"pwm6",
+};
+
 static const char * const qspi_groups[] = {
 	"qspi_ctrl",
 	"qspi_data2",
@@ -4621,6 +4715,13 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(msiof1),
 	SH_PFC_FUNCTION(msiof2),
 	SH_PFC_FUNCTION(msiof3),
+	SH_PFC_FUNCTION(pwm0),
+	SH_PFC_FUNCTION(pwm1),
+	SH_PFC_FUNCTION(pwm2),
+	SH_PFC_FUNCTION(pwm3),
+	SH_PFC_FUNCTION(pwm4),
+	SH_PFC_FUNCTION(pwm5),
+	SH_PFC_FUNCTION(pwm6),
 	SH_PFC_FUNCTION(qspi),
 	SH_PFC_FUNCTION(scif0),
 	SH_PFC_FUNCTION(scif1),
-- 
1.9.1

