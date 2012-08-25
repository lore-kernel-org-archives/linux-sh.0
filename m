From: Simon Horman <horms@verge.net.au>
Date: Sat, 25 Aug 2012 06:57:12 +0000
Subject: Re: [PATCH v2 4/6] pwm_backlight: Add deferred probe support
Message-Id: <20120825065709.GG29755@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1343140823-13754-5-git-send-email-laurent.pinchart@ideasonboard.com>
In-Reply-To: <1343140823-13754-5-git-send-email-laurent.pinchart@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 24, 2012 at 04:40:21PM +0200, Laurent Pinchart wrote:
> If the PWM instance is not available yet at probe time, request a
> deferred probe.
> 
> A better way to fix might be to create a PWM subsystem (possibly
> integrated into the GPIO subsystem) to support generic PWM objects, and
> make sure the subsystem gets initialized first.

Hi Richard,

I am wondering if you have had a chance to review this change.
I believe that it is a pre-requisite for work that Laurent has
done to enable the backlight on the Armadillo 800 EVA board.

If the change is ok I am happy to take it through
my shmobile tree if that makes life easier for you.

Below is an updated version of the patch which applies on top of 3.6-rc3.

From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

pwm_backlight: Add deferred probe support

If the PWM instance is not available yet at probe time, request a
deferred probe.

A better way to fix might be to create a PWM subsystem (possibly
integrated into the GPIO subsystem) to support generic PWM objects, and
make sure the subsystem gets initialized first.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms@verge.net.au>

diff --git a/drivers/video/backlight/pwm_bl.c b/drivers/video/backlight/pwm_bl.c
index 995f016..cc71f87 100644
--- a/drivers/video/backlight/pwm_bl.c
+++ b/drivers/video/backlight/pwm_bl.c
@@ -221,6 +221,8 @@ static int pwm_backlight_probe(struct platform_device *pdev)
 		if (IS_ERR(pb->pwm)) {
 			dev_err(&pdev->dev, "unable to request legacy PWM\n");
 			ret = PTR_ERR(pb->pwm);
+			if (ret = -ENODEV)
+				ret = -EPROBE_DEFER;
 			goto err_alloc;
 		}
 	}
