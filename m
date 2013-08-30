From: Ulrich Hecht <ulrich.hecht@gmail.com>
Date: Fri, 30 Aug 2013 12:37:44 +0000
Subject: [RFC 10/10] ARM: shmobile: r8a7790: lager: HDMI output via DU and ADV7511
Message-Id: <1377866264-21110-11-git-send-email-ulrich.hecht@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

This builds and runs but is unlikely to provide useful output as I do not
have physical access to a Lager board yet.

Signed-off-by: Ulrich Hecht <ulrich.hecht@gmail.com>
---
 arch/arm/mach-shmobile/board-lager.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index c6b5f21..edd0f3e 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -40,12 +40,20 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
+#include "../../../drivers/gpu/drm/i2c/adv7511.h"
+
+static struct i2c_client *hdmi_encoder = NULL;
+
 /* DU */
 static struct rcar_du_encoder_data lager_du_encoders[] = {
 	{
 		.type = RCAR_DU_ENCODER_VGA,
 		.output = RCAR_DU_OUTPUT_DPAD0,
 	}, {
+		.type = RCAR_DU_ENCODER_HDMI,
+		.output = RCAR_DU_OUTPUT_LVDS0,
+		.slave = &hdmi_encoder,
+	}, {
 		.type = RCAR_DU_ENCODER_NONE,
 		.output = RCAR_DU_OUTPUT_LVDS1,
 		.connector.lvds.panel = {
@@ -199,6 +207,21 @@ static const struct pinctrl_map lager_pinctrl_map[] = {
 				  "intc_irq0", "intc"),
 };
 
+static struct adv7511_link_config adv7511_data = {
+	/* random guesses */
+	.input_style	= ADV7511_INPUT_STYLE2,
+	.id		= ADV7511_INPUT_ID_16_20_24BIT_YCbCr422_SEPARATE_SYNC,
+	.sync_pulse	= ADV7511_INPUT_SYNC_PULSE_NONE,
+	.bit_justification	= ADV7511_INPUT_BIT_JUSTIFICATION_RIGHT,
+	.up_conversion	= ADV7511_UP_CONVERSION_ZERO_ORDER,
+	.timing_gen_seq	= ADV7511_TIMING_GEN_SEQ_SYN_ADJ_FIRST,
+	.vsync_polarity	= ADV7511_SYNC_POLARITY_HIGH,
+	.hsync_polarity = ADV7511_SYNC_POLARITY_HIGH,
+	.tmds_clock_inversion	= true,
+	.clock_delay	= ADV7511_INPUT_CLOCK_DELAY_NONE,
+	.client		= &hdmi_encoder,
+};
+
 static struct i2c_board_info i2c2_devices[] = {
 	/* ak4643 at 0x12: no driver */
 	{
@@ -206,6 +229,7 @@ static struct i2c_board_info i2c2_devices[] = {
 	},
 	{
 		I2C_BOARD_INFO("adv7511", 0x39),
+		.platform_data = &adv7511_data,
 	},
 	/* adv7612 at 0x4c: no driver */
 };
-- 
1.8.1.4

