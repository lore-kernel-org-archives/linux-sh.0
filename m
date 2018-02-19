From: Jacopo Mondi <jacopo+renesas@jmondi.org>
Date: Mon, 19 Feb 2018 16:59:44 +0000
Subject: [PATCH v9 11/11] media: i2c: ov7670: Fully set mbus frame fmt
Message-Id: <1519059584-30844-12-git-send-email-jacopo+renesas@jmondi.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1519059584-30844-1-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1519059584-30844-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: laurent.pinchart@ideasonboard.com, magnus.damm@gmail.com, geert@glider.be, hverkuil@xs4all.nl, mchehab@kernel.org, festevam@gmail.com, sakari.ailus@iki.fi, robh+dt@kernel.org, mark.rutland@arm.com, pombredanne@nexb.com
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

The sensor driver sets mbus format colorspace information and sizes,
but not ycbcr encoding, quantization and xfer function. When supplied
with an badly initialized mbus frame format structure, those fields
need to be set explicitly not to leave them uninitialized. This is
tested by v4l2-compliance, which supplies a mbus format description
structure and checks for all fields to be properly set.

Without this commit, v4l2-compliance fails when testing formats with:
fail: v4l2-test-formats.cpp(335): ycbcr_enc >= 0xff

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 drivers/media/i2c/ov7670.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/i2c/ov7670.c b/drivers/media/i2c/ov7670.c
index 25b26d4..61c472e 100644
--- a/drivers/media/i2c/ov7670.c
+++ b/drivers/media/i2c/ov7670.c
@@ -996,6 +996,10 @@ static int ov7670_try_fmt_internal(struct v4l2_subdev *sd,
 	fmt->height = wsize->height;
 	fmt->colorspace = ov7670_formats[index].colorspace;
 
+	fmt->ycbcr_enc = V4L2_YCBCR_ENC_DEFAULT;
+	fmt->quantization = V4L2_QUANTIZATION_DEFAULT;
+	fmt->xfer_func = V4L2_XFER_FUNC_DEFAULT;
+
 	info->format = *fmt;
 
 	return 0;
-- 
2.7.4

