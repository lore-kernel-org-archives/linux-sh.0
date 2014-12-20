From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 20 Dec 2014 18:35:47 +0000
Subject: Re: [PATCH/RFC] v4l: vsp1: Add format for Mem2Mem Playback
Message-Id: <2411607.P54SbLLsL0@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1419084963-18832-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1419084963-18832-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: linux-media@vger.kernel.org, Mauro Carvalho Chehab <m.chehab@samsung.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hello Kaneko-san,

Thank you for the patch.


On Saturday 20 December 2014 23:16:03 Yoshihiro Kaneko wrote:
> From: Hiroki Negishi <hiroki.negishi.zr@hitachi-solutions.com>
> 
> Signed-off-by: Hiroki Negishi <hiroki.negishi.zr@hitachi-solutions.com>
> Signed-off-by: Yoshifumi Hosoya <yoshifumi.hosoya.wj@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
> 
> This patch is based on the master branch of linuxtv.org/media_tree.git.
> 
>  drivers/media/platform/vsp1/vsp1_video.c | 3 +++
>  include/uapi/linux/videodev2.h           | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/media/platform/vsp1/vsp1_video.c
> b/drivers/media/platform/vsp1/vsp1_video.c index e512336..9bbc02a 100644
> --- a/drivers/media/platform/vsp1/vsp1_video.c
> +++ b/drivers/media/platform/vsp1/vsp1_video.c
> @@ -130,6 +130,9 @@ static const struct vsp1_format_info
> vsp1_video_formats[] = { VI6_FMT_Y_U_V_420, VI6_RPF_DSWAP_P_LLS |
> VI6_RPF_DSWAP_P_LWS | VI6_RPF_DSWAP_P_WDS | VI6_RPF_DSWAP_P_BTS,
>  	  3, { 8, 8, 8 }, false, false, 2, 2, false },
> +	{ V4L2_PIX_FMT_RGB32S, MEDIA_BUS_FMT_ARGB8888_1X32,
> +	  VI6_FMT_ARGB_8888, VI6_RPF_DSWAP_P_LLS | VI6_RPF_DSWAP_P_LWS,
> +	  1, { 32, 0, 0 }, false, false, 1, 1, false },
>  };
> 
>  /*
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev2.h
> index d279c1b..f22e167 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -396,6 +396,9 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_ARGB32  v4l2_fourcc('B', 'A', '2', '4') /* 32 
> ARGB-8-8-8-8  */ #define V4L2_PIX_FMT_XRGB32  v4l2_fourcc('B', 'X', '2',
> '4') /* 32  XRGB-8-8-8-8  */
> 
> +/* RGB formats for memory output */
> +#define V4L2_PIX_FMT_RGB32S  v4l2_fourcc('R', 'G', '4', 'S') /* 32
> RGB-8-8-8-8 */ +

When adding a new format V4L2 also requires a documentation update to describe 
the format. I assume your format falls in the category of packed RGB formats, 
could you thus please update Documentation/DocBook/media/v4l/pixfmt-packed-
rgb.xml in this patch as well ?

>  /* Grey formats */
>  #define V4L2_PIX_FMT_GREY    v4l2_fourcc('G', 'R', 'E', 'Y') /*  8 
> Greyscale     */ #define V4L2_PIX_FMT_Y4      v4l2_fourcc('Y', '0', '4', '
> ') /*  4  Greyscale     */

-- 
Regards,

Laurent Pinchart

