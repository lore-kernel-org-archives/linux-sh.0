From: Mike Rapoport <rppt@kernel.org>
Date: Tue, 17 Dec 2019 18:32:14 +0000
Subject: Re: [PATCH 2/2] sh: add support for folded p4d page tables
Message-Id: <20191217183213.GA29446@rapoport-lnx>
List-Id: <linux-sh.vger.kernel.org>
References: <20191217142150.10392-1-rppt@kernel.org>
 <20191217142150.10392-3-rppt@kernel.org>
 <CAMuHMdXYp7EBK446EsDt_HLDvc96TPP9oPZmsLtFL5VvhSejjw@mail.gmail.com>
In-Reply-To: <CAMuHMdXYp7EBK446EsDt_HLDvc96TPP9oPZmsLtFL5VvhSejjw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux MM <linux-mm@kvack.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mike Rapoport <rppt@linux.ibm.com>

On Tue, Dec 17, 2019 at 06:59:43PM +0100, Geert Uytterhoeven wrote:
> Hi Mike,
> 
> On Tue, Dec 17, 2019 at 3:23 PM Mike Rapoport <rppt@kernel.org> wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > Implement primitives necessary for the 4th level folding, add walks of p4d
> > level where appropriate and remove usage of __ARCH_USE_5LEVEL_HACK.
> >
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> Thanks for your patch!
> 
> > --- a/arch/sh/mm/fault.c
> > +++ b/arch/sh/mm/fault.c
> > @@ -65,7 +66,20 @@ static void show_pte(struct mm_struct *mm, unsigned long addr)
> >                         break;
> >                 }
> >
> > -               pud = pud_offset(pgd, addr);
> > +               p4d = p4d_offset(pgd, addr);
> > +               if (PTRS_PER_P4D != 1)
> > +                       printk(", *p4d=%0*Lx", (u32)(sizeof(*p4d) * 2),
> > +                              (u64)p4d_val(*p4d));
> 
> This (and the prints below) is gonna cause lots of broken output lines.
> You should use pr_cont() instead, and probably rebase on top of  my
> "[PATCH 7/7] sh: fault: Modernize printing of kernel messages"
> (https://lore.kernel.org/lkml/20191203162645.19950-8-geert+renesas@glider.be/).

Ok, will fix.	 

> > +
> > +               if (p4d_none(*p4d))
> > +                       break;
> > +
> > +               if (p4d_bad(*p4d)) {
> > +                       printk("(bad)");
> > +                       break;
> > +               }
> > +
> > +               pud = pud_offset(p4d, addr);
> >                 if (PTRS_PER_PUD != 1)
> >                         printk(", *pud=%0*Lx", (u32)(sizeof(*pud) * 2),
> >                                (u64)pud_val(*pud));
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
Sincerely yours,
Mike.
