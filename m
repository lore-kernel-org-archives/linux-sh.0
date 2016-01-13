From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 13 Jan 2016 18:27:08 +0000
Subject: Re: [PATCH v3] media: soc_camera: rcar_vin: Add ARGB8888 caputre format support
Message-Id: <569696FC.1080804@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452707964-4379-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1452707964-4379-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-media@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hello.

On 01/13/2016 08:59 PM, Yoshihiro Kaneko wrote:

> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>
> This patch adds ARGB8888 capture format support for R-Car Gen3.
>
> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
>
> This patch is based on the for-4.6-1 branch of Guennadi's v4l-dvb tree.
>
> v3 [Yoshihiro Kaneko]
> * rebased to for-4.6-1 branch of Guennadi's tree.
>
> v2 [Yoshihiro Kaneko]
> * As suggested by Sergei Shtylyov
>    - fix the coding style of the braces.
>
>   drivers/media/platform/soc_camera/rcar_vin.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
> index dc75a80..466c63a 100644
> --- a/drivers/media/platform/soc_camera/rcar_vin.c
> +++ b/drivers/media/platform/soc_camera/rcar_vin.c
[...]
> @@ -654,6 +654,14 @@ static int rcar_vin_setup(struct rcar_vin_priv *priv)
>   			dmr = VNDMR_EXRGB;
>   			break;
>   		}
> +	case V4L2_PIX_FMT_ARGB32:
> +		if (priv->chip = RCAR_GEN3) {
> +			dmr = VNDMR_EXRGB | VNDMR_DTMD_ARGB;
> +		} else {
> +			dev_err(icd->parent, "Not support format\n");

    "Unsupported format" please.

[...]

MBR, Sergei

