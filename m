From: Paul Mundt <lethal@linux-sh.org>
Date: Sun, 13 Jan 2008 16:33:02 +0000
Subject: Re: [PATCH] sh: declared coherent memory support
Message-Id: <20080113163302.GA7532@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080113135447.30289.54583.sendpatchset@clockwork.opensource.se>
In-Reply-To: <20080113135447.30289.54583.sendpatchset@clockwork.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Jan 13, 2008 at 10:54:47PM +0900, Magnus Damm wrote:
> This patch adds declared coherent memory support to the sh architecture. All
> functions are copied straight from the x86 implementation and the header files
> are adjusted to use the newfunctions instead of the former consistent_alloc()
> code.
> 
[snip]

> -	memset(vp, 0, size);
> +	if (dev = NULL || (dev->coherent_dma_mask < 0xffffffff))
> +		gfp |= GFP_DMA;
>  
This is obviously not something we care about, we don't have a ZONE_DMA,
and GFP_DMA has no meaning here. The page allocator will obviously still
do the right thing, but it's a bit ambiguous to suggest that we have some
sort of bogus limitation. The coherent_dma_mask is basically unintersting
in the general case, there are two situations in which we care about it,
and those are > 32-bits physical, or a restricted address space. In the
latter case we have to bounce it anyways, so a bogus DMA zone isn't going
to make a difference there. Likewise, in the > 32-bits physical case, we
also just don't care.

> +	ret = (void *)__get_free_pages(gfp, order);
> +
> +	if (ret != NULL) {
> +		memset(ret, 0, size);
> +		*dma_handle = virt_to_phys(ret);
>  	}
> +	return ret;
> +}
> +EXPORT_SYMBOL(dma_alloc_coherent);
>  
I do wonder whether it's sane to forego the dma_cache_sync() in the
allocation path in this case. If the allocation is satisfied by the
bitmap, it can probably be skipped, but as far as data we're fetching and
remapping from the page allocator, I suspect this is still going to need
a sync.

> +	mem_base = ioremap(bus_addr, size);
> +	if (!mem_base)
> +		goto out;
> +

This should be ioremap_nocache().

> +	dev->dma_mem = kzalloc(sizeof(struct dma_coherent_mem), GFP_KERNEL);
> +	if (!dev->dma_mem)
> +		goto out;

This can probably be kmalloc(), since everything is being initialized
anyways, no point in zeroing it out.

> +void dma_release_declared_memory(struct device *dev)
> +{
> +	struct dma_coherent_mem *mem = dev->dma_mem;
>  
> -	free_pages(addr, get_order(size));
> +	if (!mem)
> +		return;
> +	dev->dma_mem = NULL;
> +	iounmap(mem->virt_base);
> +	kfree(mem->bitmap);
> +	kfree(mem);
> +}
What happens if someone is still using the bitmap?
