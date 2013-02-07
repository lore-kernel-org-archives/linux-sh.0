From: Simon Horman <horms@verge.net.au>
Date: Thu, 07 Feb 2013 07:32:04 +0000
Subject: Re: [PATCH 2/3] drm: Renesas R-Car Display Unit DRM driver
Message-Id: <20130207073203.GB3825@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1359596703-17556-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1359596703-17556-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1359596703-17556-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org, magnus.damm@gmail.com, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

[ CC Morimoto-san ]

On Thu, Jan 31, 2013 at 02:45:02AM +0100, Laurent Pinchart wrote:
> The R-Car Display Unit (DU) DRM driver supports both superposition
> processors and all eight planes in RGB and YUV formats without alpha
> blending.
> 
> Only VGA and LVDS encoders and connectors are currently supported.

[snip]

> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 6f58c81..633bad2 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_DRM_EXYNOS) +=exynos/
>  obj-$(CONFIG_DRM_GMA500) += gma500/
>  obj-$(CONFIG_DRM_UDL) += udl/
>  obj-$(CONFIG_DRM_AST) += ast/
> +obj-$(CONFIG_DRM_RCAR_DU) += rcar-du/
>  obj-$(CONFIG_DRM_SHMOBILE) +=shmobile/
>  obj-$(CONFIG_DRM_TEGRA) += tegra/
>  obj-y			+= i2c/
> diff --git a/drivers/gpu/drm/rcar-du/Kconfig b/drivers/gpu/drm/rcar-du/Kconfig
> new file mode 100644
> index 0000000..686486d
> --- /dev/null
> +++ b/drivers/gpu/drm/rcar-du/Kconfig
> @@ -0,0 +1,11 @@
> +config DRM_RCAR_DU
> +	tristate "DRM Support for R-Car Display Unit"
> +	depends on DRM && ARCH_SHMOBILE
> +	select DRM_KMS_HELPER
> +	select DRM_KMS_CMA_HELPER
> +	select DRM_GEM_CMA_HELPER
> +	select OF

I'm not sure of a good solution, however selecting OF where
USE_OF wasn't previously selected seems to cause problems on at least
ARM because devtree.c is then compiled without OF_FLATTREE selected.

That results in the following awesomeness as pointed out to me by Morimoto-san.

arch/arm/kernel/devtree.c: In function 'arm_dt_memblock_reserve':
arch/arm/kernel/devtree.c:43:7: error: 'initial_boot_params' undeclared (first use in this function)
arch/arm/kernel/devtree.c:43:7: note: each undeclared identifier is reported only once for each function it appears in
arch/arm/kernel/devtree.c: In function 'setup_machine_fdt':
arch/arm/kernel/devtree.c:193:2: error: 'initial_boot_params' undeclared (first use in this function)
arch/arm/kernel/devtree.c:194:2: error: implicit declaration of function 'of_get_flat_dt_root'
arch/arm/kernel/devtree.c:196:3: error: implicit declaration of function 'of_flat_dt_match'
arch/arm/kernel/devtree.c:209:3: error: implicit declaration of function 'of_get_flat_dt_prop'
arch/arm/kernel/devtree.c:209:8: warning: assignment makes pointer from integer without a cast
arch/arm/kernel/devtree.c:220:8: warning: assignment makes pointer from integer without a cast
arch/arm/kernel/devtree.c:222:9: warning: assignment makes pointer from integer without a cast
arch/arm/kernel/devtree.c:228:2: error: implicit declaration of function 'of_scan_flat_dt'
arch/arm/kernel/devtree.c:228:18: error: 'early_init_dt_scan_chosen' undeclared (first use in this function)
arch/arm/kernel/devtree.c:230:18: error: 'early_init_dt_scan_root' undeclared (first use in this function)
arch/arm/kernel/devtree.c:232:18: error: 'early_init_dt_scan_memory' undeclared (first use in this function)
make[1]: *** [arch/arm/kernel/devtree.o] Error 1
