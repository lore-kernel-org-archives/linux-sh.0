From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 02 Apr 2014 23:57:33 +0000
Subject: Re: [PATCH] drm/cma: Use dma_mmap_writecombine() to mmap buffer
Message-Id: <3755888.heYZqb6SrS@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1393787388-17395-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1393787388-17395-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Airlie <airlied@linux.ie>
Cc: dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org

Hi Dave,

Could you please take this patch in your tree ?

On Sunday 02 March 2014 20:09:48 Laurent Pinchart wrote:
> The GEM CMA helpers uses a custom mmap implementation based on
> remap_pfn_range(). While this works when the buffer DMA and physical
> addresses are identical, it fails to take IOMMU into account and tries
> to mmap the buffer to userspace using the DMA virtual address instead of
> the physical address. This results in mapping random physical pages when
> the device is behind an IOMMU.
> 
> Use the DMA mapping dma_mmap_writecombine() function instead.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/gpu/drm/drm_gem_cma_helper.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> This patches fixes a problem noticed when enabling IOMMU usage with the
> Renesas R-Car DU driver. I've tested it both with the IOMMU enabled and
> disabled.
> 
> diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c
> b/drivers/gpu/drm/drm_gem_cma_helper.c index 6b51bf9..1d4fd34 100644
> --- a/drivers/gpu/drm/drm_gem_cma_helper.c
> +++ b/drivers/gpu/drm/drm_gem_cma_helper.c
> @@ -253,8 +253,17 @@ static int drm_gem_cma_mmap_obj(struct
> drm_gem_cma_object *cma_obj, {
>  	int ret;
> 
> -	ret = remap_pfn_range(vma, vma->vm_start, cma_obj->paddr >> PAGE_SHIFT,
> -			vma->vm_end - vma->vm_start, vma->vm_page_prot);
> +	/*
> +	 * Clear the VM_PFNMAP flag that was set by drm_gem_mmap(), and set the
> +	 * vm_pgoff (used as a fake buffer offset by DRM) to 0 as we want to map
> +	 * the whole buffer.
> +	 */
> +	vma->vm_flags &= ~VM_PFNMAP;
> +	vma->vm_pgoff = 0;
> +
> +	ret = dma_mmap_writecombine(cma_obj->base.dev->dev, vma,
> +				    cma_obj->vaddr, cma_obj->paddr,
> +				    vma->vm_end - vma->vm_start);
>  	if (ret)
>  		drm_gem_vm_close(vma);

-- 
Regards,

Laurent Pinchart

