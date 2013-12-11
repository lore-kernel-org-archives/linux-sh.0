From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 11 Dec 2013 12:50:42 +0000
Subject: Re: [PATCH 12/15] thermal: rcar-thermal: Enable driver compilation with COMPILE_TEST
Message-Id: <5903007.OehDdPcG2U@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1385515117-23664-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385515117-23664-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Zhang and Eduardo,

Could you please pick this patch up for v3.14 ?

On Wednesday 27 November 2013 02:18:34 Laurent Pinchart wrote:
> This helps increasing build testing coverage.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <eduardo.valentin@ti.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Acked-by: Simon Horman <horms@verge.net.au>
> ---
>  drivers/thermal/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> index f35a1f7..661cafc 100644
> --- a/drivers/thermal/Kconfig
> +++ b/drivers/thermal/Kconfig
> @@ -121,7 +121,7 @@ config SPEAR_THERMAL
> 
>  config RCAR_THERMAL
>  	tristate "Renesas R-Car thermal driver"
> -	depends on ARCH_SHMOBILE
> +	depends on ARCH_SHMOBILE || COMPILE_TEST
>  	help
>  	  Enable this to plug the R-Car thermal sensor driver into the Linux
>  	  thermal framework.
-- 
Regards,

Laurent Pinchart

