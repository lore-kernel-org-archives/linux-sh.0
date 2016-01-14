From: =?UTF-8?q?Niklas=20S=C3=B6derlund?=  <niklas.soderlund+renesas@ragnatech.se>
Date: Thu, 14 Jan 2016 13:30:14 +0000
Subject: [RFC 3/5] [media] rcar-vin: add array of supported formats
Message-Id: <1452778216-31978-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Lift over the video formats and helper from the soc_camera driver.
---
 drivers/media/platform/rcar-vin.c | 59 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/media/platform/rcar-vin.c b/drivers/media/platform/rcar-vin.c
index 06616d4..a062287 100644
--- a/drivers/media/platform/rcar-vin.c
+++ b/drivers/media/platform/rcar-vin.c
@@ -34,6 +34,12 @@ enum chip_id {
 	RCAR_E1,
 };
 
+struct rcar_vin_format {
+	const char *description;
+	u32 fourcc;
+	u8 bpp;
+};
+
 struct rcar_vin {
 	void __iomem *base;
 
@@ -181,6 +187,59 @@ static irqreturn_t rcar_vin_irq(int irq, void *dev_id)
 }
 
 /* -----------------------------------------------------------------------------
+ * Video formats
+ */
+
+static const struct rcar_vin_format rcar_vin_formats[] = {
+	{
+		.description		= "NV16",
+		.fourcc			= V4L2_PIX_FMT_NV16,
+		.bpp			= 8,
+	},
+	{
+		.description		= "YUYV",
+		.fourcc			= V4L2_PIX_FMT_YUYV,
+		.bpp			= 16,
+	},
+	{
+		.description		= "UYVY",
+		.fourcc			= V4L2_PIX_FMT_UYVY,
+		.bpp			= 16,
+	},
+	{
+		.description		= "RGB565",
+		.fourcc			= V4L2_PIX_FMT_RGB565,
+		.bpp			= 16,
+	},
+	{
+		.description		= "ARGB1555",
+		.fourcc			= V4L2_PIX_FMT_RGB555X,
+		.bpp			= 16,
+	},
+	{
+		.description		= "RGB888",
+		.fourcc			= V4L2_PIX_FMT_RGB32,
+		.bpp			= 32,
+	},
+};
+
+
+
+const struct rcar_vin_format *rcar_vin_get_format_by_fourcc(u32 fourcc)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(rcar_vin_formats); ++i) {
+		const struct rcar_vin_format *format = &rcar_vin_formats[i];
+
+		if (format->fourcc = fourcc)
+			return format;
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
+/* -----------------------------------------------------------------------------
  * Platform Device Driver
  */
 
-- 
2.7.0

