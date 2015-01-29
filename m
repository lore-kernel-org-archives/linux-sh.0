From: Simon Horman <horms@verge.net.au>
Date: Thu, 29 Jan 2015 02:09:54 +0000
Subject: Re: [PATCH 0/4 v3] ARM: shmobile: r8a779x: add SDHI DMA support
Message-Id: <20150129020952.GA3345@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87ppa7lanl.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ppa7lanl.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jan 29, 2015 at 01:45:03AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > > These are v3 of SDHI DMA support for r8a7790/r8a7791.
> > > > These are based on Ulf's
> > > > git.linaro.org/people/ulf.hansson/mmc.git tmio
> > > > 
> > > > Kuninori Morimoto (2):
> > > >       ARM: shmobile: r8a7790: tidyup SDHI register size on DTSI
> > > >       ARM: shmobile: r8a7791: tidyup SDHI register size on DTSI
> > > > 
> > > > Laurent Pinchart (2):
> > > >       ARM: shmobile: r8a7790: Reference DMA channels in SDHI DT nodes
> > > >       ARM: shmobile: r8a7791: Reference DMA channels in SDHI DT nodes
> > > > 
> > > >  arch/arm/boot/dts/r8a7790.dtsi |   12 ++++++++++--
> > > >  arch/arm/boot/dts/r8a7791.dtsi |    8 +++++++-
> > > >  2 files changed, 17 insertions(+), 3 deletions(-)
> > > 
> > > For the whole series,
> > > 
> > > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > 
> > Thanks,
> > 
> > I have queued up this series with your ack added to the two
> > patches that were not already signed off by you.
> 
> Please take care about these patches.
> As I mentioned above, it needs Ulf's tmio branch

Oops, I forgot about that.

As I am targeting these changes at v3.21 perhaps it would
be best if I dropped them and you reposted them once the dependencies
have hit an rc release.
