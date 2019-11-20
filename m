From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Nov 2019 08:30:18 +0000
Subject: Re: [PATCH] arch/sh/: fix NUMA build errors
Message-Id: <CAMuHMdUyN5FE21C3Bu6S4wrwTxe0xB2ZpPAgryvx_6EX+YkhFw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20d33517-6df0-9104-fc0a-7f621f87192e@infradead.org>
 <CAMuHMdU0Vx1E9V+h8XYTyAJitPT42NdGvgzLAfG-=1BVZd-rbA@mail.gmail.com> <802dc73e-080d-05aa-76fe-165bb4817959@infradead.org>
In-Reply-To: <802dc73e-080d-05aa-76fe-165bb4817959@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Randy,

On Wed, Nov 20, 2019 at 5:28 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 11/18/19 11:38 PM, Geert Uytterhoeven wrote:
> > On Tue, Nov 19, 2019 at 1:55 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >> Fix SUPERH builds that select SYS_SUPPORTS_NUMA but do not select
> >> SYS_SUPPORTS_SMP and SMP.
> >>
> >> kernel/sched/topology.c is only built for CONFIG_SMP and then the NUMA
> >> code + data inside topology.c is only built when CONFIG_NUMA is
> >> set/enabled, so these arch/sh/ configs need to select SMP and
> >> SYS_SUPPORTS_SMP to build the NUMA support.
> >>
> >> Fixes this build error in 3 different SUPERH configs:
> >>
> >> mm/page_alloc.o: In function `get_page_from_freelist':
> >> page_alloc.c:(.text+0x2ca8): undefined reference to `node_reclaim_distance'
> >>
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> >> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> >> Cc: Rich Felker <dalias@libc.org>
> >> Cc: linux-sh@vger.kernel.org
> >> ---
> >> or maybe these should be fixed in the defconfig files?
> >>
> >> or alternatively, does it make any sense to support NUMA without SMP?
> >
> > I think it does.  From arch/sh/mm/Kconfig config NUMA help:
> >
> >         Some SH systems have many various memories scattered around
> >         the address space, each with varying latencies. This enables
> >         support for these blocks by binding them to nodes and allowing
> >         memory policies to be used for prioritizing and controlling
> >         allocation behaviour.
>
> Note that this help text is under:
> config NUMA
>         bool "Non-Uniform Memory Access (NUMA) Support"
>         depends on MMU && SYS_SUPPORTS_NUMA
>         select ARCH_WANT_NUMA_VARIABLE_LOCALITY
>
> but ARCH_WANT_NUMA_VARIABLE_LOCALITY seems to be unimplemented anywhere in
> the kernel source tree.  I.e., the Kconfig symbol exists in init/Kconfig,
> but there is no code to support its use.

It does control (prevent) another option:

# For architectures that (ab)use NUMA to represent different memory regions
# all cpu-local but of different latencies, such as SuperH.
#
config ARCH_WANT_NUMA_VARIABLE_LOCALITY
        bool

config NUMA_BALANCING
        bool "Memory placement aware NUMA scheduler"
        depends on ARCH_SUPPORTS_NUMA_BALANCING
        depends on !ARCH_WANT_NUMA_VARIABLE_LOCALITY
        depends on SMP && NUMA && MIGRATION
        help
          This option adds support for automatic NUMA aware
memory/task placement.
          The mechanism is quite primitive and is based on migrating memory when
          it has references to the node the task is running on.

          This system will be inactive on UMA systems.

The symbol was set by arch/metag, too (which was removed).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
