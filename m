From: Matt Fleming <matt@console-pimps.org>
Date: Wed, 23 Dec 2009 23:33:08 +0000
Subject: Re: Probably cache synchronization issue on SH7723
Message-Id: <20091223233308.GA12843@console-pimps.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4B17B0D6.6020105@emtrion.de>
In-Reply-To: <4B17B0D6.6020105@emtrion.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 23, 2009 at 09:38:10AM +0100, Pietrek, Markus wrote:
> Hi Matt,
> 
> update_mmu_cache() is called with vma = NULL in
> arch/sh/mm/fault_32.c. If we then assume exec=1, the patch works
> fine.
> 
> diff --git a/arch/sh/mm/cache.c b/arch/sh/mm/cache.c
> index e9415d3..054bb8a 100644
> --- a/arch/sh/mm/cache.c
> +++ b/arch/sh/mm/cache.c
> @@ -126,8 +126,10 @@ void __update_cache(struct vm_area_struct *vma,
>  {
>         struct page *page;
>         unsigned long pfn = pte_pfn(pte);
> +       /* flush any dirty data page before using it as a code page */
> +       int exec = (vma != NULL) ? (vma->vm_flags & VM_EXEC) : 1;
> 

I'm assuming that if you set exec to 0 when vma = NULL then you still
see the cache issues? In which case, this patch probably works because
it's aggressively flushing the cache and unfortunately will be papering
over the real bug.

What sort of workload do you have that triggers this bug? Did you say it
was a graphics app? Is the app available anywhere? If I could reproduce
it on my board it would make it easier for me to diagnose the bug.

If we can't find the cause of this bug soon I imagine that Paul will
queue up some band-aid patch so that, whilst there will be a performance
loss, at least things will work correctly ;-)
