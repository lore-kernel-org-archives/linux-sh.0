From: Chen Gang S <gang.chen@sunrus.com.cn>
Date: Tue, 03 Feb 2015 11:46:58 +0000
Subject: Re: [PATCH] drm: Kconfig: Let all DRM_GEM_CMA_HELPER related macros depend on HAVE_DMA_ATTRS
Message-Id: <54D0B531.10008@sunrus.com.cn>
List-Id: <linux-sh.vger.kernel.org>
References: <54CE3361.9090107@sunrus.com.cn> <2264372.TXY4G2KdxT@avalon>
In-Reply-To: <2264372.TXY4G2KdxT@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: airlied@linux.ie, p.zabel@pengutronix.de, robdclark@gmail.com, boris.brezillon@free-electrons.com, nicolas.ferre@atmel.com, benjamin.gaignard@linaro.org, jg1.han@samsung.com, dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, chris@zankel.net, jcmvbkbc@gmail.com

On 02/03/2015 06:45 PM, Laurent Pinchart wrote:
> Hi Chen,
> 
> Thank you for the patch.
> 
> On Sunday 01 February 2015 22:08:33 Chen Gang S wrote:
>> DRM_GEM_CMA_HELPER is depend on HAVE_DMA_ATTRS, or it will break the
>> building. The related error (with allmodconfig under xtensa):
>>
>>     CC [M]  drivers/gpu/drm/drm_gem_cma_helper.o
>>   drivers/gpu/drm/drm_gem_cma_helper.c: In function 'drm_gem_cma_create':
>>   drivers/gpu/drm/drm_gem_cma_helper.c:110:19: error: implicit declaration
>> of function 'dma_alloc_writecombine'
>> [-Werror=implicit-function-declaration] cma_obj->vaddr >> dma_alloc_writecombine(drm->dev, size,
>>                      ^
>>   drivers/gpu/drm/drm_gem_cma_helper.c:110:17: warning: assignment makes
>> pointer from integer without a cast [-Wint-conversion] cma_obj->vaddr >> dma_alloc_writecombine(drm->dev, size,
>>                    ^
>>   drivers/gpu/drm/drm_gem_cma_helper.c: In function
>> 'drm_gem_cma_free_object': drivers/gpu/drm/drm_gem_cma_helper.c:193:3:
>> error: implicit declaration of function 'dma_free_writecombine'
>> [-Werror=implicit-function-declaration]
>> dma_free_writecombine(gem_obj->dev->dev, cma_obj->base.size,
>>      ^
>>   drivers/gpu/drm/drm_gem_cma_helper.c: In function 'drm_gem_cma_mmap_obj':
>>   drivers/gpu/drm/drm_gem_cma_helper.c:330:8: error: implicit declaration of
>> function 'dma_mmap_writecombine' [-Werror=implicit-function-declaration]
>> ret = dma_mmap_writecombine(cma_obj->base.dev->dev, vma,
>>           ^
>>
>> Signed-off-by: Chen Gang <gang.chen.5i5j@gmail.com>
>> ---
>>  drivers/gpu/drm/Kconfig             | 3 ++-
>>  drivers/gpu/drm/atmel-hlcdc/Kconfig | 2 +-
>>  drivers/gpu/drm/imx/Kconfig         | 2 +-
>>  drivers/gpu/drm/rcar-du/Kconfig     | 2 +-
>>  drivers/gpu/drm/shmobile/Kconfig    | 2 +-
>>  drivers/gpu/drm/sti/Kconfig         | 2 +-
>>  drivers/gpu/drm/tilcdc/Kconfig      | 2 +-
>>  7 files changed, 8 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
>> index 308c104..151a050 100644
>> --- a/drivers/gpu/drm/Kconfig
>> +++ b/drivers/gpu/drm/Kconfig
>> @@ -62,12 +62,13 @@ config DRM_TTM
>>
>>  config DRM_GEM_CMA_HELPER
>>  	bool
>> -	depends on DRM
>> +	depends on DRM && HAVE_DMA_ATTRS
>>  	help
>>  	  Choose this if you need the GEM CMA helper functions
>>
>>  config DRM_KMS_CMA_HELPER
>>  	bool
>> +	depends on DRM && HAVE_DMA_ATTRS
>>  	select DRM_GEM_CMA_HELPER
>>  	select DRM_KMS_FB_HELPER
>>  	select FB_SYS_FILLRECT
>> diff --git a/drivers/gpu/drm/atmel-hlcdc/Kconfig
>> b/drivers/gpu/drm/atmel-hlcdc/Kconfig index 1a08562..219fc87 100644
>> --- a/drivers/gpu/drm/atmel-hlcdc/Kconfig
>> +++ b/drivers/gpu/drm/atmel-hlcdc/Kconfig
>> @@ -1,6 +1,6 @@
>>  config DRM_ATMEL_HLCDC
>>  	tristate "DRM Support for ATMEL HLCDC Display Controller"
>> -	depends on DRM && OF && COMMON_CLK && MFD_ATMEL_HLCDC
>> +	depends on DRM && OF && COMMON_CLK && MFD_ATMEL_HLCDC && HAVE_DMA_ATTRS
> 
> I don't like having to add the explicit dependency to all users of 
> DRM_GEM_CMA_HELPER and DRM_KMS_CMA_HELPER, but there's no way around this 
> given the select vs. depends issues in Kconfig.
> 
> A better solution in the longer term would be to implement HAVE_DMA_ATTRS 
> support for xtensa (and all the other architectures that miss it), but this 
> patch looks fine to me as an interim solution.
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> 

OK, thanks. At present, 15 archs implement HAVE_DMA_ATTRS. I guess, it
is not quite easy to let the left 15 archs support HAVE_DMA_ATTRS, so we
have to accept the current interim solution.


Thanks.
-- 
Open, share, and attitude like air, water, and life which God blessed.
