From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 25 Apr 2012 21:13:35 +0000
Subject: Re: [PATCH 0/8] ARM: mach-shmobile: armadillo800eva: USB/SDHI/MMIF support patch set
Message-Id: <201204252313.35579.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <87bomhfqh7.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bomhfqh7.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday, April 25, 2012, Simon Horman wrote:
> On Tue, Apr 24, 2012 at 02:07:05AM -0700, Kuninori Morimoto wrote:
> > 
> > Hi Rafael, Magnus
> > Cc Simon
> > 
> > These are incremental patch set for armadillo800eva.
> > 
> > Kuninori Morimoto (8):
> >       ARM: mach-shmobile: clock-r8a7740: add USB clock
> >       ARM: mach-shmobile: clock-r8a7740: add SDHI clock
> >       ARM: mach-shmobile: clock-r8a7740: add MMCIF clock
> >       ARM: mach-shmobile: armadillo800eva: add USB function support
> >       ARM: mach-shmobile: armadillo800eva: add SDHI0 support
> >       ARM: mach-shmobile: armadillo800eva: add SDHI1 support
> >       ARM: mach-shmobile: armadillo800eva: add MMCIF support
> >       ARM: mach-shmobile: r8a7740: Reserve DMA memory for the frame buffer
> 
> All 8 patches
> 
> Tested-by: Simon Horman <horms@verge.net.au>

Patches [1-3/8] applied to the r8a7740 branch of the renesas.git tree.
However, I had to handle several merge conflicts with the FSI clock patch
applied previously, so please check if everything is correct in the tree.

Patches [4-8/8] applied to the armadillo800eva branch of the renesas.git tree,
on top of the r8a7740 branch.

Thanks,
Rafael
