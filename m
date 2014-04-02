From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Wed, 02 Apr 2014 11:46:40 +0000
Subject: [WIP 2/7] DRM: Add adv7511 encoder driver
Message-Id: <1396439205-26199-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

This patch adds a driver for the Analog Devices adv7511. The adv7511 is
a standalone HDMI transmitter chip. It features a HDMI output interface
on one end and video and audio input interfaces on the other.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

---

This commit incorporates the following commits.

DRM: adv7511: Sync to latest version
DRM: adv7511: Fix calculation and setting of CTS
DRM: adv7511: Write status word frequency and word len registers
adv7511: Remove some debug printks
Merge branch 'xcomm_zynq' into xcomm_zynq_3_5
Sync adv7511 and axi-hdmi driver to latest version
drm:adv7511: Re-add module information
DRM: adv7511: Don't use raw_edid to pass edid data
drm: adv7511: Ignore the csc scaling factor when the csc is disabled
drm: adv7511: Check if edid is NULL before duplicating it
drm: adv7511: Include the extension sections when duplicating the edid
DRM: adv7511: Work around off-by-one hardware bug
DRM: adv7511: Make embedded sync generator setup more robust
DRM: adv7511_audio: Fix typo
DRM: adv7511: Add powerdown gpio support
drm: adv7511: Fix use after free
DRM: adv7511: Properly initialize dpms_mode and status
DRM: adv7511: Avoid uneccessary disconnected events
drm: adv7511: Fix adv7511 encoder driver
drm: adv7511: Fix kernel-doc format
drm: adv7511: Fix adv7511_parse_dt()
drm: adv7511: Add the rgb format flag to adv7511_link_config
drm: adv7511: Configure CSC in adv7511_set_config()
drm: adv7511: Add adv7511_set_config_csc()
drm: adv7511: Configure the csc when getting modes
drm: adv7511: Add adv7511_encoder_mode_valid() function
drm: adv7511: Don't export adv7511_get_edid function
drm: adv7511: Mark the revision register as volatile
drm: adv7511: Initialize work queue before requesting IRQ
drm: adv7511: Remove trailing whitespaces
drm: adv7511: Remove audio support
drm: adv7511: Remove DRM slave encoder .set_config operation
drm: adv7511: Make the adv7511_packet_(enable|disable) functions static
drm: adv7511: Move Kconfig entry to drivers/gpu/drm/i2c/Kconfig
---
 drivers/gpu/drm/i2c/Kconfig       |   6 +
 drivers/gpu/drm/i2c/Makefile      |   3 +
 drivers/gpu/drm/i2c/adv7511_drv.c | 995 ++++++++++++++++++++++++++++++++++++++
 include/drm/i2c/adv7511.h         | 456 +++++++++++++++++
 4 files changed, 1460 insertions(+)
 create mode 100644 drivers/gpu/drm/i2c/adv7511_drv.c
 create mode 100644 include/drm/i2c/adv7511.h

diff --git a/drivers/gpu/drm/i2c/Kconfig b/drivers/gpu/drm/i2c/Kconfig
index 4d341db..22c7ed6 100644
--- a/drivers/gpu/drm/i2c/Kconfig
+++ b/drivers/gpu/drm/i2c/Kconfig
@@ -1,6 +1,12 @@
 menu "I2C encoder or helper chips"
      depends on DRM && DRM_KMS_HELPER && I2C
 
+config DRM_I2C_ADV7511
+	tristate "AV7511 encoder"
+	select REGMAP_I2C
+	help
+	  Support for the Analog Device ADV7511(W) and ADV7513 HDMI encoders.
+
 config DRM_I2C_CH7006
 	tristate "Chrontel ch7006 TV encoder"
 	default m if DRM_NOUVEAU
diff --git a/drivers/gpu/drm/i2c/Makefile b/drivers/gpu/drm/i2c/Makefile
index 43aa33b..d3abee3 100644
--- a/drivers/gpu/drm/i2c/Makefile
+++ b/drivers/gpu/drm/i2c/Makefile
@@ -1,5 +1,8 @@
 ccflags-y := -Iinclude/drm
 
+adv7511-y := adv7511_drv.o
+obj-$(CONFIG_DRM_I2C_ADV7511) += adv7511.o
+
 ch7006-y := ch7006_drv.o ch7006_mode.o
 obj-$(CONFIG_DRM_I2C_CH7006) += ch7006.o
 
