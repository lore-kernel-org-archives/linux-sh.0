From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 31 Oct 2014 13:00:22 +0000
Subject: Re: [PATCH] media: soc_camera: rcar_vin: Add BT.709 24-bit RGB888 input support
Message-Id: <545387E6.4020707@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414746490-23077-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1414746490-23077-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>, linux-media@vger.kernel.org
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hello.

On 10/31/2014 12:08 PM, Yoshihiro Kaneko wrote:

> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>

> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---

> This patch is against master branch of linuxtv.org/media_tree.git.

> v3 [Yoshihiro Kaneko]
> * fixes the detection of RGB input

> v2 [Yoshihiro Kaneko]
> * remove unused definition as suggested by Sergei Shtylyov
> * use VNMC_INF_RGB888 directly instead of VNMC_INF_RGB_MASK as a bit-field
>    mask

>   drivers/media/platform/soc_camera/rcar_vin.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)

> diff --git a/drivers/media/platform/soc_camera/rcar_vin.c b/drivers/media/platform/soc_camera/rcar_vin.c
> index 20defcb..18ce4bd 100644
> --- a/drivers/media/platform/soc_camera/rcar_vin.c
> +++ b/drivers/media/platform/soc_camera/rcar_vin.c
[...]
> @@ -331,6 +336,15 @@ static int rcar_vin_setup(struct rcar_vin_priv *priv)
>   	if (output_is_yuv)
>   		vnmc |= VNMC_BPS;
>
> +        /*

    Please indent with a tab, not spaces.

> +	 * The above assumes YUV input, toggle BPS for RGB input.
> +	 * RGB inputs can be detected by checking that the most-significant
> +	 * two bits of INF are set. This corresponds to the bits
> +	 * set in VNMC_INF_RGB888.
> +	 */
> +	if ((vnmc & VNMC_INF_RGB888)) = VNMC_INF_RGB888)
> +		vnmc ^= VNMC_BPS;
> +
>   	/* progressive or interlaced mode */
>   	interrupts = progressive ? VNIE_FIE | VNIE_EFE : VNIE_EFE;
>

WBR, Sergei

