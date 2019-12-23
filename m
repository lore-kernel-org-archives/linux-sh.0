From: Matt Fleming <matt@codeblueprint.co.uk>
Date: Mon, 23 Dec 2019 16:42:20 +0000
Subject: Re: [PATCH 1/1] Fix undefined reference to 'node_reclaim_distance'.
Message-Id: <20191223164220.GA14394@codeblueprint.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <20191216103522.32215-1-gonsolo@gmail.com>
 <20191216103522.32215-2-gonsolo@gmail.com>
 <CAMuHMdVotJuotVKa3rxgR3ujCedoWM19-HhwhbTC9g6gV_EVNw@mail.gmail.com>
 <CANL0fFS81NgFBcMBdWo6OKefz04h_FeXadcau9Rkcna7Ap5PDw@mail.gmail.com>
 <CAMuHMdVtm6BGx6d+F8-Bw+fD-M-DugspLkBvCtTKGgWiPvJnSA@mail.gmail.com>
 <CANL0fFSNdzM-e=u+w0BTUqg5sQP_DuVBuJe9m0JDQnVTOPDMNQ@mail.gmail.com>
In-Reply-To: <CANL0fFSNdzM-e=u+w0BTUqg5sQP_DuVBuJe9m0JDQnVTOPDMNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Gonsolo <gonsolo@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>

On Mon, 16 Dec, at 02:50:49PM, Gonsolo wrote:
> > The offending commit seems to be a55c7454a8c887b2 ("sched/topology:
> > Improve load balancing on AMD EPYC systems").
> >
> > Probably the node_reclaim_distance variable should be moved from
> > an SMP-specific file to a NUMA-specific file.
> 
> There are two variables that are used elsewhere:
> 
> int                             sched_max_numa_distance;
> 
> Used in kernel/sched/fair.c and kernel/sched/topology.c. I would move
> it to fair.c.
> 
> int __read_mostly               node_reclaim_distance = RECLAIM_DISTANCE;
> 
> Used in
> arch/x86/kernel/cpu/amd.c, line 894
> kernel/sched/topology.c
> mm/khugepaged.c, line 725
> mm/page_alloc.c, line 3529
> 
> I'm not sure where to move this one.

Can someone test out this patch on one of the failing architectures?
(sh, ppc64)

---->8----

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6ec1e595b1d4..bf20e5883026 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1281,7 +1281,6 @@ static int			sched_domains_curr_level;
 int				sched_max_numa_distance;
 static int			*sched_domains_numa_distance;
 static struct cpumask		***sched_domains_numa_masks;
-int __read_mostly		node_reclaim_distance = RECLAIM_DISTANCE;
 #endif
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4785a8a2040e..733890d913ea 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3523,6 +3523,7 @@ bool zone_watermark_ok_safe(struct zone *z, unsigned int order,
 }
 
 #ifdef CONFIG_NUMA
+int __read_mostly		node_reclaim_distance = RECLAIM_DISTANCE;
 static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
 {
 	return node_distance(zone_to_nid(local_zone), zone_to_nid(zone)) <
