From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 30 Jul 2013 07:01:02 +0000
Subject: Re: [PATCH 4/6 v2] ARM: shmobile: r8a7778: cleanup registration of i2c
Message-Id: <87d2q0edlh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <871u6ldb9z.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871u6ldb9z.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > > > I notice that you are now registering i2c devices in
> > > > r8a7778_add_dt_devices(). Which I believe means that they
> > > > will be registered in C when bockw-reference is used.
> > > > Is that intentional?
> > > 
> > > Oops, it is my mistake.
> > > I2C should not be called from C when bockw-reference.
> > > Can I send v2 patch ?
> > 
> > Please do.
> > 
> > Could you also re-post 5/6 at the same time?
> > No changes are required.
> 
> OK, will do

These are v3 of above
based on renesas-devel-20130730

Kuninori Morimoto (2):
      ARM: shmobile: r8a7778: i2c should not be called from C in DT
      ARM: shmobile: r8a7778: cleanup registration of hspi

 arch/arm/mach-shmobile/board-bockw.c          |    1 -
 arch/arm/mach-shmobile/include/mach/r8a7778.h |    1 -
 arch/arm/mach-shmobile/setup-r8a7778.c        |   13 ++++++++-----
 3 files changed, 8 insertions(+), 7 deletions(-)
