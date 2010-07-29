From: Matt Fleming <matt@console-pimps.org>
Date: Thu, 29 Jul 2010 19:52:20 +0000
Subject: RE: [PATCH] sh: Remove memset from coherent memory allocator (for  comments)
Message-Id: <87sk32xdzf.fsf@linux-g6p1.site>
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTi=0=kR49SHE8mistKJ0hPpjwUk=xXSMw=K_i9Ne@mail.gmail.com>
In-Reply-To: <AANLkTi=0=kR49SHE8mistKJ0hPpjwUk=xXSMw=K_i9Ne@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, 29 Jul 2010 15:03:20 +0100, Andrew Murray <amurray@mpcdata.com> wrote:
> 
> I share your concern (and also make the broken caller argument). New
> patch...
> 
> From: Andrew Murray <amurray@mpc-data.co.uk>
> 
> This patch reduces the time taken to allocate coherent dma memory.
> 
> Signed-off-by: Andrew Murray <amurray@mpc-data.co.uk>
> ---
> --- linux-2.6-old/arch/sh/mm/consistent.c	2010-07-25
> 05:01:33.813493496 +0100
> +++ linux-2.6/arch/sh/mm/consistent.c	2010-07-25 08:11:28.969943650
> +0100
> @@ -38,11 +38,11 @@ void *dma_generic_alloc_coherent(struct
>  	void *ret, *ret_nocache;
>  	int order = get_order(size);
> 
> +	gfp |= __GFP_ZERO;
>  	ret = (void *)__get_free_pages(gfp, order);
>  	if (!ret)
>  		return NULL;
> 
> -	memset(ret, 0, size);
>  	/*
>  	 * Pages from the page allocator may have data present in
>  	 * cache. So flush the cache before using uncached memory.
> --

Reviewed-by: Matt Fleming <matt@console-pimps.org>
