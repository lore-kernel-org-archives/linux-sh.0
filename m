From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Sun, 15 Apr 2012 21:58:50 +0000
Subject: Re: [PATCH 0/7 v2] ARM: mach-shmobile: add Armadillo800eva board support
Message-Id: <201204160001.41157.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thursday, April 12, 2012, Simon Horman wrote:
> On Fri, Apr 06, 2012 at 01:26:54AM -0700, kuninori.morimoto.gx@renesas.com wrote:
> > 
> > Hi Rafael, Magnus
> > Cc Simon, nakai-san, Saneyoshi-san
> > 
> > These are v2 of basic R8A7740 A1 Armadillo800eva baord support patch set.
> > These are based on linus/master branch.
> > 
> > Kuninori Morimoto (7):
> >       ARM: mach-shmobile: pfc-r8a7740: add gpio_irq support
> >       ARM: mach-shmobile: add armadillo800eva board support.
> >       ARM: mach-shmobile: armadillo800eva: add defconfig
> >       ARM: mach-shmobile: armadillo800eva: add support LCDC0
> >       ARM: mach-shmobile: armadillo800eva: add support ST1232
> >       ARM: mach-shmobile: armadillo800eva: add support gpio_key
> >       ARM: mach-shmobile: armadillo800eva: add support sh_eth
> 
> I have tested all of the patches above, except
> "ARM: mach-shmobile: armadillo800eva: add support ST1232",
> against 3.4-rc2. For those six patches:
> 
> 	Tested-by: Simon Horman <horms@verge.net.au>

Patches [2-4/7] and [6-7/7] applied to the armadillo800eva branch of the
renesas.git tree.  Please let me know what the status of patch [5/7] is.

Thanks,
Rafael
