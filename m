From: Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Thu, 02 Aug 2018 14:03:42 +0000
Subject: Re: [PATCH v2] sh: Update kmem_cache_flag.
Message-Id: <8736vwsw5d.wl-ysato@users.sourceforge.jp>
List-Id: <linux-sh.vger.kernel.org>
References: <20180802122136.127494-1-ysato@users.sourceforge.jp>
In-Reply-To: <20180802122136.127494-1-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, 02 Aug 2018 21:50:00 +0900,
Geert Uytterhoeven wrote:
> 
> Hi Sato-san,
> 
> On Thu, Aug 2, 2018 at 2:22 PM Yoshinori Sato
> <ysato@users.sourceforge.jp> wrote:
> > __GFP_ZERO and the constructor are exclusive relationships,
> > so it is incorrect to specify them at the same time.
> 
> Thanks for your patch!
> 
> > --- a/arch/sh/mm/pgtable.c
> > +++ b/arch/sh/mm/pgtable.c
> > @@ -2,8 +2,6 @@
> >  #include <linux/mm.h>
> >  #include <linux/slab.h>
> >
> > -#define PGALLOC_GFP GFP_KERNEL | __GFP_ZERO
> > -
> >  static struct kmem_cache *pgd_cachep;
> >  #if PAGETABLE_LEVELS > 2
> >  static struct kmem_cache *pmd_cachep;
> > @@ -32,7 +30,9 @@ void pgtable_cache_init(void)
> >
> >  pgd_t *pgd_alloc(struct mm_struct *mm)
> >  {
> > -       return kmem_cache_alloc(pgd_cachep, PGALLOC_GFP);
> > +       pgd_t *pgd = kmem_cache_alloc(pgd_cachep, GFP_KERNEL);
> > +       memset(pgd, 0, kmem_cache_size(pgd_cachep));
> 
> Are you sure the above line is needed?
> As kmem_cache_size(pgd_cachep) = 4096, this clears the whole pgd again,
> undoing the constructor's work.

If there is no such line, panic with page fault.
I have not identified the cause, but there seems
to be a part that expects 0 somewhere.

> > +       return pgd;
> >  }
> >
> >  void pgd_free(struct mm_struct *mm, pgd_t *pgd)
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Yosinori Sato
