From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 26 Jul 2010 16:20:49 +0000
Subject: [PATCH 1/5] V4L2: mediabus: add 12-bit Bayer and YUV420 pixel formats
Message-Id: <Pine.LNX.4.64.1007261748450.9816@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1007261739180.9816@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1007261739180.9816@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Media Mailing List <linux-media@vger.kernel.org>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

These formats belong to the standard format set, defined by the MIPI CSI-2
specification.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 include/media/v4l2-mediabus.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/media/v4l2-mediabus.h b/include/media/v4l2-mediabus.h
index 865cda7..584e1b1 100644
--- a/include/media/v4l2-mediabus.h
+++ b/include/media/v4l2-mediabus.h
@@ -41,6 +41,11 @@ enum v4l2_mbus_pixelcode {
 	V4L2_MBUS_FMT_SBGGR10_2X8_PADHI_BE,
 	V4L2_MBUS_FMT_SBGGR10_2X8_PADLO_BE,
 	V4L2_MBUS_FMT_SGRBG8_1X8,
+	V4L2_MBUS_FMT_SBGGR12_1X12,
+	V4L2_MBUS_FMT_YUYV8_1_5X8,
+	V4L2_MBUS_FMT_YVYU8_1_5X8,
+	V4L2_MBUS_FMT_UYVY8_1_5X8,
+	V4L2_MBUS_FMT_VYUY8_1_5X8,
 };
 
 /**
-- 
1.6.2.4

