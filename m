From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 30 Apr 2015 11:22:02 +0000
Subject: Re: [PATCH/RFC] v4l: vsp1: Align crop rectangle to even boundary for YUV formats
Message-Id: <5542105A.1010601@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430327133-8461-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1430327133-8461-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hello.

On 4/29/2015 8:05 PM, Yoshihiro Kaneko wrote:

> From: Damian Hobson-Garcia <dhobsong@igel.co.jp>

> Make sure that there are valid values in the crop rectangle to ensure
> that the color plane doesn't get shifted when cropping.
> Since there is no distintion between 12bit and 16bit YUV formats in

    Вistinсtion.

> at the subdev level, use the more restrictive 12bit limits for all YUV
> formats.

> Signed-off-by: Damian Hobson-Garcia <dhobsong@igel.co.jp>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---

> This patch is based on the master branch of linuxtv.org/media_tree.git.

>   drivers/media/platform/vsp1/vsp1_rwpf.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)

> diff --git a/drivers/media/platform/vsp1/vsp1_rwpf.c b/drivers/media/platform/vsp1/vsp1_rwpf.c
> index fa71f46..9fed0b2 100644
> --- a/drivers/media/platform/vsp1/vsp1_rwpf.c
> +++ b/drivers/media/platform/vsp1/vsp1_rwpf.c
> @@ -197,11 +197,21 @@ int vsp1_rwpf_set_selection(struct v4l2_subdev *subdev,
>   	 */
>   	format = vsp1_entity_get_pad_format(&rwpf->entity, cfg, RWPF_PAD_SINK,
>   					    sel->which);
> +
> +	if (format->code = MEDIA_BUS_FMT_AYUV8_1X32) {
> +		sel->r.left = (sel->r.left + 1) & ~1;
> +		sel->r.top = (sel->r.top + 1) & ~1;

    There's ALIGN() macro just for that.

> +		sel->r.width = (sel->r.width) & ~1;
> +		sel->r.height = (sel->r.height) & ~1;

    Parens not needed.

> +	}
> +
>   	sel->r.left = min_t(unsigned int, sel->r.left, format->width - 2);
>   	sel->r.top = min_t(unsigned int, sel->r.top, format->height - 2);
>   	if (rwpf->entity.type = VSP1_ENTITY_WPF) {
> -		sel->r.left = min_t(unsigned int, sel->r.left, 255);
> -		sel->r.top = min_t(unsigned int, sel->r.top, 255);
> +		int maxcrop > +			format->code = MEDIA_BUS_FMT_AYUV8_1X32 ? 254 : 255;

    I think you need an empty line here.

> +		sel->r.left = min_t(unsigned int, sel->r.left, maxcrop);
> +		sel->r.top = min_t(unsigned int, sel->r.top, maxcrop);
>   	}
>   	sel->r.width = min_t(unsigned int, sel->r.width,
>   			     format->width - sel->r.left);

WBR, Sergei

