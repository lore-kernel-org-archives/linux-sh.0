From: Matthew Wilcox <willy@infradead.org>
Date: Thu, 12 Jul 2018 20:52:37 +0000
Subject: Re: Random warning dump during init.
Message-Id: <20180712205237.GA21078@bombadil.infradead.org>
List-Id: <linux-sh.vger.kernel.org>
References: <b4645807-bc6f-9578-20c2-798654c593a2@landley.net>
In-Reply-To: <b4645807-bc6f-9578-20c2-798654c593a2@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 12, 2018 at 09:59:42PM +0200, Geert Uytterhoeven wrote:
> CC willy
> 
> On Thu, Jul 12, 2018 at 4:55 PM Rob Landley <rob@landley.net> wrote:
> > On 07/11/2018 01:17 PM, Rob Landley wrote:
> > > Building commit d0fbad0aec1d (from July 2) I hit this, and I confirmed today's
> > > pull is still doing it. (It's my mkroot sh4 target built with musl-cross-make,
> > > booting under qemu.)
> > >
> > > NET: Registered protocol family 17
> > > Freeing unused kernel memory: 116K
> > > This architecture does not have kernel memory protection.
> > > WARNING: CPU: 0 PID: 1 at mm/slub.c:2412 ___slab_alloc.constprop.34+0x196/0x288
> > >
> > > CPU: 0 PID: 1 Comm: swapper Not tainted 4.18.0-rc3 #1
> > > PC is at ___slab_alloc.constprop.34+0x196/0x288
> > > PR is at __slab_alloc.constprop.33+0x2a/0x4c
> > > PC  : 8c09ada2 SP  : 8f829ea8 SR  : 400080f0
> > > TEA : c0001240
> > > R0  : 8c09ac0c R1  : 8c01cc54 R2  : 8ff750d0 R3  : 00000000
> > > R4  : 8f802780 R5  : 006080c0 R6  : 8c01d79c R7  : 8ff750d0
> > > R8  : 8c011bd8 R9  : 8ff750d0 R10 : 8f802780 R11 : 00008000
> > > R12 : 8c01d79c R13 : 006080c0 R14 : 8f8027fc
> > > MACH: 00000205 MACL: 0ae4849d GBR : 00000000 PR  : 8c09aebe
> > >
> > > Call trace:
> > >  [<(ptrval)>] arch_local_irq_restore+0x0/0x24
> > >  [<(ptrval)>] __slab_alloc.constprop.33+0x2a/0x4c
> > >  [<(ptrval)>] arch_local_save_flags+0x0/0x8
> > >  [<(ptrval)>] arch_local_irq_restore+0x0/0x24
> > >  [<(ptrval)>] mm_init.isra.6+0xb4/0x104
> > >  [<(ptrval)>] kmem_cache_alloc+0x9c/0xf4
> > >  [<(ptrval)>] arch_local_irq_restore+0x0/0x24
> > >  [<(ptrval)>] mm_init.isra.6+0xb4/0x104
> > >  [<(ptrval)>] mm_init.isra.6+0xb4/0x104
> > >  [<(ptrval)>] __do_execve_file+0x1da/0x5bc
> > >  [<(ptrval)>] kmem_cache_alloc+0x0/0xf4
> > >  [<(ptrval)>] getname_kernel+0x1e/0xc8
> > >  [<(ptrval)>] do_execve+0x16/0x24
> > >  [<(ptrval)>] arch_local_save_flags+0x0/0x8
> > >  [<(ptrval)>] arch_local_irq_restore+0x0/0x24
> > >  [<(ptrval)>] printk+0x0/0x24
> > >  [<(ptrval)>] kernel_init+0x34/0xec
> > >  [<(ptrval)>] ret_from_kernel_thread+0xc/0x14
> > >  [<(ptrval)>] schedule_tail+0x0/0x54
> > >  [<(ptrval)>] kernel_init+0x0/0xec

The stack dump is a bit garbled, but it looks to me like kmem_cache_alloc()
is being called from getname_kernel().  The problem is, neither of the
conditions which must both be satisfied to generate the warning is true.

getname_kernel calls __getname which is:
include/linux/fs.h:#define __getname()          kmem_cache_alloc(names_cachep, GFP_KERNEL)
which doesn't have GFP_ZERO set.  And names_cachep is created as:

        names_cachep = kmem_cache_create_usercopy("names_cache", PATH_MAX, 0,
                        SLAB_HWCACHE_ALIGN|SLAB_PANIC, 0, PATH_MAX, NULL);

which doesn't have a constructor.

So how you're getting this warning, I have no idea!

> > > ---[ end trace 547fc2facfcadcaf ]---
> > > 8139cp 0000:00:02.0 eth0: link up, 100Mbps, full-duplex, lpa 0x05E1
> > > Type exit when done.
> > > / #
> >
> > I bisected it to:
> >
> > commit 128227e7fe4087b60f1bd31f762e61237eb23790
> > Author: Matthew Wilcox <mawilcox@microsoft.com>
> > Date:   Thu Jun 7 17:05:13 2018 -0700
> >
> >     slab: __GFP_ZERO is incompatible with a constructor
> >
> >     __GFP_ZERO requests that the object be initialised to all-zeroes, while
> >     the purpose of a constructor is to initialise an object to a particular
> >     pattern.  We cannot do both.  Add a warning to catch any users who
> >     mistakenly pass a __GFP_ZERO flag when allocating a slab with a
> >     constructor.
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
