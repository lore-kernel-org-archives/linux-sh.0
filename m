From: Gonsolo <gonsolo@gmail.com>
Date: Mon, 16 Dec 2019 13:21:05 +0000
Subject: Re: [PATCH 1/1] Fix undefined reference to 'node_reclaim_distance'.
Message-Id: <CANL0fFS81NgFBcMBdWo6OKefz04h_FeXadcau9Rkcna7Ap5PDw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20191216103522.32215-1-gonsolo@gmail.com> <20191216103522.32215-2-gonsolo@gmail.com>
 <CAMuHMdVotJuotVKa3rxgR3ujCedoWM19-HhwhbTC9g6gV_EVNw@mail.gmail.com>
In-Reply-To: <CAMuHMdVotJuotVKa3rxgR3ujCedoWM19-HhwhbTC9g6gV_EVNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi!

> Unfortunately that may be an x86-centric assumption: on other platforms,
> there do exist systems with multiple memory banks with different access
> performance figures.

Does that mean that the line

obj-$(CONFIG_SMP) += cpupri.o cpudeadline.o topology.o stop_task.o pelt.o

in kernel/sched/topology/Makefile:23 is wrong?

Because in topology.c:1284 the variable node_reclaim_distance ist defined
which is used in mm/page_alloc.c:3529 without depending on SMP.

-- 
g
