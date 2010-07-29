From: Andrew Murray <amurray@mpcdata.com>
Date: Thu, 29 Jul 2010 14:03:20 +0000
Subject: RE: [PATCH] sh: Remove memset from coherent memory allocator (for
Message-Id: <9864723e22237deb7ba6cd399e1612f4@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTi=0=kR49SHE8mistKJ0hPpjwUk=xXSMw=K_i9Ne@mail.gmail.com>
In-Reply-To: <AANLkTi=0=kR49SHE8mistKJ0hPpjwUk=xXSMw=K_i9Ne@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

> -----Original Message-----
> From: Matt Fleming [mailto:matt@console-pimps.org]
> Your mail client has word wrapped this patch. Check out
> Documentation/email-clients.txt to see if there are any tips for your
> client.
>
> This patch seems OK in principal but I think there's a safer way to get
> the results you want. With your patch, you've changed the semantics of
> dma_generic_alloc_coherent().  Previously it was guaranteed to return a
> chunk of zero'd memory, now you're relying on the caller passing
> __GFP_ZERO to indicate whether they want zero'd memory or not. Which
> means that if there's a bit of code that expects zero'd memory but
> doesn't pass __GFP_ZERO, it'll now be broken.
>
> (You could argue that this hypothetical caller of dma_alloc_coherent()
> is already broken if it doesn't pass __GFP_ZERO but my point is that it
> could be a lot of work to track down all the callers and figure out
> exactly what guarantees they expect).
>
> The safest approach is to follow what x86 does in its
> dma_generic_alloc_coherent() implementation; it adds the __GFP_ZERO
> flag
> unconditionally before allocating pages.

I share your concern (and also make the broken caller argument). New
patch...

From: Andrew Murray <amurray@mpc-data.co.uk>

This patch reduces the time taken to allocate coherent dma memory.

Signed-off-by: Andrew Murray <amurray@mpc-data.co.uk>
---
--- linux-2.6-old/arch/sh/mm/consistent.c	2010-07-25
05:01:33.813493496 +0100
+++ linux-2.6/arch/sh/mm/consistent.c	2010-07-25 08:11:28.969943650
+0100
@@ -38,11 +38,11 @@ void *dma_generic_alloc_coherent(struct
 	void *ret, *ret_nocache;
 	int order = get_order(size);

+	gfp |= __GFP_ZERO;
 	ret = (void *)__get_free_pages(gfp, order);
 	if (!ret)
 		return NULL;

-	memset(ret, 0, size);
 	/*
 	 * Pages from the page allocator may have data present in
 	 * cache. So flush the cache before using uncached memory.
--
