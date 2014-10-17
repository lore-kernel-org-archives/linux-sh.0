From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 17 Oct 2014 08:01:07 +0000
Subject: Re: [PATCH v2] media: soc_camera: rcar_vin: Add r8a7794, r8a7793 device support
Message-Id: <2001400.nVOdqiCF3c@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1413529659-7752-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1413529659-7752-1-git-send-email-ykaneko0929@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Cc: linux-media@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hi Kaneko-san,

Thank you for the patch.

Could you please also update 
Documentation/devicetree/bindings/media/rcar_vin.txt with the new compatible 
strings ?

On Friday 17 October 2014 16:07:39 Yoshihiro Kaneko wrote:
> From: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> 
> Signed-off-by: Koji Matsuoka <koji.matsuoka.xm@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> 
> ---
> 
> This patch is against master branch of linuxtv.org/media_tree.git.
> 
> v2 [Yoshihiro Kaneko]
> * Squashed r8a7793 and r8a7794 patches
> 
>  drivers/media/platform/soc_camera/rcar_vin.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/media/platform/soc_camera/rcar_vin.c
> b/drivers/media/platform/soc_camera/rcar_vin.c index 234cf86..4acae8f
> 100644
> --- a/drivers/media/platform/soc_camera/rcar_vin.c
> +++ b/drivers/media/platform/soc_camera/rcar_vin.c
> @@ -1881,6 +1881,8 @@ MODULE_DEVICE_TABLE(of, rcar_vin_of_table);
>  #endif
> 
>  static struct platform_device_id rcar_vin_id_table[] = {
> +	{ "r8a7794-vin",  RCAR_GEN2 },
> +	{ "r8a7793-vin",  RCAR_GEN2 },
>  	{ "r8a7791-vin",  RCAR_GEN2 },
>  	{ "r8a7790-vin",  RCAR_GEN2 },
>  	{ "r8a7779-vin",  RCAR_H1 },

-- 
Regards,

Laurent Pinchart

