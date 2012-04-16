From: Simon Horman <horms@verge.net.au>
Date: Mon, 16 Apr 2012 07:55:31 +0000
Subject: Re: [PATCH 0/7 v2] ARM: mach-shmobile: add Armadillo800eva board support
Message-Id: <20120416075531.GA12478@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 16, 2012 at 09:04:19AM +0900, Simon Horman wrote:
> On Mon, Apr 16, 2012 at 12:01:40AM +0200, Rafael J. Wysocki wrote:
> > On Thursday, April 12, 2012, Simon Horman wrote:
> > > On Fri, Apr 06, 2012 at 01:26:54AM -0700, kuninori.morimoto.gx@renesas.com wrote:
> > > > 
> > > > Hi Rafael, Magnus
> > > > Cc Simon, nakai-san, Saneyoshi-san
> > > > 
> > > > These are v2 of basic R8A7740 A1 Armadillo800eva baord support patch set.
> > > > These are based on linus/master branch.
> > > > 
> > > > Kuninori Morimoto (7):
> > > >       ARM: mach-shmobile: pfc-r8a7740: add gpio_irq support
> > > >       ARM: mach-shmobile: add armadillo800eva board support.
> > > >       ARM: mach-shmobile: armadillo800eva: add defconfig
> > > >       ARM: mach-shmobile: armadillo800eva: add support LCDC0
> > > >       ARM: mach-shmobile: armadillo800eva: add support ST1232
> > > >       ARM: mach-shmobile: armadillo800eva: add support gpio_key
> > > >       ARM: mach-shmobile: armadillo800eva: add support sh_eth
> > > 
> > > I have tested all of the patches above, except
> > > "ARM: mach-shmobile: armadillo800eva: add support ST1232",
> > > against 3.4-rc2. For those six patches:
> > > 
> > > 	Tested-by: Simon Horman <horms@verge.net.au>
> > 
> > Patches [2-4/7] and [6-7/7] applied to the armadillo800eva branch of the
> > renesas.git tree.  Please let me know what the status of patch [5/7] is.
> 
> Hi Rafael,
> 
> I have not been able to successfully test 5/7 yet.
> I'll let you know when that changes.

Hi Rafael,

it seems that I may not be able to test 5/7 as it appears that
the touchscreen on my A1 board may be broken. Please consider
applying patch 5/7 anyway.

[5/7] Reviewed-by: Simon Horman <horms@verge.net.au>
