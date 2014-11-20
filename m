From: Simon Horman <horms@verge.net.au>
Date: Thu, 20 Nov 2014 01:45:47 +0000
Subject: Re: [PATCH] media: soc_camera: rcar_vin: Fix alignment of clipping size
Message-Id: <20141120014547.GA29752@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414746610-23194-1-git-send-email-ykaneko0929@gmail.com>
 <5453915E.3020100@cogentembedded.com>
In-Reply-To: <5453915E.3020100@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-media@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hi,

On Fri, Oct 31, 2014 at 04:40:46PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 10/31/2014 12:10 PM, Yoshihiro Kaneko wrote:
> 
> >From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> 
> >Since the Start Line Pre-Clip register, the Start Pixel Pre-Clip
> >register and the End Line Post-Clip register do not have restriction
> 
>    Hm, my R-Car H1 manual says to specify an even number for the Start Pixel
> Pre-Clip Register.

Thanks. I have confirmed with Matsuoka-san that you are correct.

It seems to me that the following portion of the patch should be removed
accordingly.

--- a/drivers/media/platform/soc_camera/rcar_vin.c
+++ b/drivers/media/platform/soc_camera/rcar_vin.c
@@ -1558,8 +1558,8 @@ static int rcar_vin_set_crop(struct soc_camera_device *icd,
        cam->width = mf.width;
        cam->height = mf.height;

-       cam->vin_left = rect->left & ~1;
-       cam->vin_top = rect->top & ~1;
+       cam->vin_left = rect->left;
+       cam->vin_top = rect->top;

        /* Use VIN cropping to crop to the new window. */
        ret = rcar_vin_set_rect(icd);

> >of H/W to a setting value, the processing of alignment is unnecessary.
> >This patch corrects so that processing of alignment is not performed.
> 
> >However, the End Pixel Post-Clip register has restriction
> >of H/W which must be an even number value at the time of the
> >output of YCbCr-422 format. By this patch, the processing of
> >alignment to an even number value is added on the above-mentioned
> >conditions.
> 
>    Well, the R-Car H1/M1A manuals don't specify such restriction.

Thanks, I have confirmed with Matsuoka-san that the above text
is somewhat misleading. And I think it should read something more like this:

	In the case where YCbCr-422 is used and
	(End pixel post clip) - (Start pixel post clip) is
	odd one will be added by the hardware to round it up
	to an even number.

I see this in section 26.2.11 Video n End Pixel Post-Clip Register (VnEPPoC)
if the R-Car Gen 2 manual.

> >The variable set to a register is as follows.
> 
> >  - Start Line Pre-Clip register
> >    cam->vin_top
> >  - Start Pixel Pre-Clip register
> >    cam->vin_left
> >  - End Line Post-Clip register
> >    pix->height
> >  - End Pixel Post-Clip register
> >    pix->width
> 
> >Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> >Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> >---
> >  drivers/media/platform/soc_camera/rcar_vin.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> >diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
> >index d3d2f7d..1934e15 100644
> >--- a/drivers/media/platform/soc_camera/rcar_vin.c
> >+++ b/drivers/media/platform/soc_camera/rcar_vin.c
> [...]
> >@@ -1761,8 +1761,18 @@ static int rcar_vin_try_fmt(struct soc_camera_device *icd,
> >  	}
> >
> >  	/* FIXME: calculate using depth and bus width */
> >-	v4l_bound_align_image(&pix->width, 2, VIN_MAX_WIDTH, 1,
> >-			      &pix->height, 4, VIN_MAX_HEIGHT, 2, 0);
> >+	/*
> >+	 * When performing a YCbCr-422 format output, even if it performs
> >+	 * odd number clipping by pixel post clip processing, it is outputted
> 
>    s/outputted/output/ -- it's an irregular verb.
> 
> >+	 * to a memory per even pixels.
> >+	 */
> >+	if ((pixfmt = V4L2_PIX_FMT_NV16) || (pixfmt = V4L2_PIX_FMT_YUYV) ||
> >+		(pixfmt = V4L2_PIX_FMT_UYVY))
> 
>    This is certainly asking to be a *switch* statement instead...
> 
> >+		v4l_bound_align_image(&pix->width, 5, VIN_MAX_WIDTH, 1,
> >+				      &pix->height, 2, VIN_MAX_HEIGHT, 0, 0);
> >+	else
> >+		v4l_bound_align_image(&pix->width, 5, VIN_MAX_WIDTH, 0,
> >+				      &pix->height, 2, VIN_MAX_HEIGHT, 0, 0);
> 
> WBR, Sergei
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
