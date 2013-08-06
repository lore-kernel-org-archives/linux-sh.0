From: Simon Horman <horms@verge.net.au>
Date: Tue, 06 Aug 2013 02:39:15 +0000
Subject: Re: [PATCH 0/2] ARM: shmobile: Use DT for GIC
Message-Id: <20130806023913.GD20940@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87iozo8umw.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87iozo8umw.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 01, 2013 at 11:42:36PM -0700, Kuninori Morimoto wrote:
> 
> Hi
> 
> The Subject was wrong
> 
> - [PATCH 0/2] ARM: shmobile: Use DT for GIC
> + [PATCH 0/4] ARM: shmobile: Use DT for GIC
> 
> And, I didn't indicate base branch.
> These are based on renesas-devel-20130801v2 tag
> 
> > Kuninori Morimoto (4):
> >       1) ARM: shmobile: armadillo800eva: Use DT for GIC
> >       2) ARM: shmobile: marzen: Use DT for GIC
> >       3) ARM: shmobile: r8a7740: move r8a7740_init_irq_of() to setup
> >       4) ARM: shmobile: r8a7779: move r8a7779_init_irq_xxx() to setup

Thanks, I have queued these up for v3.12 with Magnus's Ack.

I have queued-up the first two patches in the dt2 branch.
And the second two patches in the cleanup3 branch.
