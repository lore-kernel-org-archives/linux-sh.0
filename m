From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Tue, 22 Sep 2015 09:12:49 +0000
Subject: [POC/RFC] pinctrl: sh-pfc: Use u16 to store pinmux enums
Message-Id: <1442913169-15557-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, linux-gpio@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

Use u16 instead of unsigned int to store pinmux enums, as they fit
easily in 16 bits.

This decreases the size of a (32-bit) shmobile_defconfig kernel
supporting 9 SoCs by 5780 bytes.

FIXME This doesn't make any difference on arm64, as all individual
      objects are always 8-byte aligned by the compiler.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is not the complete patch, as I don't want to spam you with a few
thousand lines of uninteresting changes.

 drivers/pinctrl/sh-pfc/pfc-emev2.c   |  72 ++--
 drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |  94 ++---
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c | 270 +++++++--------
 drivers/pinctrl/sh-pfc/pfc-r8a7778.c |  24 +-
 drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 300 ++++++++--------
 drivers/pinctrl/sh-pfc/pfc-r8a7790.c | 552 ++++++++++++++---------------
 drivers/pinctrl/sh-pfc/pfc-r8a7791.c | 653 ++++++++++++++++++-----------------
 drivers/pinctrl/sh-pfc/pfc-r8a7794.c | 374 ++++++++++----------
 drivers/pinctrl/sh-pfc/pfc-r8a7795.c | 402 ++++++++++-----------
 drivers/pinctrl/sh-pfc/pfc-sh73a0.c  | 326 ++++++++---------
 drivers/pinctrl/sh-pfc/sh_pfc.h      |  14 +-
 11 files changed, 1546 insertions(+), 1535 deletions(-)

diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
index 156f88d6af979874..b4587e3c6ffdd1de 100644
--- a/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
+++ b/drivers/pinctrl/sh-pfc/pfc-r8a7791.c
@@ -1701,7 +1701,7 @@ static const unsigned int audio_clk_a_pins[] = {
 	RCAR_GP_PIN(2, 28),
 };
 
-static const unsigned int audio_clk_a_mux[] = {
+static const u16 audio_clk_a_mux[] = {
 	AUDIO_CLKA_MARK,
 };
 
@@ -1710,7 +1710,7 @@ static const unsigned int audio_clk_b_pins[] = {
 	RCAR_GP_PIN(2, 29),
 };
 
-static const unsigned int audio_clk_b_mux[] = {
+static const u16 audio_clk_b_mux[] = {
 	AUDIO_CLKB_MARK,
 };
 
@@ -3982,12 +3982,13 @@ static const unsigned int usb1_pins[] = {
 	RCAR_GP_PIN(7, 25), /* PWEN */
 	RCAR_GP_PIN(6, 30), /* OVC */
 };
-static const unsigned int usb1_mux[] = {
+static const u16 usb1_mux[] = {
 	USB1_PWEN_MARK,
 	USB1_OVC_MARK,
 };
+
 /* - VIN0 ------------------------------------------------------------------- */
-static const union vin_data vin0_data_pins = {
+static const union vin_data_pins vin0_data_pins = {
 	.data24 = {
 		/* B */
 		RCAR_GP_PIN(4, 5), RCAR_GP_PIN(4, 6),
@@ -4006,7 +4007,7 @@ static const union vin_data vin0_data_pins = {
 		RCAR_GP_PIN(4, 27), RCAR_GP_PIN(4, 28),
 	},
 };
-static const union vin_data vin0_data_mux = {
+static const union vin_data_mux vin0_data_mux = {
 	.data24 = {
 		/* B */
 		VI0_DATA0_VI0_B0_MARK, VI0_DATA1_VI0_B1_MARK,
@@ -4039,7 +4040,7 @@ static const unsigned int vin0_data18_pins[] = {
 	RCAR_GP_PIN(4, 25), RCAR_GP_PIN(4, 26),
 	RCAR_GP_PIN(4, 27), RCAR_GP_PIN(4, 28),
 };
-static const unsigned int vin0_data18_mux[] = {
+static const u16 vin0_data18_mux[] = {
 	/* B */
 	VI0_DATA2_VI0_B2_MARK, VI0_DATA3_VI0_B3_MARK,
 	VI0_DATA4_VI0_B4_MARK, VI0_DATA5_VI0_B5_MARK,
diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h b/drivers/pinctrl/sh-pfc/sh_pfc.h
index e18e306b4ac276c7..565ffc6568db9203 100644
--- a/drivers/pinctrl/sh-pfc/sh_pfc.h
+++ b/drivers/pinctrl/sh-pfc/sh_pfc.h
@@ -48,7 +48,7 @@ struct sh_pfc_pin {
 struct sh_pfc_pin_group {
 	const char *name;
 	const unsigned int *pins;
-	const unsigned int *mux;
+	const u16 *mux;
 	unsigned int nr_pins;
 };
 
@@ -60,7 +60,7 @@ struct sh_pfc_pin_group {
 		.nr_pins = ARRAY_SIZE(n##_pins.data##s),	\
 	}
 
-union vin_data {
+union vin_data_pins {
 	unsigned int data24[24];
 	unsigned int data20[20];
 	unsigned int data16[16];
@@ -70,6 +70,16 @@ union vin_data {
 	unsigned int data4[4];
 };
 
+union vin_data_mux {
+	u16 data24[24];
+	u16 data20[20];
+	u16 data16[16];
+	u16 data12[12];
+	u16 data10[10];
+	u16 data8[8];
+	u16 data4[4];
+};
+
 #define SH_PFC_FUNCTION(n)				\
 	{						\
 		.name = #n,				\
-- 
1.9.1

