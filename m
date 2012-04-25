From: "Rafael J. Wysocki" <rjw@sisk.pl>
Date: Wed, 25 Apr 2012 21:13:52 +0000
Subject: Re: ARM: mach-shmobile: incremental KZM-A9-GT board support
Message-Id: <201204252313.52510.rjw@sisk.pl>
List-Id: <linux-sh.vger.kernel.org>
References: <87bomj9bzl.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bomj9bzl.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wednesday, April 25, 2012, Simon Horman wrote:
> On Sun, Apr 22, 2012 at 11:52:02PM -0700, kuninori.morimoto.gx@renesas.com wrote:
> > 
> > Hi Rafael, Magnus
> > Cc Simon
> > 
> > These are incremental KZM-A9-GT board support patches.
> > These are based on "ARM: mach-shmobile: add KZM-A9-GT board support" patch series
> > 
> > Kuninori Morimoto (6):
> >       ARM: mach-shmobile: pfc-sh73a0: fixup MSEL2CR MSEL18 for I2C-3
> >       ARM: mach-shmobile: sh73a0.h: add GPIO_NR
> >       ARM: mach-shmobile: kzm9g: correct screen direction
> >       ARM: mach-shmobile: kzm9g: add MMCIF support
> >       ARM: mach-shmobile: kzm9g: add SDHI support
> >       ARM: mach-shmobile: kzm9g: add PCF8757 gpio-key
> > 
> > #1 is bugfix patch for I2C-3.
> > #1, #2 are required by #6 patch.
> 
> All patches
> 
> Tested-by: Simon Horman <horms@verge.net.au>

Patches [1-6/6] applied to the kzm9g branch of the renesas.git tree.

Thanks,
Rafael
