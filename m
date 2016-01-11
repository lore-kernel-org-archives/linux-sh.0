From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 11 Jan 2016 18:35:17 +0000
Subject: Re: [PATCH 3/3] media: soc_camera: rcar_vin: Add ARGB8888 caputre format support
Message-Id: <5693F5E5.3060109@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1452535211-4869-1-git-send-email-ykaneko0929@gmail.com>
 <1452535211-4869-4-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1452535211-4869-4-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-media@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hello.

On 01/11/2016 09:00 PM, Yoshihiro Kaneko wrote:

> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
>
> This patch adds ARGB8888 capture format support for R-Car Gen3.
>
> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
>   drivers/media/platform/soc_camera/rcar_vin.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
> index cccd859..afe27bb 100644
> --- a/drivers/media/platform/soc_camera/rcar_vin.c
> +++ b/drivers/media/platform/soc_camera/rcar_vin.c
[...]
> @@ -654,6 +654,14 @@ static int rcar_vin_setup(struct rcar_vin_priv *priv)
>   			dmr = VNDMR_EXRGB;
>   			break;
>   		}
> +	case V4L2_PIX_FMT_ARGB32:
> +		if (priv->chip = RCAR_GEN3)
> +			dmr = VNDMR_EXRGB | VNDMR_DTMD_ARGB;
> +		else {

    Kernel coding style dictates using {} in all *if* branches if at least one 
branch has them.

> +			dev_err(icd->parent, "Not support format\n");
> +			return -EINVAL;
> +		}
> +		break;
>   	default:
>   		dev_warn(icd->parent, "Invalid fourcc format (0x%x)\n",
>   			 icd->current_fmt->host_fmt->fourcc);
[...]

MBR, Sergei

