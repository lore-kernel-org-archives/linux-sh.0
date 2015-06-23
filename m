From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 23 Jun 2015 19:28:34 +0000
Subject: Re: [PATCH] drm: rcar-du: Remove obsolete rcar-du-r8a779x platform_device_id entries
Message-Id: <2783349.h4yTnYNSAh@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1435064332-11503-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1435064332-11503-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Tuesday 23 June 2015 14:58:52 Geert Uytterhoeven wrote:
> Since commit a483dcbfa21f919c ("ARM: shmobile: lager: Remove legacy
> board support"), R-Car Gen2 SoCs are only supported in generic DT-only
> ARM multi-platform builds.  The driver doesn't need to match platform
> devices by name anymore, hence remove the corresponding
> platform_device_id entry.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

and applied to my tree.

> ---
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> b/drivers/gpu/drm/rcar-du/rcar_du_drv.c index
> 780ca11512ba6cf1..fb6709160a591a4d 100644
> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> @@ -108,8 +108,6 @@ static const struct rcar_du_device_info
> rcar_du_r8a7791_info = {
> 
>  static const struct platform_device_id rcar_du_id_table[] = {
>  	{ "rcar-du-r8a7779", (kernel_ulong_t)&rcar_du_r8a7779_info },
> -	{ "rcar-du-r8a7790", (kernel_ulong_t)&rcar_du_r8a7790_info },
> -	{ "rcar-du-r8a7791", (kernel_ulong_t)&rcar_du_r8a7791_info },
>  	{ }
>  };

-- 
Regards,

Laurent Pinchart

