From: kbuild test robot <lkp@intel.com>
Date: Tue, 20 Feb 2018 05:22:23 +0000
Subject: [RFC PATCH] media: i2c: ov772x: ov772x_frame_intervals[] can be static
Message-Id: <20180220052223.GA27152@lkp-sb04>
List-Id: <linux-sh.vger.kernel.org>
References: <1519059584-30844-8-git-send-email-jacopo+renesas@jmondi.org>
In-Reply-To: <1519059584-30844-8-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: kbuild-all@01.org, laurent.pinchart@ideasonboard.com, magnus.damm@gmail.com, geert@glider.be, hverkuil@xs4all.nl, mchehab@kernel.org, festevam@gmail.com, sakari.ailus@iki.fi, robh+dt@kernel.org, mark.rutland@arm.com, pombredanne@nexb.com, linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org


Fixes: 42b7d5be5f1f ("media: i2c: ov772x: Support frame interval handling")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 ov772x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/ov772x.c b/drivers/media/i2c/ov772x.c
index eba71d97..0d8ce2a 100644
--- a/drivers/media/i2c/ov772x.c
+++ b/drivers/media/i2c/ov772x.c
@@ -532,7 +532,7 @@ static const struct ov772x_win_size ov772x_win_sizes[] = {
 /*
  * frame rate settings lists
  */
-unsigned int ov772x_frame_intervals[] = { 5, 10, 15, 20, 30, 60 };
+static unsigned int ov772x_frame_intervals[] = { 5, 10, 15, 20, 30, 60 };
 #define OV772X_N_FRAME_INTERVALS ARRAY_SIZE(ov772x_frame_intervals)
 
 /*
