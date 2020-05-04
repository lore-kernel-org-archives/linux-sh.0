From: Gonsolo <gonsolo@gmail.com>
Date: Mon, 04 May 2020 12:08:46 +0000
Subject: Re: [PATCH 1/1] Fix undefined reference to 'node_reclaim_distance'.
Message-Id: <CANL0fFQrO+kApsQd0N1+=_rPX_REBzpGf15J7Dmizb3WG1Xctw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20191216103522.32215-1-gonsolo@gmail.com> <20191216103522.32215-2-gonsolo@gmail.com>
 <CAMuHMdVotJuotVKa3rxgR3ujCedoWM19-HhwhbTC9g6gV_EVNw@mail.gmail.com>
 <CANL0fFS81NgFBcMBdWo6OKefz04h_FeXadcau9Rkcna7Ap5PDw@mail.gmail.com>
 <CAMuHMdVtm6BGx6d+F8-Bw+fD-M-DugspLkBvCtTKGgWiPvJnSA@mail.gmail.com>
 <CANL0fFSNdzM-e=u+w0BTUqg5sQP_DuVBuJe9m0JDQnVTOPDMNQ@mail.gmail.com>
 <20191223164220.GA14394@codeblueprint.co.uk> <29b721c1-b5a7-6fc1-4471-f42109d509ed@infradead.org>
 <CANL0fFTCVj7c-EQTs1kRuOn8e++vgFw1fUTJfya12csWkJdGqA@mail.gmail.com>
In-Reply-To: <CANL0fFTCVj7c-EQTs1kRuOn8e++vgFw1fUTJfya12csWkJdGqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>, Geert Uytterhoeven <geert@linux-m68k.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi!

> Yes, it fixes the arch/sh/ build errors in my testing.
> I don't have a failing ppc64 .config file to test.

As of v5.7-rc4 this patch doesn't seem to have been applied and the
build is still failing:
http://kisskb.ellerman.id.au/kisskb/buildresult/14067948/

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 6ec1e595b1d4..bf20e5883026 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1281,7 +1281,6 @@ static int                      sched_domains_curr_level;
int                          sched_max_numa_distance;
static int                   *sched_domains_numa_distance;
static struct cpumask                ***sched_domains_numa_masks;
-int __read_mostly            node_reclaim_distance = RECLAIM_DISTANCE;
#endif

/*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4785a8a2040e..733890d913ea 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3523,6 +3523,7 @@ bool zone_watermark_ok_safe(struct zone *z,
unsigned int order,
}

#ifdef CONFIG_NUMA
+int __read_mostly            node_reclaim_distance = RECLAIM_DISTANCE;
static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
{
    return node_distance(zone_to_nid(local_zone), zone_to_nid(zone)) <
-- 
g
