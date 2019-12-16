From: Gonsolo <gonsolo@gmail.com>
Date: Mon, 16 Dec 2019 13:50:49 +0000
Subject: Re: [PATCH 1/1] Fix undefined reference to 'node_reclaim_distance'.
Message-Id: <CANL0fFSNdzM-e=u+w0BTUqg5sQP_DuVBuJe9m0JDQnVTOPDMNQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20191216103522.32215-1-gonsolo@gmail.com> <20191216103522.32215-2-gonsolo@gmail.com>
 <CAMuHMdVotJuotVKa3rxgR3ujCedoWM19-HhwhbTC9g6gV_EVNw@mail.gmail.com>
 <CANL0fFS81NgFBcMBdWo6OKefz04h_FeXadcau9Rkcna7Ap5PDw@mail.gmail.com> <CAMuHMdVtm6BGx6d+F8-Bw+fD-M-DugspLkBvCtTKGgWiPvJnSA@mail.gmail.com>
In-Reply-To: <CAMuHMdVtm6BGx6d+F8-Bw+fD-M-DugspLkBvCtTKGgWiPvJnSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matt Fleming <matt@codeblueprint.co.uk>, Randy Dunlap <rdunlap@infradead.org>

> The offending commit seems to be a55c7454a8c887b2 ("sched/topology:
> Improve load balancing on AMD EPYC systems").
>
> Probably the node_reclaim_distance variable should be moved from
> an SMP-specific file to a NUMA-specific file.

There are two variables that are used elsewhere:

int                             sched_max_numa_distance;

Used in kernel/sched/fair.c and kernel/sched/topology.c. I would move
it to fair.c.

int __read_mostly               node_reclaim_distance = RECLAIM_DISTANCE;

Used in
arch/x86/kernel/cpu/amd.c, line 894
kernel/sched/topology.c
mm/khugepaged.c, line 725
mm/page_alloc.c, line 3529

I'm not sure where to move this one.

-- 
g