diff --git a/drivers/gpu/drm/i2c/adv7511_drv.c b/drivers/gpu/drm/i2c/adv7511_drv.c
new file mode 100644
index 0000000..274242a
--- /dev/null
+++ b/drivers/gpu/drm/i2c/adv7511_drv.c
@@ -0,0 +1,995 @@
+/*
+ * Analog Devices ADV7511 HDMI transmitter driver
+ *
+ * Copyright 2012 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#include <linux/device.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+
+#include <drm/drmP.h>
+#include <drm/drm_crtc_helper.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_encoder_slave.h>
+
+#include <drm/i2c/adv7511.h>
+
+static const uint8_t adv7511_register_defaults[] = {
+	0x12, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 00 */
+	0x00, 0x00, 0x01, 0x0e, 0xbc, 0x18, 0x01, 0x13,
+	0x25, 0x37, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 10 */
+	0x46, 0x62, 0x04, 0xa8, 0x00, 0x00, 0x1c, 0x84,
+	0x1c, 0xbf, 0x04, 0xa8, 0x1e, 0x70, 0x02, 0x1e, /* 20 */
+	0x00, 0x00, 0x04, 0xa8, 0x08, 0x12, 0x1b, 0xac,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 30 */
+	0x00, 0x00, 0x00, 0x80, 0x00, 0x00, 0x00, 0xb0,
+	0x00, 0x50, 0x90, 0x7e, 0x79, 0x70, 0x00, 0x00, /* 40 */
+	0x00, 0xa8, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x02, 0x0d, 0x00, 0x00, 0x00, 0x00, /* 50 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 60 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x01, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 70 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* 80 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0xc0, 0x00, 0x00, 0x00, /* 90 */
+	0x0b, 0x02, 0x00, 0x18, 0x5a, 0x60, 0x00, 0x00,
+	0x00, 0x00, 0x80, 0x80, 0x08, 0x04, 0x00, 0x00, /* a0 */
+	0x00, 0x00, 0x00, 0x40, 0x00, 0x00, 0x40, 0x14,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* b0 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, /* c0 */
+	0x00, 0x03, 0x00, 0x00, 0x02, 0x00, 0x01, 0x04,
+	0x30, 0xff, 0x80, 0x80, 0x80, 0x00, 0x00, 0x00, /* d0 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x10, 0x01,
+	0x80, 0x75, 0x00, 0x00, 0x60, 0x00, 0x00, 0x00, /* e0 */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x75, 0x11, 0x00, /* f0 */
+	0x00, 0x7c, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+/* ADI recommanded values for proper operation. */
+static const struct reg_default adv7511_fixed_registers[] = {
+	{ 0x98, 0x03 },
+	{ 0x9a, 0xe0 },
+	{ 0x9c, 0x30 },
+	{ 0x9d, 0x61 },
+	{ 0xa2, 0xa4 },
+	{ 0xa3, 0xa4 },
+	{ 0xe0, 0xd0 },
+	{ 0xf9, 0x00 },
+	{ 0x55, 0x02 },
+};
+
+static struct adv7511 *encoder_to_adv7511(struct drm_encoder *encoder)
+{
+	return to_encoder_slave(encoder)->slave_priv;
+}
+
+static void adv7511_set_colormap(struct adv7511 *adv7511, bool enable,
+				 const uint16_t *coeff,
+				 unsigned int scaling_factor)
+{
+	unsigned int i;
+
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_CSC_UPPER(1),
+			   ADV7511_CSC_UPDATE_MODE, ADV7511_CSC_UPDATE_MODE);
+
+	if (enable) {
+		for (i = 0; i < 12; ++i) {
+			regmap_update_bits(adv7511->regmap,
+					   ADV7511_REG_CSC_UPPER(i),
+					   0x1f, coeff[i] >> 8);
+			regmap_write(adv7511->regmap,
+				     ADV7511_REG_CSC_LOWER(i),
+				     coeff[i] & 0xff);
+		}
+	}
+
+	if (enable)
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_CSC_UPPER(0),
+				   0xe0, 0x80 | (scaling_factor << 5));
+	else
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_CSC_UPPER(0),
+				   0x80, 0x00);
+
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_CSC_UPPER(1),
+			   ADV7511_CSC_UPDATE_MODE, 0);
+}
+
+#define ADV7511_HDMI_CFG_MODE_MASK 0x2
+#define ADV7511_HDMI_CFG_MODE_DVI 0x0
+#define ADV7511_HDMI_CFG_MODE_HDMI 0x2
+
+#define ADV7511_PACKET_MEM_SPD		0
+#define ADV7511_PACKET_MEM_MPEG		1
+#define ADV7511_PACKET_MEM_ACP		2
+#define ADV7511_PACKET_MEM_ISRC1	3
+#define ADV7511_PACKET_MEM_ISRC2	4
+#define ADV7511_PACKET_MEM_GM		5
+#define ADV7511_PACKET_MEM_SPARE1	6
+#define ADV7511_PACKET_MEM_SPARE2	7
+
+#define ADV7511_PACKET_MEM_DATA_REG(x) ((x) * 0x20)
+#define ADV7511_PACKET_MEM_UPDATE_REG(x) ((x) * 0x20 + 0x1f)
+#define ADV7511_PACKET_MEM_UPDATE_ENABLE BIT(7)
+
+static int adv7511_packet_enable(struct adv7511 *adv7511, unsigned int packet)
+{
+	if (packet & 0xff)
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_PACKET_ENABLE0,
+				   packet, 0xff);
+
+	if (packet & 0xff00) {
+		packet >>= 8;
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_PACKET_ENABLE1,
+				   packet, 0xff);
+	}
+
+	return 0;
+}
+
+static int adv7511_packet_disable(struct adv7511 *adv7511, unsigned int packet)
+{
+	if (packet & 0xff)
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_PACKET_ENABLE0,
+				   packet, 0x00);
+
+	if (packet & 0xff00) {
+		packet >>= 8;
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_PACKET_ENABLE1,
+				   packet, 0x00);
+	}
+
+	return 0;
+}
+
+/* Coefficients for adv7511 color space conversion */
+static const uint16_t adv7511_csc_ycbcr_to_rgb[] = {
+	0x0734, 0x04ad, 0x0000, 0x1c1b,
+	0x1ddc, 0x04ad, 0x1f24, 0x0135,
+	0x0000, 0x04ad, 0x087c, 0x1b77,
+};
+
+static void adv7511_set_config_csc(struct drm_encoder *encoder,
+				   struct drm_connector *connector,
+				   bool rgb)
+{
+	struct adv7511 *adv7511 = encoder_to_adv7511(encoder);
+	struct adv7511_video_config config;
+	bool output_format_422, output_format_ycbcr;
+	unsigned int mode;
+	uint8_t infoframe[17];
+
+	if (adv7511->edid)
+		config.hdmi_mode = drm_detect_hdmi_monitor(adv7511->edid);
+	else
+		config.hdmi_mode = false;
+
+	hdmi_avi_infoframe_init(&config.avi_infoframe);
+
+	config.avi_infoframe.scan_mode = HDMI_SCAN_MODE_UNDERSCAN;
+
+	if (rgb) {
+		config.csc_enable = false;
+		config.avi_infoframe.colorspace = HDMI_COLORSPACE_RGB;
+	} else {
+		config.csc_scaling_factor = ADV7511_CSC_SCALING_4;
+		config.csc_coefficents = adv7511_csc_ycbcr_to_rgb;
+
+		if ((connector->display_info.color_formats &
+		     DRM_COLOR_FORMAT_YCRCB422) &&
+		    config.hdmi_mode) {
+			config.csc_enable = false;
+			config.avi_infoframe.colorspace +				HDMI_COLORSPACE_YUV422;
+		} else {
+			config.csc_enable = true;
+			config.avi_infoframe.colorspace = HDMI_COLORSPACE_RGB;
+		}
+	}
+
+	if (config.hdmi_mode) {
+		mode = ADV7511_HDMI_CFG_MODE_HDMI;
+
+		switch (config.avi_infoframe.colorspace) {
+		case HDMI_COLORSPACE_YUV444:
+			output_format_422 = false;
+			output_format_ycbcr = true;
+			break;
+		case HDMI_COLORSPACE_YUV422:
+			output_format_422 = true;
+			output_format_ycbcr = true;
+			break;
+		default:
+			output_format_422 = false;
+			output_format_ycbcr = false;
+			break;
+		}
+	} else {
+		mode = ADV7511_HDMI_CFG_MODE_DVI;
+		output_format_422 = false;
+		output_format_ycbcr = false;
+	}
+
+	adv7511_packet_disable(adv7511, ADV7511_PACKET_ENABLE_AVI_INFOFRAME);
+
+	adv7511_set_colormap(adv7511, config.csc_enable,
+			     config.csc_coefficents,
+			     config.csc_scaling_factor);
+
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_VIDEO_INPUT_CFG1, 0x81,
+			   (output_format_422 << 7) | output_format_ycbcr);
+
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_HDCP_HDMI_CFG,
+			   ADV7511_HDMI_CFG_MODE_MASK, mode);
+
+	hdmi_avi_infoframe_pack(&config.avi_infoframe, infoframe,
+				sizeof(infoframe));
+
+	/* The AVI infoframe id is not configurable */
+	regmap_bulk_write(adv7511->regmap, ADV7511_REG_AVI_INFOFRAME_VERSION,
+			  infoframe + 1, sizeof(infoframe) - 1);
+
+	adv7511_packet_enable(adv7511, ADV7511_PACKET_ENABLE_AVI_INFOFRAME);
+}
+
+static void adv7511_set_link_config(struct adv7511 *adv7511,
+				    const struct adv7511_link_config *config)
+{
+	enum adv7511_input_sync_pulse sync_pulse;
+
+	switch (config->id) {
+	case ADV7511_INPUT_ID_12_15_16BIT_RGB444_YCbCr444:
+		sync_pulse = ADV7511_INPUT_SYNC_PULSE_NONE;
+		break;
+	default:
+		sync_pulse = config->sync_pulse;
+		break;
+	}
+
+	switch (config->id) {
+	case ADV7511_INPUT_ID_16_20_24BIT_YCbCr422_EMBEDDED_SYNC:
+	case ADV7511_INPUT_ID_8_10_12BIT_YCbCr422_EMBEDDED_SYNC:
+		adv7511->embedded_sync = true;
+		break;
+	default:
+		adv7511->embedded_sync = false;
+		break;
+	}
+
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_I2C_FREQ_ID_CFG, 0xf,
+			   config->id);
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_VIDEO_INPUT_CFG1, 0x7e,
+			   (config->input_color_depth << 4) |
+			   (config->input_style << 2));
+	regmap_write(adv7511->regmap, ADV7511_REG_VIDEO_INPUT_CFG2,
+		     (config->reverse_bitorder << 6) |
+		     (config->bit_justification << 3));
+	regmap_write(adv7511->regmap, ADV7511_REG_TIMING_GEN_SEQ,
+		     (sync_pulse << 2) | (config->timing_gen_seq << 1));
+	regmap_write(adv7511->regmap, 0xba, (config->clock_delay << 5));
+
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_TMDS_CLOCK_INV, 0x08,
+			   config->tmds_clock_inversion << 3);
+
+	adv7511->hsync_polarity = config->hsync_polarity;
+	adv7511->vsync_polarity = config->vsync_polarity;
+	adv7511->rgb = config->rgb;
+}
+
+static bool adv7511_register_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case ADV7511_REG_CHIP_REVISION:
+	case ADV7511_REG_SPDIF_FREQ:
+	case ADV7511_REG_CTS_AUTOMATIC1:
+	case ADV7511_REG_CTS_AUTOMATIC2:
+	case ADV7511_REG_VIC_DETECTED:
+	case ADV7511_REG_VIC_SEND:
+	case ADV7511_REG_AUX_VIC_DETECTED:
+	case ADV7511_REG_STATUS:
+	case ADV7511_REG_GC(1):
+	case ADV7511_REG_INT(0):
+	case ADV7511_REG_INT(1):
+	case ADV7511_REG_PLL_STATUS:
+	case ADV7511_REG_AN(0):
+	case ADV7511_REG_AN(1):
+	case ADV7511_REG_AN(2):
+	case ADV7511_REG_AN(3):
+	case ADV7511_REG_AN(4):
+	case ADV7511_REG_AN(5):
+	case ADV7511_REG_AN(6):
+	case ADV7511_REG_AN(7):
+	case ADV7511_REG_HDCP_STATUS:
+	case ADV7511_REG_BCAPS:
+	case ADV7511_REG_BKSV(0):
+	case ADV7511_REG_BKSV(1):
+	case ADV7511_REG_BKSV(2):
+	case ADV7511_REG_BKSV(3):
+	case ADV7511_REG_BKSV(4):
+	case ADV7511_REG_DDC_STATUS:
+	case ADV7511_REG_BSTATUS(0):
+	case ADV7511_REG_BSTATUS(1):
+	case ADV7511_REG_CHIP_ID_HIGH:
+	case ADV7511_REG_CHIP_ID_LOW:
+		return true;
+	}
+
+	return false;
+}
+
+static bool adv7511_hpd(struct adv7511 *adv7511)
+{
+	unsigned int irq0;
+	int ret;
+
+	ret = regmap_read(adv7511->regmap, ADV7511_REG_INT(0), &irq0);
+	if (ret < 0)
+		return false;
+
+	if (irq0 & ADV7511_INT0_HDP) {
+		regmap_write(adv7511->regmap, ADV7511_REG_INT(0),
+			     ADV7511_INT0_HDP);
+		return true;
+	}
+
+	return false;
+}
+
+static irqreturn_t adv7511_irq_handler(int irq, void *devid)
+{
+	struct adv7511 *adv7511 = devid;
+
+	if (adv7511_hpd(adv7511))
+		drm_helper_hpd_irq_event(adv7511->encoder->dev);
+
+	wake_up_all(&adv7511->wq);
+
+	return IRQ_HANDLED;
+}
+
+static unsigned int adv7511_is_interrupt_pending(struct adv7511 *adv7511,
+						 unsigned int irq)
+{
+	unsigned int irq0, irq1;
+	unsigned int pending;
+	int ret;
+
+	ret = regmap_read(adv7511->regmap, ADV7511_REG_INT(0), &irq0);
+	if (ret < 0)
+		return 0;
+	ret = regmap_read(adv7511->regmap, ADV7511_REG_INT(1), &irq1);
+	if (ret < 0)
+		return 0;
+
+	pending = (irq1 << 8) | irq0;
+
+	return pending & irq;
+}
+
+static int adv7511_wait_for_interrupt(struct adv7511 *adv7511, int irq,
+				      int timeout)
+{
+	unsigned int pending = 0;
+	int ret;
+
+	if (adv7511->i2c_main->irq) {
+		ret = wait_event_interruptible_timeout(adv7511->wq,
+				adv7511_is_interrupt_pending(adv7511, irq),
+				msecs_to_jiffies(timeout));
+		if (ret <= 0)
+			return 0;
+		pending = adv7511_is_interrupt_pending(adv7511, irq);
+	} else {
+		if (timeout < 25)
+			timeout = 25;
+		do {
+			pending = adv7511_is_interrupt_pending(adv7511, irq);
+			if (pending)
+				break;
+			msleep(25);
+			timeout -= 25;
+		} while (timeout >= 25);
+	}
+
+	return pending;
+}
+
+static int adv7511_get_edid_block(void *data, unsigned char *buf, int block,
+				  int len)
+{
+	struct drm_encoder *encoder = data;
+	struct adv7511 *adv7511 = encoder_to_adv7511(encoder);
+	struct i2c_msg xfer[2];
+	uint8_t offset;
+	int i;
+	int ret;
+
+	if (len > 128)
+		return -EINVAL;
+
+	if (adv7511->current_edid_segment != block / 2) {
+		unsigned int status;
+
+		ret = regmap_read(adv7511->regmap, ADV7511_REG_DDC_STATUS,
+				  &status);
+		if (ret < 0)
+			return ret;
+
+		if (status != 2) {
+			regmap_write(adv7511->regmap, ADV7511_REG_EDID_SEGMENT,
+				     block);
+			ret = adv7511_wait_for_interrupt(adv7511,
+					ADV7511_INT0_EDID_READY |
+					ADV7511_INT1_DDC_ERROR, 200);
+
+			if (!(ret & ADV7511_INT0_EDID_READY))
+				return -EIO;
+		}
+
+		regmap_write(adv7511->regmap, ADV7511_REG_INT(0),
+			     ADV7511_INT0_EDID_READY | ADV7511_INT1_DDC_ERROR);
+
+		/* Break this apart, hopefully more I2C controllers will
+		 * support 64 byte transfers than 256 byte transfers
+		 */
+
+		xfer[0].addr = adv7511->i2c_edid->addr;
+		xfer[0].flags = 0;
+		xfer[0].len = 1;
+		xfer[0].buf = &offset;
+		xfer[1].addr = adv7511->i2c_edid->addr;
+		xfer[1].flags = I2C_M_RD;
+		xfer[1].len = 64;
+		xfer[1].buf = adv7511->edid_buf;
+
+		offset = 0;
+
+		for (i = 0; i < 4; ++i) {
+			ret = i2c_transfer(adv7511->i2c_edid->adapter, xfer,
+					   ARRAY_SIZE(xfer));
+			if (ret < 0)
+				return ret;
+			else if (ret != 2)
+				return -EIO;
+
+			xfer[1].buf += 64;
+			offset += 64;
+		}
+
+		adv7511->current_edid_segment = block / 2;
+	}
+
+	if (block % 2 = 0)
+		memcpy(buf, adv7511->edid_buf, len);
+	else
+		memcpy(buf, adv7511->edid_buf + 128, len);
+
+	return 0;
+}
+
+static int adv7511_get_modes(struct drm_encoder *encoder,
+			     struct drm_connector *connector)
+{
+	struct adv7511 *adv7511 = encoder_to_adv7511(encoder);
+	struct edid *edid;
+	unsigned int count;
+
+	/* Reading the EDID only works if the device is powered */
+	if (adv7511->dpms_mode != DRM_MODE_DPMS_ON) {
+		regmap_write(adv7511->regmap, ADV7511_REG_INT(0),
+			     ADV7511_INT0_EDID_READY | ADV7511_INT1_DDC_ERROR);
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
+				   ADV7511_POWER_POWER_DOWN, 0);
+		adv7511->current_edid_segment = -1;
+	}
+
+	edid = drm_do_get_edid(connector, adv7511_get_edid_block, encoder);
+
+	if (adv7511->dpms_mode != DRM_MODE_DPMS_ON)
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
+				   ADV7511_POWER_POWER_DOWN,
+				   ADV7511_POWER_POWER_DOWN);
+
+	kfree(adv7511->edid);
+	adv7511->edid = edid;
+	if (!edid)
+		return 0;
+
+	drm_mode_connector_update_edid_property(connector, edid);
+	count = drm_add_edid_modes(connector, edid);
+
+	adv7511_set_config_csc(encoder, connector, adv7511->rgb);
+
+	return count;
+}
+
+static void adv7511_encoder_dpms(struct drm_encoder *encoder, int mode)
+{
+	struct adv7511 *adv7511 = encoder_to_adv7511(encoder);
+
+	switch (mode) {
+	case DRM_MODE_DPMS_ON:
+		adv7511->current_edid_segment = -1;
+
+		regmap_write(adv7511->regmap, ADV7511_REG_INT(0),
+			     ADV7511_INT0_EDID_READY | ADV7511_INT1_DDC_ERROR);
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
+				   ADV7511_POWER_POWER_DOWN, 0);
+		/*
+		 * Per spec it is allowed to pulse the HDP signal to indicate
+		 * that the EDID information has changed. Some monitors do this
+		 * when they wakeup from standby or are enabled. When the HDP
+		 * goes low the adv7511 is reset and the outputs are disabled
+		 * which might cause the monitor to go to standby again. To
+		 * avoid this we ignore the HDP pin for the first few seconds
+		 * after enabeling the output.
+		 */
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER2,
+				   ADV7511_REG_POWER2_HDP_SRC_MASK,
+				   ADV7511_REG_POWER2_HDP_SRC_NONE);
+		/* Most of the registers are reset during power down or
+		 * when HPD is low
+		 */
+		regcache_sync(adv7511->regmap);
+		break;
+	default:
+		/* TODO: setup additional power down modes */
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
+				   ADV7511_POWER_POWER_DOWN,
+				   ADV7511_POWER_POWER_DOWN);
+		regcache_mark_dirty(adv7511->regmap);
+		break;
+	}
+
+	adv7511->dpms_mode = mode;
+}
+
+static enum drm_connector_status
+adv7511_encoder_detect(struct drm_encoder *encoder,
+		       struct drm_connector *connector)
+{
+	struct adv7511 *adv7511 = encoder_to_adv7511(encoder);
+	enum drm_connector_status status;
+	unsigned int val;
+	bool hpd;
+	int ret;
+
+	ret = regmap_read(adv7511->regmap, ADV7511_REG_STATUS, &val);
+	if (ret < 0)
+		return connector_status_disconnected;
+
+	if (val & ADV7511_STATUS_HPD)
+		status = connector_status_connected;
+	else
+		status = connector_status_disconnected;
+
+	hpd = adv7511_hpd(adv7511);
+
+	/* The chip resets itself when the cable is disconnected, so in case
+	 * there is a pending HPD interrupt and the cable is connected there was
+	 * at least one transition from disconnected to connected and the chip
+	 * has to be reinitialized. */
+	if (status = connector_status_connected && hpd &&
+	    adv7511->dpms_mode = DRM_MODE_DPMS_ON) {
+		regcache_mark_dirty(adv7511->regmap);
+		adv7511_encoder_dpms(encoder, adv7511->dpms_mode);
+		adv7511_get_modes(encoder, connector);
+		if (adv7511->status = connector_status_connected)
+			status = connector_status_disconnected;
+	} else {
+		/* Renable HDP sensing */
+		regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER2,
+				   ADV7511_REG_POWER2_HDP_SRC_MASK,
+				   ADV7511_REG_POWER2_HDP_SRC_BOTH);
+	}
+
+	adv7511->status = status;
+	return status;
+}
+
+static int adv7511_encoder_mode_valid(struct drm_encoder *encoder,
+				      struct drm_display_mode *mode)
+{
+	if (mode->clock > 165000)
+		return MODE_CLOCK_HIGH;
+
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+		return MODE_NO_INTERLACE;
+
+	return MODE_OK;
+}
+
+static void adv7511_encoder_mode_set(struct drm_encoder *encoder,
+				     struct drm_display_mode *mode,
+				     struct drm_display_mode *adj_mode)
+{
+	struct adv7511 *adv7511 = encoder_to_adv7511(encoder);
+	unsigned int low_refresh_rate;
+	unsigned int hsync_polarity = 0;
+	unsigned int vsync_polarity = 0;
+
+	if (adv7511->embedded_sync) {
+		unsigned int hsync_offset, hsync_len;
+		unsigned int vsync_offset, vsync_len;
+
+		hsync_offset = adj_mode->crtc_hsync_start -
+			       adj_mode->crtc_hdisplay;
+		vsync_offset = adj_mode->crtc_vsync_start -
+			       adj_mode->crtc_vdisplay;
+		hsync_len = adj_mode->crtc_hsync_end -
+			    adj_mode->crtc_hsync_start;
+		vsync_len = adj_mode->crtc_vsync_end -
+			    adj_mode->crtc_vsync_start;
+
+		/* The hardware vsync generator has a off-by-one bug */
+		vsync_offset += 1;
+
+		regmap_write(adv7511->regmap, ADV7511_REG_HSYNC_PLACEMENT_MSB,
+			     ((hsync_offset >> 10) & 0x7) << 5);
+		regmap_write(adv7511->regmap, ADV7511_REG_SYNC_DECODER(0),
+			     (hsync_offset >> 2) & 0xff);
+		regmap_write(adv7511->regmap, ADV7511_REG_SYNC_DECODER(1),
+			     ((hsync_offset & 0x3) << 6) |
+			     ((hsync_len >> 4) & 0x3f));
+		regmap_write(adv7511->regmap, ADV7511_REG_SYNC_DECODER(2),
+			     ((hsync_len & 0xf) << 4) |
+			     ((vsync_offset >> 6) & 0xf));
+		regmap_write(adv7511->regmap, ADV7511_REG_SYNC_DECODER(3),
+			     ((vsync_offset & 0x3f) << 2) |
+			     ((vsync_len >> 8) & 0x3));
+		regmap_write(adv7511->regmap, ADV7511_REG_SYNC_DECODER(4),
+			     vsync_len & 0xff);
+
+		hsync_polarity = !(adj_mode->flags & DRM_MODE_FLAG_PHSYNC);
+		vsync_polarity = !(adj_mode->flags & DRM_MODE_FLAG_PVSYNC);
+	} else {
+		enum adv7511_sync_polarity mode_hsync_polarity;
+		enum adv7511_sync_polarity mode_vsync_polarity;
+
+		/**
+		 * If the input signal is always low or always high we want to
+		 * invert or let it passthrough depending on the polarity of the
+		 * current mode.
+		 **/
+		if (adj_mode->flags & DRM_MODE_FLAG_NHSYNC)
+			mode_hsync_polarity = ADV7511_SYNC_POLARITY_LOW;
+		else
+			mode_hsync_polarity = ADV7511_SYNC_POLARITY_HIGH;
+
+		if (adj_mode->flags & DRM_MODE_FLAG_NVSYNC)
+			mode_vsync_polarity = ADV7511_SYNC_POLARITY_LOW;
+		else
+			mode_vsync_polarity = ADV7511_SYNC_POLARITY_HIGH;
+
+		if (adv7511->hsync_polarity != mode_hsync_polarity &&
+		    adv7511->hsync_polarity !+		    ADV7511_SYNC_POLARITY_PASSTHROUGH)
+			hsync_polarity = 1;
+
+		if (adv7511->vsync_polarity != mode_vsync_polarity &&
+		    adv7511->vsync_polarity !+		    ADV7511_SYNC_POLARITY_PASSTHROUGH)
+			vsync_polarity = 1;
+	}
+
+	if (mode->vrefresh <= 24000)
+		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_24HZ;
+	else if (mode->vrefresh <= 25000)
+		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_25HZ;
+	else if (mode->vrefresh <= 30000)
+		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_30HZ;
+	else
+		low_refresh_rate = ADV7511_LOW_REFRESH_RATE_NONE;
+
+	regmap_update_bits(adv7511->regmap, 0xfb,
+		0x6, low_refresh_rate << 1);
+	regmap_update_bits(adv7511->regmap, 0x17,
+		0x60, (vsync_polarity << 6) | (hsync_polarity << 5));
+
+	adv7511->f_tmds = mode->clock;
+}
+
+static struct drm_encoder_slave_funcs adv7511_encoder_funcs = {
+	.dpms = adv7511_encoder_dpms,
+	/* .destroy = adv7511_encoder_destroy,*/
+	.mode_valid = adv7511_encoder_mode_valid,
+	.mode_set = adv7511_encoder_mode_set,
+	.detect = adv7511_encoder_detect,
+	.get_modes = adv7511_get_modes,
+};
+
+static const struct regmap_config adv7511_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+
+	.max_register = 0xff,
+	.cache_type = REGCACHE_RBTREE,
+	.reg_defaults_raw = adv7511_register_defaults,
+	.num_reg_defaults_raw = ARRAY_SIZE(adv7511_register_defaults),
+
+	.volatile_reg = adv7511_register_volatile,
+};
+
+/*
+	adi,input-id -
+		0x00:
+		0x01:
+		0x02:
+		0x03:
+		0x04:
+		0x05:
+	adi,sync-pulse - Selects the sync pulse
+		0x00: Use the DE signal as sync pulse
+		0x01: Use the HSYNC signal as sync pulse
+		0x02: Use the VSYNC signal as sync pulse
+		0x03: No external sync pulse
+	adi,bit-justification -
+		0x00: Evently
+		0x01: Right
+		0x02: Left
+	adi,up-conversion -
+		0x00: zero-order up conversion
+		0x01: first-order up conversion
+	adi,timing-generation-sequence -
+		0x00: Sync adjustment first, then DE generation
+		0x01: DE generation first then sync adjustment
+	adi,vsync-polarity - Polarity of the vsync signal
+		0x00: Passthrough
+		0x01: Active low
+		0x02: Active high
+	adi,hsync-polarity - Polarity of the hsync signal
+		0x00: Passthrough
+		0x01: Active low
+		0x02: Active high
+	adi,reverse-bitorder - If set the bitorder is reveresed
+	adi,tmds-clock-inversion - If set use tdms clock inversion
+	adi,clock-delay - Clock delay for the video data clock
+		0x00: -1200 ps
+		0x01:  -800 ps
+		0x02:  -400 ps
+		0x03: no dealy
+		0x04:   400 ps
+		0x05:   800 ps
+		0x06:  1200 ps
+		0x07:  1600 ps
+	adi,input-style - Specifies the input style used
+		0x02: Use input style 1
+		0x01: Use input style 2
+		0x03: Use Input style 3
+	adi,input-color-depth - Selects the input format color depth
+		0x03: 8-bit per channel
+		0x01: 10-bit per channel
+		0x02: 12-bit per channel
+*/
+
+static int adv7511_parse_dt(struct device_node *np,
+			    struct adv7511_link_config *config)
+{
+	int ret;
+
+	ret = of_property_read_u32(np, "adi,input-id", &config->id);
+	if (ret < 0)
+		return ret;
+
+	config->sync_pulse = ADV7511_INPUT_SYNC_PULSE_NONE;
+	of_property_read_u32(np, "adi,sync-pulse", &config->sync_pulse);
+
+	ret = of_property_read_u32(np, "adi,bit-justification",
+				   &config->bit_justification);
+	if (ret < 0)
+		return ret;
+
+	config->up_conversion = ADV7511_UP_CONVERSION_ZERO_ORDER;
+	of_property_read_u32(np, "adi,up-conversion", &config->up_conversion);
+
+	ret = of_property_read_u32(np, "adi,timing-generation-sequence",
+				   &config->timing_gen_seq);
+	if (ret < 0)
+		return ret;
+
+	ret = of_property_read_u32(np, "adi,vsync-polarity",
+				   &config->vsync_polarity);
+	if (ret < 0)
+		return ret;
+
+	ret = of_property_read_u32(np, "adi,hsync-polarity",
+				   &config->hsync_polarity);
+	if (ret < 0)
+		return ret;
+
+	config->reverse_bitorder = of_property_read_bool(np,
+		"adi,reverse-bitorder");
+	config->tmds_clock_inversion = of_property_read_bool(np,
+		"adi,tmds-clock-inversion");
+
+	ret = of_property_read_u32(np, "adi,clock-delay",
+				   &config->clock_delay);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32(np, "adi,input-style",
+				   &config->input_style);
+	if (ret)
+		return ret;
+
+	ret = of_property_read_u32(np, "adi,input-color-depth",
+				   &config->input_color_depth);
+	if (ret)
+		return ret;
+
+	config->gpio_pd = of_get_gpio(np, 0);
+	if (config->gpio_pd = -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+
+	config->rgb = of_property_read_bool(np, "adi,is-rgb");
+
+	return 0;
+}
+
+static const int edid_i2c_addr = 0x7e;
+static const int packet_i2c_addr = 0x70;
+static const int cec_i2c_addr = 0x78;
+
+static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id *id)
+{
+	struct adv7511_link_config link_config;
+	struct adv7511 *adv7511;
+	struct device *dev = &i2c->dev;
+	unsigned int val;
+	int ret;
+
+	if (dev->of_node) {
+		ret = adv7511_parse_dt(dev->of_node, &link_config);
+		if (ret)
+			return ret;
+	} else {
+		if (!dev->platform_data)
+			return -EINVAL;
+		link_config = *(struct adv7511_link_config *)dev->platform_data;
+	}
+
+	adv7511 = devm_kzalloc(dev, sizeof(*adv7511), GFP_KERNEL);
+	if (!adv7511)
+		return -ENOMEM;
+
+	adv7511->dpms_mode = DRM_MODE_DPMS_OFF;
+	adv7511->status = connector_status_disconnected;
+
+	adv7511->gpio_pd = link_config.gpio_pd;
+
+	if (gpio_is_valid(adv7511->gpio_pd)) {
+		ret = devm_gpio_request_one(dev, adv7511->gpio_pd,
+					    GPIOF_OUT_INIT_HIGH, "PD");
+		if (ret)
+			return ret;
+		mdelay(5);
+		gpio_set_value_cansleep(adv7511->gpio_pd, 0);
+	}
+
+	adv7511->regmap = devm_regmap_init_i2c(i2c, &adv7511_regmap_config);
+	if (IS_ERR(adv7511->regmap))
+		return PTR_ERR(adv7511->regmap);
+
+	ret = regmap_read(adv7511->regmap, ADV7511_REG_CHIP_REVISION, &val);
+	if (ret)
+		return ret;
+	dev_dbg(dev, "Rev. %d\n", val);
+
+	ret = regmap_register_patch(adv7511->regmap, adv7511_fixed_registers,
+				    ARRAY_SIZE(adv7511_fixed_registers));
+	if (ret)
+		return ret;
+
+	regmap_write(adv7511->regmap, ADV7511_REG_EDID_I2C_ADDR, edid_i2c_addr);
+	regmap_write(adv7511->regmap, ADV7511_REG_PACKET_I2C_ADDR,
+		     packet_i2c_addr);
+	regmap_write(adv7511->regmap, ADV7511_REG_CEC_I2C_ADDR, cec_i2c_addr);
+	adv7511_packet_disable(adv7511, 0xffff);
+
+	adv7511->i2c_main = i2c;
+	adv7511->i2c_edid = i2c_new_dummy(i2c->adapter, edid_i2c_addr >> 1);
+	adv7511->i2c_packet = i2c_new_dummy(i2c->adapter, packet_i2c_addr >> 1);
+	if (!adv7511->i2c_edid)
+		return -ENOMEM;
+
+	if (i2c->irq) {
+		init_waitqueue_head(&adv7511->wq);
+
+		ret = request_threaded_irq(i2c->irq, NULL, adv7511_irq_handler,
+					   IRQF_ONESHOT, dev_name(dev),
+					   adv7511);
+		if (ret)
+			goto err_i2c_unregister_device;
+	}
+
+	/* CEC is unused for now */
+	regmap_write(adv7511->regmap, ADV7511_REG_CEC_CTRL,
+		     ADV7511_CEC_CTRL_POWER_DOWN);
+
+	regmap_update_bits(adv7511->regmap, ADV7511_REG_POWER,
+			   ADV7511_POWER_POWER_DOWN, ADV7511_POWER_POWER_DOWN);
+
+	adv7511->current_edid_segment = -1;
+
+	i2c_set_clientdata(i2c, adv7511);
+
+	adv7511_set_link_config(adv7511, &link_config);
+
+	return 0;
+
+err_i2c_unregister_device:
+	i2c_unregister_device(adv7511->i2c_edid);
+
+	return ret;
+}
+
+static int adv7511_remove(struct i2c_client *i2c)
+{
+	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
+
+	i2c_unregister_device(adv7511->i2c_edid);
+
+	if (i2c->irq)
+		free_irq(i2c->irq, adv7511);
+	kfree(adv7511->edid);
+
+	return 0;
+}
+
+static int adv7511_encoder_init(struct i2c_client *i2c, struct drm_device *dev,
+				struct drm_encoder_slave *encoder)
+{
+
+	struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
+
+	encoder->slave_priv = adv7511;
+	encoder->slave_funcs = &adv7511_encoder_funcs;
+
+	adv7511->encoder = &encoder->base;
+
+	return 0;
+}
+
+static const struct i2c_device_id adv7511_ids[] = {
+	{ "adv7511", 0 },
+	{}
+};
+
+static struct drm_i2c_encoder_driver adv7511_driver = {
+	.i2c_driver = {
+		.driver = {
+			.name = "adv7511",
+		},
+		.id_table = adv7511_ids,
+		.probe = adv7511_probe,
+		.remove = adv7511_remove,
+	},
+
+	.encoder_init = adv7511_encoder_init,
+};
+
+static int __init adv7511_init(void)
+{
+	return drm_i2c_encoder_register(THIS_MODULE, &adv7511_driver);
+}
+module_init(adv7511_init);
+
+static void __exit adv7511_exit(void)
+{
+	drm_i2c_encoder_unregister(&adv7511_driver);
+}
+module_exit(adv7511_exit);
+
+MODULE_AUTHOR("Lars-Peter Clausen <lars@metafoo.de>");
+MODULE_DESCRIPTION("ADV7511 HDMI transmitter driver");
+MODULE_LICENSE("GPL");
diff --git a/include/drm/i2c/adv7511.h b/include/drm/i2c/adv7511.h
new file mode 100644
index 0000000..12bf469
--- /dev/null
+++ b/include/drm/i2c/adv7511.h
@@ -0,0 +1,456 @@
+/*
+ * Analog Devices ADV7511 HDMI transmitter driver
+ *
+ * Copyright 2012 Analog Devices Inc.
+ *
+ * Licensed under the GPL-2.
+ */
+
+#ifndef __DRM_I2C_ADV7511_H__
+#define __DRM_I2C_ADV7511_H__
+
+#include <linux/hdmi.h>
+
+#define ADV7511_REG_CHIP_REVISION		0x00
+#define ADV7511_REG_N0				0x01
+#define ADV7511_REG_N1				0x02
+#define ADV7511_REG_N2				0x03
+#define ADV7511_REG_SPDIF_FREQ			0x04
+#define ADV7511_REG_CTS_AUTOMATIC1		0x05
+#define ADV7511_REG_CTS_AUTOMATIC2		0x06
+#define ADV7511_REG_CTS_MANUAL0			0x07
+#define ADV7511_REG_CTS_MANUAL1			0x08
+#define ADV7511_REG_CTS_MANUAL2			0x09
+#define ADV7511_REG_AUDIO_SOURCE		0x0a
+#define ADV7511_REG_AUDIO_CONFIG		0x0b
+#define ADV7511_REG_I2S_CONFIG			0x0c
+#define ADV7511_REG_I2S_WIDTH			0x0d
+#define ADV7511_REG_AUDIO_SUB_SRC0		0x0e
+#define ADV7511_REG_AUDIO_SUB_SRC1		0x0f
+#define ADV7511_REG_AUDIO_SUB_SRC2		0x10
+#define ADV7511_REG_AUDIO_SUB_SRC3		0x11
+#define ADV7511_REG_AUDIO_CFG1			0x12
+#define ADV7511_REG_AUDIO_CFG2			0x13
+#define ADV7511_REG_AUDIO_CFG3			0x14
+#define ADV7511_REG_I2C_FREQ_ID_CFG		0x15
+#define ADV7511_REG_VIDEO_INPUT_CFG1		0x16
+#define ADV7511_REG_CSC_UPPER(x)		(0x18 + (x) * 2)
+#define ADV7511_REG_CSC_LOWER(x)		(0x19 + (x) * 2)
+#define ADV7511_REG_SYNC_DECODER(x)		(0x30 + (x))
+#define ADV7511_REG_DE_GENERATOR		(0x35 + (x))
+#define ADV7511_REG_PIXEL_REPETITION		0x3b
+#define ADV7511_REG_VIC_MANUAL			0x3c
+#define ADV7511_REG_VIC_SEND			0x3d
+#define ADV7511_REG_VIC_DETECTED		0x3e
+#define ADV7511_REG_AUX_VIC_DETECTED		0x3f
+#define ADV7511_REG_PACKET_ENABLE0		0x40
+#define ADV7511_REG_POWER			0x41
+#define ADV7511_REG_STATUS			0x42
+#define ADV7511_REG_EDID_I2C_ADDR		0x43
+#define ADV7511_REG_PACKET_ENABLE1		0x44
+#define ADV7511_REG_PACKET_I2C_ADDR		0x45
+#define ADV7511_REG_DSD_ENABLE			0x46
+#define ADV7511_REG_VIDEO_INPUT_CFG2		0x48
+#define ADV7511_REG_INFOFRAME_UPDATE		0x4a
+#define ADV7511_REG_GC(x)			(0x4b + (x)) /* 0x4b - 0x51 */
+#define ADV7511_REG_AVI_INFOFRAME_VERSION	0x52
+#define ADV7511_REG_AVI_INFOFRAME_LENGTH	0x53
+#define ADV7511_REG_AVI_INFOFRAME_CHECKSUM	0x54
+#define ADV7511_REG_AVI_INFOFRAME(x)		(0x55 + (x)) /* 0x55 - 0x6f */
+#define ADV7511_REG_AUDIO_INFOFRAME_VERSION	0x70
+#define ADV7511_REG_AUDIO_INFOFRAME_LENGTH	0x71
+#define ADV7511_REG_AUDIO_INFOFRAME_CHECKSUM	0x72
+#define ADV7511_REG_AUDIO_INFOFRAME(x)		(0x73 + (x)) /* 0x73 - 0x7c */
+#define ADV7511_REG_INT_ENABLE(x)		(0x94 + (x))
+#define ADV7511_REG_INT(x)			(0x96 + (x))
+#define ADV7511_REG_INPUT_CLK_DIV		0x9d
+#define ADV7511_REG_PLL_STATUS			0x9e
+#define ADV7511_REG_HDMI_POWER			0xa1
+#define ADV7511_REG_HDCP_HDMI_CFG		0xaf
+#define ADV7511_REG_AN(x)			(0xb0 + (x)) /* 0xb0 - 0xb7 */
+#define ADV7511_REG_HDCP_STATUS			0xb8
+#define ADV7511_REG_BCAPS			0xbe
+#define ADV7511_REG_BKSV(x)			(0xc0 + (x)) /* 0xc0 - 0xc3 */
+#define ADV7511_REG_EDID_SEGMENT		0xc4
+#define ADV7511_REG_DDC_STATUS			0xc8
+#define ADV7511_REG_EDID_READ_CTRL		0xc9
+#define ADV7511_REG_BSTATUS(x)			(0xca + (x)) /* 0xca - 0xcb */
+#define ADV7511_REG_TIMING_GEN_SEQ		0xd0
+#define ADV7511_REG_POWER2			0xd6
+#define ADV7511_REG_HSYNC_PLACEMENT_MSB		0xfa
+
+#define ADV7511_REG_SYNC_ADJUSTMENT(x)		(0xd7 + (x)) /* 0xd7 - 0xdc */
+#define ADV7511_REG_TMDS_CLOCK_INV		0xde
+#define ADV7511_REG_ARC_CTRL			0xdf
+#define ADV7511_REG_CEC_I2C_ADDR		0xe1
+#define ADV7511_REG_CEC_CTRL			0xe2
+#define ADV7511_REG_CHIP_ID_HIGH		0xf5
+#define ADV7511_REG_CHIP_ID_LOW			0xf6
+
+#define ADV7511_CSC_ENABLE			BIT(7)
+#define ADV7511_CSC_UPDATE_MODE			BIT(5)
+
+#define ADV7511_INT0_HDP			BIT(7)
+#define ADV7511_INT0_VSYNC			BIT(5)
+#define ADV7511_INT0_AUDIO_FIFO_FULL		BIT(4)
+#define ADV7511_INT0_EDID_READY			BIT(2)
+#define ADV7511_INT0_HDCP_AUTHENTICATED		BIT(1)
+
+#define ADV7511_INT1_DDC_ERROR			BIT(7)
+#define ADV7511_INT1_BKSV			BIT(6)
+#define ADV7511_INT1_CEC_TX_READY		BIT(5)
+#define ADV7511_INT1_CEC_TX_ARBIT_LOST		BIT(4)
+#define ADV7511_INT1_CEC_TX_RETRY_TIMEOUT	BIT(3)
+#define ADV7511_INT1_CEC_RX_READY3		BIT(2)
+#define ADV7511_INT1_CEC_RX_READY2		BIT(1)
+#define ADV7511_INT1_CEC_RX_READY1		BIT(0)
+
+#define ADV7511_ARC_CTRL_POWER_DOWN		BIT(0)
+
+#define ADV7511_CEC_CTRL_POWER_DOWN		BIT(0)
+
+#define ADV7511_POWER_POWER_DOWN		BIT(6)
+
+#define ADV7511_AUDIO_SELECT_I2C		0x0
+#define ADV7511_AUDIO_SELECT_SPDIF		0x1
+#define ADV7511_AUDIO_SELECT_DSD		0x2
+#define ADV7511_AUDIO_SELECT_HBR		0x3
+#define ADV7511_AUDIO_SELECT_DST		0x4
+
+#define ADV7511_I2S_SAMPLE_LEN_16		0x2
+#define ADV7511_I2S_SAMPLE_LEN_20		0x3
+#define ADV7511_I2S_SAMPLE_LEN_18		0x4
+#define ADV7511_I2S_SAMPLE_LEN_22		0x5
+#define ADV7511_I2S_SAMPLE_LEN_19		0x8
+#define ADV7511_I2S_SAMPLE_LEN_23		0x9
+#define ADV7511_I2S_SAMPLE_LEN_24		0xb
+#define ADV7511_I2S_SAMPLE_LEN_17		0xc
+#define ADV7511_I2S_SAMPLE_LEN_21		0xd
+
+#define ADV7511_SAMPLE_FREQ_44100		0x0
+#define ADV7511_SAMPLE_FREQ_48000		0x2
+#define ADV7511_SAMPLE_FREQ_32000		0x3
+#define ADV7511_SAMPLE_FREQ_88200		0x8
+#define ADV7511_SAMPLE_FREQ_96000		0xa
+#define ADV7511_SAMPLE_FREQ_176400		0xc
+#define ADV7511_SAMPLE_FREQ_192000		0xe
+
+#define ADV7511_STATUS_POWER_DOWN_POLARITY	BIT(7)
+#define ADV7511_STATUS_HPD			BIT(6)
+#define ADV7511_STATUS_MONITOR_SENSE		BIT(5)
+#define ADV7511_STATUS_I2S_32BIT_MODE		BIT(3)
+
+#define ADV7511_PACKET_ENABLE_N_CTS		BIT(8+6)
+#define ADV7511_PACKET_ENABLE_AUDIO_SAMPLE	BIT(8+5)
+#define ADV7511_PACKET_ENABLE_AVI_INFOFRAME	BIT(8+4)
+#define ADV7511_PACKET_ENABLE_AUDIO_INFOFRAME	BIT(8+3)
+#define ADV7511_PACKET_ENABLE_GC		BIT(7)
+#define ADV7511_PACKET_ENABLE_SPD		BIT(6)
+#define ADV7511_PACKET_ENABLE_MPEG		BIT(5)
+#define ADV7511_PACKET_ENABLE_ACP		BIT(4)
+#define ADV7511_PACKET_ENABLE_ISRC		BIT(3)
+#define ADV7511_PACKET_ENABLE_GM		BIT(2)
+#define ADV7511_PACKET_ENABLE_SPARE2		BIT(1)
+#define ADV7511_PACKET_ENABLE_SPARE1		BIT(0)
+
+#define ADV7511_REG_POWER2_HDP_SRC_MASK		0xc0
+#define ADV7511_REG_POWER2_HDP_SRC_BOTH		0x00
+#define ADV7511_REG_POWER2_HDP_SRC_HDP		0x40
+#define ADV7511_REG_POWER2_HDP_SRC_CEC		0x80
+#define ADV7511_REG_POWER2_HDP_SRC_NONE		0xc0
+#define ADV7511_REG_POWER2_TDMS_ENABLE		BIT(4)
+#define ADV7511_REG_POWER2_GATE_INPUT_CLK	BIT(0)
+
+#define ADV7511_LOW_REFRESH_RATE_NONE		0x0
+#define ADV7511_LOW_REFRESH_RATE_24HZ		0x1
+#define ADV7511_LOW_REFRESH_RATE_25HZ		0x2
+#define ADV7511_LOW_REFRESH_RATE_30HZ		0x3
+
+#define ADV7511_AUDIO_CFG3_LEN_MASK		0x0f
+#define ADV7511_I2C_FREQ_ID_CFG_RATE_MASK	0xf0
+
+#define ADV7511_AUDIO_SOURCE_I2S		0
+#define ADV7511_AUDIO_SOURCE_SPDIF		1
+
+#define ADV7511_I2S_FORMAT_I2S			0
+#define ADV7511_I2S_FORMAT_RIGHT_J		1
+#define ADV7511_I2S_FORMAT_LEFT_J		2
+
+#define ADV7511_PACKET(p, x)	    ((p) * 0x20 + (x))
+#define ADV7511_PACKET_SDP(x)	    ADV7511_PACKET(0, x)
+#define ADV7511_PACKET_MPEG(x)	    ADV7511_PACKET(1, x)
+#define ADV7511_PACKET_ACP(x)	    ADV7511_PACKET(2, x)
+#define ADV7511_PACKET_ISRC1(x)	    ADV7511_PACKET(3, x)
+#define ADV7511_PACKET_ISRC2(x)	    ADV7511_PACKET(4, x)
+#define ADV7511_PACKET_GM(x)	    ADV7511_PACKET(5, x)
+#define ADV7511_PACKET_SPARE(x)	    ADV7511_PACKET(6, x)
+
+#include <drm/drmP.h>
+
+struct i2c_client;
+struct regmap;
+
+/**
+ * enum adv7511_input_style - Selects the input format style
+ * @ADV7511_INPUT_STYLE1: Use input style 1
+ * @ADV7511_INPUT_STYLE2: Use input style 2
+ * @ADV7511_INPUT_STYLE3: Use input style 3
+ */
+enum adv7511_input_style {
+	ADV7511_INPUT_STYLE1 = 2,
+	ADV7511_INPUT_STYLE2 = 1,
+	ADV7511_INPUT_STYLE3 = 3,
+};
+
+/**
+ * enum adv7511_input_id - Selects the input format id
+ * @ADV7511_INPUT_ID_24BIT_RGB444_YCbCr444: Input pixel format is 24-bit 444 RGB
+ *					    or 444 YCbCR with separate syncs
+ * @ADV7511_INPUT_ID_16_20_24BIT_YCbCr422_SEPARATE_SYNC: FIXME
+ * @ADV7511_INPUT_ID_16_20_24BIT_YCbCr422_EMBEDDED_SYNC: FIXME
+ * @ADV7511_INPUT_ID_8_10_12BIT_YCbCr422_SEPARATE_SYNC: FIXME
+ * @ADV7511_INPUT_ID_8_10_12BIT_YCbCr422_EMBEDDED_SYNC: FIXME
+ * @ADV7511_INPUT_ID_12_15_16BIT_RGB444_YCbCr444: FIXME
+ */
+enum adv7511_input_id {
+	ADV7511_INPUT_ID_24BIT_RGB444_YCbCr444 = 0,
+	ADV7511_INPUT_ID_16_20_24BIT_YCbCr422_SEPARATE_SYNC = 1,
+	ADV7511_INPUT_ID_16_20_24BIT_YCbCr422_EMBEDDED_SYNC = 2,
+	ADV7511_INPUT_ID_8_10_12BIT_YCbCr422_SEPARATE_SYNC = 3,
+	ADV7511_INPUT_ID_8_10_12BIT_YCbCr422_EMBEDDED_SYNC = 4,
+	ADV7511_INPUT_ID_12_15_16BIT_RGB444_YCbCr444 = 5,
+};
+
+/**
+ * enum adv7511_input_bit_justifiction - Selects the input format bit
+ *					 justifiction
+ * @ADV7511_INPUT_BIT_JUSTIFICATION_EVENLY: Input bits are evenly distributed
+ * @ADV7511_INPUT_BIT_JUSTIFICATION_RIGHT: Input bit signals have right
+ *					  justification
+ * @ADV7511_INPUT_BIT_JUSTIFICATION_LEFT: Input bit signals have left
+ *					 justification
+ */
+enum adv7511_input_bit_justifiction {
+	ADV7511_INPUT_BIT_JUSTIFICATION_EVENLY = 0,
+	ADV7511_INPUT_BIT_JUSTIFICATION_RIGHT = 1,
+	ADV7511_INPUT_BIT_JUSTIFICATION_LEFT = 2,
+};
+
+/**
+ * enum adv7511_input_color_depth - Selects the input format color depth
+ * @ADV7511_INPUT_COLOR_DEPTH_8BIT: Input format color depth is 8 bits per
+ *				    channel
+ * @ADV7511_INPUT_COLOR_DEPTH_10BIT: Input format color dpeth is 10 bits per
+ *				     channel
+ * @ADV7511_INPUT_COLOR_DEPTH_12BIT: Input format color depth is 12 bits per
+ *				     channel
+ */
+enum adv7511_input_color_depth {
+	ADV7511_INPUT_COLOR_DEPTH_8BIT = 3,
+	ADV7511_INPUT_COLOR_DEPTH_10BIT = 1,
+	ADV7511_INPUT_COLOR_DEPTH_12BIT = 2,
+};
+
+/**
+ * enum adv7511_input_sync_pulse - Selects the sync pulse
+ * @ADV7511_INPUT_SYNC_PULSE_DE: Use the DE signal as sync pulse
+ * @ADV7511_INPUT_SYNC_PULSE_HSYNC: Use the HSYNC signal as sync pulse
+ * @ADV7511_INPUT_SYNC_PULSE_VSYNC: Use the VSYNC signal as sync pulse
+ * @ADV7511_INPUT_SYNC_PULSE_NONE: No external sync pulse signal
+ */
+enum adv7511_input_sync_pulse {
+	ADV7511_INPUT_SYNC_PULSE_DE = 0,
+	ADV7511_INPUT_SYNC_PULSE_HSYNC = 1,
+	ADV7511_INPUT_SYNC_PULSE_VSYNC = 2,
+	ADV7511_INPUT_SYNC_PULSE_NONE = 3,
+};
+
+/**
+ * enum adv7511_input_clock_delay - Delay for the video data input clock
+ * @ADV7511_INPUT_CLOCK_DELAY_MINUS_1200PS: -1200 pico seconds delay
+ * @ADV7511_INPUT_CLOCK_DELAY_MINUS_800PS: -800 pico seconds delay
+ * @ADV7511_INPUT_CLOCK_DELAY_MINUS_400PS: -400 pico seconds delay
+ * @ADV7511_INPUT_CLOCK_DELAY_NONE: No delay
+ * @ADV7511_INPUT_CLOCK_DELAY_PLUS_400PS: 400 pico seconds delay
+ * @ADV7511_INPUT_CLOCK_DELAY_PLUS_800PS: 800 pico seconds delay
+ * @ADV7511_INPUT_CLOCK_DELAY_PLUS_1200PS: 1200 pico seconds delay
+ * @ADV7511_INPUT_CLOCK_DELAY_PLUS_1600PS: 1600 pico seconds delay
+ */
+enum adv7511_input_clock_delay {
+	ADV7511_INPUT_CLOCK_DELAY_MINUS_1200PS = 0,
+	ADV7511_INPUT_CLOCK_DELAY_MINUS_800PS = 1,
+	ADV7511_INPUT_CLOCK_DELAY_MINUS_400PS = 2,
+	ADV7511_INPUT_CLOCK_DELAY_NONE = 3,
+	ADV7511_INPUT_CLOCK_DELAY_PLUS_400PS = 4,
+	ADV7511_INPUT_CLOCK_DELAY_PLUS_800PS = 5,
+	ADV7511_INPUT_CLOCK_DELAY_PLUS_1200PS = 6,
+	ADV7511_INPUT_CLOCK_DELAY_PLUS_1600PS = 7,
+};
+
+/**
+ * enum adv7511_sync_polarity - Polarity for the input sync signals
+ * @ADV7511_SYNC_POLARITY_PASSTHROUGH:  Sync polarity matches that of
+ *				       the currently configured mode.
+ * @ADV7511_SYNC_POLARITY_LOW:	    Sync polarity is low
+ * @ADV7511_SYNC_POLARITY_HIGH:	    Sync polarity is high
+ *
+ * If the polarity is set to either ADV7511_SYNC_POLARITY_LOW or
+ * ADV7511_SYNC_POLARITY_HIGH the ADV7511 will internally invert the signal if
+ * it is required to match the sync polarity setting for the currently selected
+ * mode. If the polarity is set to ADV7511_SYNC_POLARITY_PASSTHROUGH,
+ * the ADV7511 will route the signal unchanged, this is useful if the upstream
+ * graphics core will already generate the sync singals with the correct
+ * polarity.
+ */
+enum adv7511_sync_polarity {
+	ADV7511_SYNC_POLARITY_PASSTHROUGH,
+	ADV7511_SYNC_POLARITY_LOW,
+	ADV7511_SYNC_POLARITY_HIGH,
+};
+
+/**
+ * enum adv7511_timing_gen_seq - Selects the order in which timing adjustments
+ * are performed
+ * @ADV7511_TIMING_GEN_SEQ_SYN_ADJ_FIRST: Sync adjustment first,
+ *					  then DE generation
+ * @ADV7511_TIMING_GEN_SEQ_DE_GEN_FIRST: DE generation first,
+ *					 then sync adjustment
+ *
+ * This setting is only relevant if both DE generation and sync adjustment are
+ * active.
+ */
+enum adv7511_timing_gen_seq {
+	ADV7511_TIMING_GEN_SEQ_SYN_ADJ_FIRST = 0,
+	ADV7511_TIMING_GEN_SEQ_DE_GEN_FIRST = 1,
+};
+
+/**
+ * enum adv7511_up_conversion - Selects the upscaling conversion method
+ * @ADV7511_UP_CONVERSION_ZERO_ORDER: Use zero order up conversion
+ * @ADV7511_UP_CONVERSION_FIRST_ORDER: Use first order up conversion
+ *
+ * This used when converting from a 4:2:2 format to a 4:4:4 format.
+ */
+enum adv7511_up_conversion {
+	ADV7511_UP_CONVERSION_ZERO_ORDER = 0,
+	ADV7511_UP_CONVERSION_FIRST_ORDER = 1,
+};
+
+/**
+ * struct adv7511_link_config - Describes adv7511 hardware configuration
+ * @id:				Video input format id
+ * @input_style:		Video input format style
+ * @sync_pulse:			Select the sync pulse
+ * @clock_delay:		Clock delay for the input clock
+ * @reverse_bitorder:		Reverse video input signal bitorder
+ * @bit_justification:		Video input format bit justification
+ * @up_conversion:		Selects the upscaling conversion method
+ * @input_color_depth:		Input video format color depth
+ * @tmds_clock_inversion:	Whether to invert the TDMS clock
+ * @timing_gen_seq:		Selects the order in which sync DE generation
+ *				and sync adjustment are performt.
+ * @rgb:			Whether rgb format is configured
+ * @vsync_polarity:		vsync input signal configuration
+ * @hsync_polarity:		hsync input signal configuration
+ * @gpio_pd:			GPIO controlling the PD (powerdown) pin
+ */
+struct adv7511_link_config {
+	enum adv7511_input_id id;
+	enum adv7511_input_style input_style;
+	enum adv7511_input_sync_pulse sync_pulse;
+	enum adv7511_input_clock_delay clock_delay;
+	bool reverse_bitorder;
+	enum adv7511_input_bit_justifiction bit_justification;
+	enum adv7511_up_conversion up_conversion;
+	enum adv7511_input_color_depth input_color_depth;
+	bool tmds_clock_inversion;
+	enum adv7511_timing_gen_seq timing_gen_seq;
+	bool rgb;
+
+	enum adv7511_sync_polarity vsync_polarity;
+	enum adv7511_sync_polarity hsync_polarity;
+
+	int gpio_pd;
+};
+
+/*
+ *	adi,input-style = 1|2|3;
+ *	adi,input-id + *		"24-bit-rgb444-ycbcr444",
+ *		"16-20-24-bit-ycbcr422-separate-sync" |
+ *		"16-20-24-bit-ycbcr422-embedded-sync" |
+ *		"8-10-12-bit-ycbcr422-separate-sync" |
+ *		"8-10-12-bit-ycbcr422-embedded-sync" |
+ *		"12-15-16-bit-rgb444-ycbcr444"
+ *	adi,sync-pulse = "de","vsync","hsync","none"
+ *	adi,clock-delay = -1200|-800|-400|0|400|800|1200|1600
+ *	adi,reverse-bitorder
+ *	adi,bit-justification = "left"|"right"|"evently";
+ *	adi,up-conversion = "zero-order"|"first-order"
+ *	adi,input-color-depth = 8|10|12
+ *	adi,tdms-clock-inversion
+ *	adi,vsync-polarity = "low"|"high"|"passthrough"
+ *	adi,hsync-polarity = "low"|"high"|"passtrhough"
+ *	adi,timing-gen-seq = "sync-adjustment-first"|"de-generation-first"
+ */
+
+/**
+ * enum adv7511_csc_scaling - Scaling factor for the ADV7511 CSC
+ * @ADV7511_CSC_SCALING_1: CSC results are not scaled
+ * @ADV7511_CSC_SCALING_2: CSC results are scaled by a factor of two
+ * @ADV7511_CSC_SCALING_4: CSC results are scalled by a factor of four
+ */
+enum adv7511_csc_scaling {
+	ADV7511_CSC_SCALING_1 = 0,
+	ADV7511_CSC_SCALING_2 = 1,
+	ADV7511_CSC_SCALING_4 = 2,
+};
+
+/**
+ * struct adv7511_video_config - Describes adv7511 hardware configuration
+ * @csc_enable:			Whether to enable color space conversion
+ * @csc_scaling_factor:		Color space conversion scaling factor
+ * @csc_coefficents:		Color space conversion coefficents
+ * @hdmi_mode:			Whether to use HDMI or DVI output mode
+ * @avi_infoframe:		HDMI infoframe
+ */
+struct adv7511_video_config {
+	bool csc_enable;
+	enum adv7511_csc_scaling csc_scaling_factor;
+	const uint16_t *csc_coefficents;
+
+	bool hdmi_mode;
+	struct hdmi_avi_infoframe avi_infoframe;
+};
+
+struct adv7511 {
+	struct i2c_client *i2c_main;
+	struct i2c_client *i2c_edid;
+	struct i2c_client *i2c_packet;
+	struct i2c_client *i2c_cec;
+
+	struct regmap *regmap;
+	struct regmap *packet_memory_regmap;
+	enum drm_connector_status status;
+	int dpms_mode;
+
+	unsigned int f_tmds;
+
+	unsigned int current_edid_segment;
+	uint8_t edid_buf[256];
+
+	wait_queue_head_t wq;
+	struct drm_encoder *encoder;
+
+	bool embedded_sync;
+	enum adv7511_sync_polarity vsync_polarity;
+	enum adv7511_sync_polarity hsync_polarity;
+
+	bool rgb;
+
+	struct edid *edid;
+
+	int gpio_pd;
+};
+
+#endif /* __DRM_I2C_ADV7511_H__ */
-- 
1.8.3.2

