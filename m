From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 24 Jul 2012 14:40:21 +0000
Subject: [PATCH v2 4/6] pwm_backlight: Add deferred probe support
Message-Id: <1343140823-13754-5-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

If the PWM instance is not available yet at probe time, request a
deferred probe.

A better way to fix might be to create a PWM subsystem (possibly
integrated into the GPIO subsystem) to support generic PWM objects, and
make sure the subsystem gets initialized first.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Tested-by: Simon Horman <horms@verge.net.au>
---
 drivers/video/backlight/pwm_bl.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 342b7d7..5df8b91 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -121,6 +121,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 	if (IS_ERR(pb->pwm)) {
 		dev_err(&pdev->dev, "unable to request PWM for backlight\n");
 		ret = PTR_ERR(pb->pwm);
+		if (ret = -ENODEV)
+			ret = -EPROBE_DEFER;
 		goto err_alloc;
 	} else
 		dev_dbg(&pdev->dev, "got pwm for backlight\n");
-- 
1.7.8.6

