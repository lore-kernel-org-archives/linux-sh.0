From: Simon Horman <horms@verge.net.au>
Date: Thu, 18 Dec 2014 00:34:59 +0000
Subject: Re: [PATCH v2 00/05] ARM: shmobile: sh73a0 and kzm9g Multiplatform revisit
Message-Id: <20141218003458.GF1421@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20141217094204.7039.45337.sendpatchset@w520>
In-Reply-To: <20141217094204.7039.45337.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 18, 2014 at 09:24:29AM +0900, Simon Horman wrote:
> On Thu, Dec 18, 2014 at 09:22:33AM +0900, Simon Horman wrote:
> > On Wed, Dec 17, 2014 at 06:42:04PM +0900, Magnus Damm wrote:
> > > ARM: shmobile: sh73a0 and kzm9g Multiplatform revisit
> > > 
> > > [PATCH v2 01/05] ARM: shmobile: kzm9g-reference: 0x48008000 load address
> > > [PATCH v2 02/05] ARM: shmobile: sh73a0: Introduce generic setup callback
> > > [PATCH v2 03/05] ARM: shmobile: sh73a0: Add Multiplatform support
> > > [PATCH v2 04/05] ARM: shmobile: kzm9g: Sync with DT reference
> > > [PATCH v2 05/05] ARM: shmobile: kzm9g: Build DTS for Multiplatform
> > > 
> > > This patch series enables sh73a0 Multiplatform support. At this point
> > > the KZM9G board code written in C is left as-is, but future updates will
> > > make sure to get rid of DT reference DTS and C board code.
> > > 
> > > To make it work you need the sh73a0 CCF v7 series and the DIV6 v7
> > > series from Ulrich Hecht.
> > > 
> > > Patch 1-3 should be possible to merge without any special dependencies.
> > 
> > Thanks. I agree that should be possible.
> > 
> > I see there has been some discussion of at least patches 1 and 3.
> > I would like that discussion to come to a conclusion (has it already?)
> > before I merge any patches from this series. And ideally I would like
> > some Acks from Geert.
> 
> I have marked patches 4 and 5 as deferred. Please repost them when
> their dependencies are in place. And if that is during the v3.20 cycle
> please note what those dependencies were so I make sure the branches
> have dependencies arranges as necessary.

Many emails on the same topic...

Alternatively could we queue up the entire series, once discussion is
concluded, and leave removing the legacy code until the multiplatform is
working when its dependencies are merged. I think this is the approach we
have taken for ape6evm.

> > > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> > > ---
> > > 
> > >  Built on top of renesas-devel-20141217-v3.18
> > > 
> > >  arch/arm/boot/dts/Makefile            |    3 
> > >  arch/arm/boot/dts/sh73a0-kzm9g.dts    |  342 ++++++++++++++++++++++++++++++++-
> > >  arch/arm/mach-shmobile/Kconfig        |    5 
> > >  arch/arm/mach-shmobile/Makefile       |    4 
> > >  arch/arm/mach-shmobile/Makefile.boot  |    2 
> > >  arch/arm/mach-shmobile/setup-sh73a0.c |   21 +-
> > >  arch/arm/mach-shmobile/smp-sh73a0.c   |    2 
> > >  7 files changed, 369 insertions(+), 10 deletions(-)
> > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
