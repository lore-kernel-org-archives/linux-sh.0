From: Simon Horman <horms@verge.net.au>
Date: Fri, 12 Apr 2013 06:58:04 +0000
Subject: Re: [PATCH 0/6 v2] ARM: shmobile: r8a73a4: detailed clock topology support
Message-Id: <20130412065803.GB27274@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87r4ipk3rp.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87r4ipk3rp.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 11, 2013 at 10:10:02PM -0700, Kuninori Morimoto wrote:
> 
> Hi Magnus
> 
> > > Hi Simon, Magnus
> > > 
> > > These patches are v2 of r8a73a4 clock topology support.
> > > 
> > > These are tested on APE6EVM board,
> > > and based on renesas-next-20130404v2 tags
> > > 
> > > Kuninori Morimoto (5):
> > >       ARM: shmobile: r8a73a4: add main clock
> > >       ARM: shmobile: r8a73a4: add pll clocks
> > >       ARM: shmobile: r8a73a4: add div4 clocks
> > >       ARM: shmobile: r8a73a4: add div6 clocks
> > >       ARM: shmobile: ape6evm: MP clock parent become EXTAL2
> > > 
> > >  arch/arm/mach-shmobile/board-ape6evm.c |   15 ++
> > >  arch/arm/mach-shmobile/clock-r8a73a4.c |  375 ++++++++++++++++++++++++++++++--
> > 
> > Magnus, could you review these patches?
> 
> ping ?

pong

I have spoken with Magnus and queued-up the patches for v3.11.

The first 4 patches are in the soc-r8a77a3 branch.

I have merged that branch into the boards-ape6evm branch
and queued-up the last patch of the series there.
