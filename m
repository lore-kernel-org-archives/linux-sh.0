From: Chen Gang S <gang.chen@sunrus.com.cn>
Date: Mon, 02 Feb 2015 21:26:58 +0000
Subject: Re: [PATCH] drm: Kconfig: Let all DRM_GEM_CMA_HELPER related macros depend on HAVE_DMA_ATTRS
Message-Id: <54CFEBA2.9070801@sunrus.com.cn>
List-Id: <linux-sh.vger.kernel.org>
References: <54CE3361.9090107@sunrus.com.cn>
In-Reply-To: <54CE3361.9090107@sunrus.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, p.zabel@pengutronix.de, laurent.pinchart@ideasonboard.com
Cc: robdclark@gmail.com, boris.brezillon@free-electrons.com, nicolas.ferre@atmel.com, benjamin.gaignard@linaro.org, jg1.han@samsung.com, dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, chris@zankel.net, jcmvbkbc@gmail.com


After this fixing building patch, xtensa can pass allmodconfig.

 - There are still several warnings for it (I sent several patches for
   them, but not for all).

 - Xtensa gcc5 cross compiler has issues:

   it causes more than 10 broken areas with allmodconfig (but no issues
   with defconfig). I guess, in fact, it is only 1 real issue (which can
   cause all breaks), and I shall try to fix it within this month.

Welcome any ideas, suggestions, or completions.

Thanks.

