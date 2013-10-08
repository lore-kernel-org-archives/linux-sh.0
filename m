From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 08 Oct 2013 02:57:06 +0000
Subject: Re: [PATCH 0/7] ARM: shmobile: bockw: MMCIF support on DT
Message-Id: <87eh7wxyf4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878uy9259u.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878uy9259u.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Simon

> > > > > Kuninori Morimoto (7):
> > > > >       1) ARM: shmobile: bockw: enable CONFIG_REGULATOR
> > > > >       2) ARM: shmobile: bockw: use regulator for MMCIF
> > > > >       3) ARM: shmobile: bockw: add default PFC settings on DTS
> > > > >       4) ARM: shmobile: bockw: remove manual PFC settings on reference
> > > > >       5) ARM: shmobile: r8a7778: add MMCIF clock support for DT
> > > > >       6) ARM: shmobile: r8a7778: add MMCIF support on DTSI
> > > > >       7) ARM: shmobile: bockw: add MMCIF support on DTS
(snip)
> > "ARM: shmobile: r8a7778: Fix pin control device address in DT" 
> > is bugfix patch for DT.
> > The kernel (especially, pfc settings = #3) doesn't work
> > without it.
> > Is this explain enough for you ?
> 
> Assuming that "ARM: shmobile: r8a7778: Fix pin control device address in
> DT" is not applied. When the pfc settings don't work does the kernel still
> work as well as it did prior to patch #3 not being applied?

#1, #2 will works well without fixup patch.
#3 need it, and
#4-#7 need #3 patch.
