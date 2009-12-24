From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 24 Dec 2009 05:28:01 +0000
Subject: Re: Probably cache synchronization issue on SH7723
Message-Id: <20091224052800.GB28878@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4B17B0D6.6020105@emtrion.de>
In-Reply-To: <4B17B0D6.6020105@emtrion.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 23, 2009 at 11:33:08PM +0000, Matt Fleming wrote:
> On Wed, Dec 23, 2009 at 09:38:10AM +0100, Pietrek, Markus wrote:
> > Hi Matt,
> > 
> > update_mmu_cache() is called with vma = NULL in
> > arch/sh/mm/fault_32.c. If we then assume exec=1, the patch works
> > fine.
> > 
> > diff --git a/arch/sh/mm/cache.c b/arch/sh/mm/cache.c
> > index e9415d3..054bb8a 100644
> > --- a/arch/sh/mm/cache.c
> > +++ b/arch/sh/mm/cache.c
> > @@ -126,8 +126,10 @@ void __update_cache(struct vm_area_struct *vma,
> >  {
> >         struct page *page;
> >         unsigned long pfn = pte_pfn(pte);
> > +       /* flush any dirty data page before using it as a code page */
> > +       int exec = (vma != NULL) ? (vma->vm_flags & VM_EXEC) : 1;
> > 
> 
> I'm assuming that if you set exec to 0 when vma = NULL then you still
> see the cache issues? In which case, this patch probably works because
> it's aggressively flushing the cache and unfortunately will be papering
> over the real bug.
> 
> What sort of workload do you have that triggers this bug? Did you say it
> was a graphics app? Is the app available anywhere? If I could reproduce
> it on my board it would make it easier for me to diagnose the bug.
> 
> If we can't find the cause of this bug soon I imagine that Paul will
> queue up some band-aid patch so that, whilst there will be a performance
> loss, at least things will work correctly ;-)

Well, the aliasing test was added as an optimization, but dropping it and
doing the flush on any PG_dcache_dirty hit is fine too. The exec case is
a bit misleading as the purge in question only touches the D-cache lines,
whilst the VM_EXEC case needs I-cache tidying. This is further
complicated by the fact that I-cache tidying may be required regardless
of whether there is a page mapping or not. However, that's a largely
secondary issue. If the crashes observed go away with more aggressive
D-cache flushing, then it's not likely to be exec related given that the
I-cache remains unaltered.

So, I'm inclined to just apply Markus's original patch that drops the
pages_do_alias() test and restores the old behaviour of just aggressively
flushing in the PG_dcache_dirty case. If there's a reproduceable testcase
for circumventing the aliasing test then obviously that's worth looking
in to for future optimizations.
