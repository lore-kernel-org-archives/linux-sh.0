From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 25 Jan 2016 00:16:32 +0000
Subject: Re: [PATCH] dmaengine: rcar-dmac: Rename highmem/lowmem
Message-Id: <2772453.vPYGuGQGPC@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <20160114095933.13778.32364.sendpatchset@little-apple>
In-Reply-To: <20160114095933.13778.32364.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, laurent.pinchart+renesas@ideasonboard.com, geert+renesas@glider.be, linux-sh@vger.kernel.org, vinod.koul@intel.com, dmaengine@vger.kernel.org, horms+renesas@verge.net.au

Hi Magnus,

Thank you for the patch.

On Thursday 14 January 2016 18:59:33 Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Update the rcar-dmac driver to rework comments and variable names
> related to lowmem and highmem.
> 
> Terminology such as highmem and lowmem are commonly used for Linux
> kernel memory managment. Highmem in particular is about handling more
> physical memory than can fit into the kernel virtual address space.
> 
> Highmem and lowmem are related to but not equivalent to the 40-bit
> address limitation that is the real issue the rcar-dmac driver has to
> deal with. For instance, with 1 GiB of RAM highmem is usually needed
> on a 32-bit architecture, but a 32-bit address is still enough.
> 
> 64-bit architectures tend to not use highmem since the virtual
> address space is more than enough for loads of lowmem. 32-bit
> architectures may still need highmem to access all memory.
> 
> The rcar-dmac driver and the DMA device needs to handle the 40-bit
> limitation on both 64-bit and 32-bit architectures.
> 
> This patch renames the highmem variable to fourty_bit_required to
> avoid confusion. And the comment gets updated as well.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> ---
> 
>  drivers/dma/sh/rcar-dmac.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> --- 0001/drivers/dma/sh/rcar-dmac.c
> +++ work/drivers/dma/sh/rcar-dmac.c	2016-01-14 18:35:23.780513000 +0900
> @@ -889,7 +889,7 @@ rcar_dmac_chan_prep_sg(struct rcar_dmac_
>  	unsigned int nchunks = 0;
>  	unsigned int max_chunk_size;
>  	unsigned int full_size = 0;
> -	bool highmem = false;
> +	bool fourty_bit_required = false;

s/fourty_bit_required/fourty_bits_required/ ? Or, as the variable name seems a 
bit long, need_40bits ?

>  	unsigned int i;
> 
>  	desc = rcar_dmac_desc_get(chan);
> @@ -935,7 +935,7 @@ rcar_dmac_chan_prep_sg(struct rcar_dmac_
>  			 * hardware descriptor lists.
>  			 */
>  			if (dev_addr >> 32 || mem_addr >> 32)
> -				highmem = true;
> +				fourty_bit_required = true;
>  #endif
> 
>  			chunk = rcar_dmac_xfer_chunk_get(chan);
> @@ -977,13 +977,13 @@ rcar_dmac_chan_prep_sg(struct rcar_dmac_
>  	 * Use hardware descriptor lists if possible when more than one chunk
>  	 * needs to be transferred (otherwise they don't make much sense).
>  	 *
> -	 * The highmem check currently covers the whole transfer. As an
> -	 * optimization we could use descriptor lists for consecutive lowmem
> -	 * chunks and direct manual mode for highmem chunks. Whether the
> +	 * The 40-bit address check currently covers the whole transfer. As an
> +	 * optimization we could use descriptor lists for consecutive 32-bit
> +	 * chunks and direct manual mode for 40-bit chunks. Whether the
>  	 * performance improvement would be significant enough compared to the
>  	 * additional complexity remains to be investigated.
>  	 */
> -	desc->hwdescs.use = !highmem && nchunks > 1;
> +	desc->hwdescs.use = !fourty_bit_required && nchunks > 1;
>  	if (desc->hwdescs.use) {
>  		if (rcar_dmac_fill_hwdesc(chan, desc) < 0)
>  			desc->hwdescs.use = false;

-- 
Regards,

Laurent Pinchart

