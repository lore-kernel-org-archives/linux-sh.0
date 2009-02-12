From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Date: Thu, 12 Feb 2009 16:53:32 +0000
Subject: Re: [PATCH] slab: fix slab flags for archs use alignment larger 64-bit
Message-Id: <49946204.70601@st.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

sorry... patch also sent to linux-kernel@vger.kernel.org

Giuseppe CAVALLARO wrote:
> I think, this fix is necessary for all the architectures want to
> perform DMA into kmalloc caches and need a guaranteed alignment
> larger than the alignment of a 64-bit integer.
> An example is sh architecture where ARCH_KMALLOC_MINALIGN is L1_CACHE_BYTES.
>
> As side effect, these kind of objects cannot be visible
> within the /proc/slab_allocators file.
>
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> ---
>  mm/slab.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/mm/slab.c b/mm/slab.c
> index ddc41f3..031d785 100644
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -2262,7 +2262,7 @@ kmem_cache_create (const char *name, size_t size, size_t align,
>  		ralign = align;
>  	}
>  	/* disable debug if necessary */
> -	if (ralign > __alignof__(unsigned long long))
> +	if (ralign > ARCH_KMALLOC_MINALIGN)
>  		flags &= ~(SLAB_RED_ZONE | SLAB_STORE_USER);
>  	/*
>  	 * 4) Store it.
>   

