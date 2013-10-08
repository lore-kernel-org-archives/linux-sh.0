From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Oct 2013 01:32:38 +0000
Subject: Re: [PATCH 0/7] ARM: shmobile: bockw: MMCIF support on DT
Message-Id: <87fvscy2c6.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878uy9259u.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878uy9259u.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > > Kuninori Morimoto (7):
> > >       1) ARM: shmobile: bockw: enable CONFIG_REGULATOR
> > >       2) ARM: shmobile: bockw: use regulator for MMCIF
> > >       3) ARM: shmobile: bockw: add default PFC settings on DTS
> > >       4) ARM: shmobile: bockw: remove manual PFC settings on reference
> > >       5) ARM: shmobile: r8a7778: add MMCIF clock support for DT
> > >       6) ARM: shmobile: r8a7778: add MMCIF support on DTSI
> > >       7) ARM: shmobile: bockw: add MMCIF support on DTS
> > > 
> > >  arch/arm/boot/dts/r8a7778-bockw-reference.dts  |   25 ++++++++++++++++++++++++
> > >  arch/arm/boot/dts/r8a7778.dtsi                 |    8 ++++++++
> > >  arch/arm/configs/bockw_defconfig               |    1 +
> > >  arch/arm/mach-shmobile/board-bockw-reference.c |   12 ------------
> > >  arch/arm/mach-shmobile/board-bockw.c           |   13 ++++++++----
> > >  arch/arm/mach-shmobile/clock-r8a7778.c         |    1 +
> > >  6 files changed, 44 insertions(+), 16 deletions(-)
> > 
> > And, these dpends on today's Laurent's
> > 
> > Subject: [PATCH] ARM: shmobile: r8a7778: Fix pin control device address in DT
> > Date:	Thu,  3 Oct 2013 19:35:41 +0200
> 
> Thanks Morimoto-san.
> 
> Could you explain in a little more detail what the dependency is.
> I am trying to work out if I should apply this series on top
> of "ARM: shmobile: r8a7778: Fix pin control device address in DT"
> or if they can be merged in parallel.

"ARM: shmobile: r8a7778: Fix pin control device address in DT" 
is bugfix patch for DT.
The kernel (especially, pfc settings = #3) doesn't work
without it.
Is this explain enough for you ?


Best regards
---
Kuninori Morimoto