On 2/1/15 22:08, Chen Gang S wrote:
> DRM_GEM_CMA_HELPER is depend on HAVE_DMA_ATTRS, or it will break the
> building. The related error (with allmodconfig under xtensa):
> 
>     CC [M]  drivers/gpu/drm/drm_gem_cma_helper.o
>   drivers/gpu/drm/drm_gem_cma_helper.c: In function 'drm_gem_cma_create':
>   drivers/gpu/drm/drm_gem_cma_helper.c:110:19: error: implicit declaration of function 'dma_alloc_writecombine' [-Werror=implicit-function-declaration]
>     cma_obj->vaddr = dma_alloc_writecombine(drm->dev, size,
>                      ^
>   drivers/gpu/drm/drm_gem_cma_helper.c:110:17: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
>     cma_obj->vaddr = dma_alloc_writecombine(drm->dev, size,
>                    ^
>   drivers/gpu/drm/drm_gem_cma_helper.c: In function 'drm_gem_cma_free_object':
>   drivers/gpu/drm/drm_gem_cma_helper.c:193:3: error: implicit declaration of function 'dma_free_writecombine' [-Werror=implicit-function-declaration]
>      dma_free_writecombine(gem_obj->dev->dev, cma_obj->base.size,
>      ^
>   drivers/gpu/drm/drm_gem_cma_helper.c: In function 'drm_gem_cma_mmap_obj':
>   drivers/gpu/drm/drm_gem_cma_helper.c:330:8: error: implicit declaration of function 'dma_mmap_writecombine' [-Werror=implicit-function-declaration]
>     ret = dma_mmap_writecombine(cma_obj->base.dev->dev, vma,
>           ^
> 
> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
> ---
>  drivers/gpu/drm/Kconfig             | 3 ++-
>  drivers/gpu/drm/atmel-hlcdc/Kconfig | 2 +-
>  drivers/gpu/drm/imx/Kconfig         | 2 +-
>  drivers/gpu/drm/rcar-du/Kconfig     | 2 +-
>  drivers/gpu/drm/shmobile/Kconfig    | 2 +-
>  drivers/gpu/drm/sti/Kconfig         | 2 +-
>  drivers/gpu/drm/tilcdc/Kconfig      | 2 +-
>  7 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 308c104..151a050 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -62,12 +62,13 @@ config DRM_TTM
>  
>  config DRM_GEM_CMA_HELPER
>  	bool
> -	depends on DRM
> +	depends on DRM && HAVE_DMA_ATTRS
>  	help
>  	  Choose this if you need the GEM CMA helper functions
>  
>  config DRM_KMS_CMA_HELPER
>  	bool
> +	depends on DRM && HAVE_DMA_ATTRS
>  	select DRM_GEM_CMA_HELPER
>  	select DRM_KMS_FB_HELPER
>  	select FB_SYS_FILLRECT
> diff --git a/drivers/gpu/drm/atmel-hlcdc/Kconfig b/drivers/gpu/drm/atmel-hlcdc/Kconfig
> index 1a08562..219fc87 100644
> --- a/drivers/gpu/drm/atmel-hlcdc/Kconfig
> +++ b/drivers/gpu/drm/atmel-hlcdc/Kconfig
> @@ -1,6 +1,6 @@
>  config DRM_ATMEL_HLCDC
>  	tristate "DRM Support for ATMEL HLCDC Display Controller"
> -	depends on DRM && OF && COMMON_CLK && MFD_ATMEL_HLCDC
> +	depends on DRM && OF && COMMON_CLK && MFD_ATMEL_HLCDC && HAVE_DMA_ATTRS
>  	select DRM_GEM_CMA_HELPER
>  	select DRM_KMS_HELPER
>  	select DRM_KMS_FB_HELPER
> diff --git a/drivers/gpu/drm/imx/Kconfig b/drivers/gpu/drm/imx/Kconfig
> index 5d5e4092..33cdddf 100644
> --- a/drivers/gpu/drm/imx/Kconfig
> +++ b/drivers/gpu/drm/imx/Kconfig
> @@ -5,7 +5,7 @@ config DRM_IMX
>  	select VIDEOMODE_HELPERS
>  	select DRM_GEM_CMA_HELPER
>  	select DRM_KMS_CMA_HELPER
> -	depends on DRM && (ARCH_MXC || ARCH_MULTIPLATFORM)
> +	depends on DRM && (ARCH_MXC || ARCH_MULTIPLATFORM) && HAVE_DMA_ATTRS
>  	depends on IMX_IPUV3_CORE
>  	help
>  	  enable i.MX graphics support
> diff --git a/drivers/gpu/drm/rcar-du/Kconfig b/drivers/gpu/drm/rcar-du/Kconfig
> index 2324a52..11485a4 100644
> --- a/drivers/gpu/drm/rcar-du/Kconfig
> +++ b/drivers/gpu/drm/rcar-du/Kconfig
> @@ -1,6 +1,6 @@
>  config DRM_RCAR_DU
>  	tristate "DRM Support for R-Car Display Unit"
> -	depends on DRM && ARM
> +	depends on DRM && ARM && HAVE_DMA_ATTRS
>  	depends on ARCH_SHMOBILE || COMPILE_TEST
>  	select DRM_KMS_HELPER
>  	select DRM_KMS_CMA_HELPER
> diff --git a/drivers/gpu/drm/shmobile/Kconfig b/drivers/gpu/drm/shmobile/Kconfig
> index a50fe0e..7321c41 100644
> --- a/drivers/gpu/drm/shmobile/Kconfig
> +++ b/drivers/gpu/drm/shmobile/Kconfig
> @@ -1,6 +1,6 @@
>  config DRM_SHMOBILE
>  	tristate "DRM Support for SH Mobile"
> -	depends on DRM && ARM
> +	depends on DRM && ARM && HAVE_DMA_ATTRS
>  	depends on ARCH_SHMOBILE || COMPILE_TEST
>  	select BACKLIGHT_CLASS_DEVICE
>  	select DRM_KMS_HELPER
> diff --git a/drivers/gpu/drm/sti/Kconfig b/drivers/gpu/drm/sti/Kconfig
> index d6d6b70..1fdb74b 100644
> --- a/drivers/gpu/drm/sti/Kconfig
> +++ b/drivers/gpu/drm/sti/Kconfig
> @@ -1,6 +1,6 @@
>  config DRM_STI
>  	tristate "DRM Support for STMicroelectronics SoC stiH41x Series"
> -	depends on DRM && (SOC_STIH415 || SOC_STIH416 || ARCH_MULTIPLATFORM)
> +	depends on DRM && (SOC_STIH415 || SOC_STIH416 || ARCH_MULTIPLATFORM) && HAVE_DMA_ATTRS
>  	select RESET_CONTROLLER
>  	select DRM_KMS_HELPER
>  	select DRM_GEM_CMA_HELPER
> diff --git a/drivers/gpu/drm/tilcdc/Kconfig b/drivers/gpu/drm/tilcdc/Kconfig
> index 7c3ef79..8394a0b 100644
> --- a/drivers/gpu/drm/tilcdc/Kconfig
> +++ b/drivers/gpu/drm/tilcdc/Kconfig
> @@ -1,6 +1,6 @@
>  config DRM_TILCDC
>  	tristate "DRM Support for TI LCDC Display Controller"
> -	depends on DRM && OF && ARM
> +	depends on DRM && OF && ARM && HAVE_DMA_ATTRS
>  	select DRM_KMS_HELPER
>  	select DRM_KMS_FB_HELPER
>  	select DRM_KMS_CMA_HELPER
> 

-- 
Chen Gang

Open, share, and attitude like air, water, and life which God blessed
