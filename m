From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 16 Dec 2019 13:31:15 +0000
Subject: Re: [PATCH 1/1] Fix undefined reference to 'node_reclaim_distance'.
Message-Id: <CAMuHMdVtm6BGx6d+F8-Bw+fD-M-DugspLkBvCtTKGgWiPvJnSA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20191216103522.32215-1-gonsolo@gmail.com> <20191216103522.32215-2-gonsolo@gmail.com>
 <CAMuHMdVotJuotVKa3rxgR3ujCedoWM19-HhwhbTC9g6gV_EVNw@mail.gmail.com> <CANL0fFS81NgFBcMBdWo6OKefz04h_FeXadcau9Rkcna7Ap5PDw@mail.gmail.com>
In-Reply-To: <CANL0fFS81NgFBcMBdWo6OKefz04h_FeXadcau9Rkcna7Ap5PDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gonsolo <gonsolo@gmail.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matt Fleming <matt@codeblueprint.co.uk>, Randy Dunlap <rdunlap@infradead.org>

Hi Gon,

On Mon, Dec 16, 2019 at 2:21 PM Gonsolo <gonsolo@gmail.com> wrote:
> > Unfortunately that may be an x86-centric assumption: on other platforms,
> > there do exist systems with multiple memory banks with different access
> > performance figures.
>
> Does that mean that the line
>
> obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o
>
> in kernel/sched/topology/Makefile:23 is wrong?
>
> Because in topology.c:1284 the variable node_reclaim_distance ist defined
> which is used in mm/page_alloc.c:3529 without depending on SMP.

The offending commit seems to be a55c7454a8c887b2 ("sched/topology:
Improve load balancing on AMD EPYC systems").

Probably the node_reclaim_distance variable should be moved from
an SMP-specific file to a NUMA-specific file.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
