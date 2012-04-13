From: Simon Horman <horms@verge.net.au>
Date: Fri, 13 Apr 2012 01:07:40 +0000
Subject: Re: [PATCH 0/7 v2] ARM: mach-shmobile: add Armadillo800eva board support
Message-Id: <20120413010737.GD15175@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Apr 12, 2012 at 03:13:29AM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> Thank you for testing patches.
> 
> > > Kuninori Morimoto (7):
> > >       ARM: mach-shmobile: pfc-r8a7740: add gpio_irq support
> > >       ARM: mach-shmobile: add armadillo800eva board support.
> > >       ARM: mach-shmobile: armadillo800eva: add defconfig
> > >       ARM: mach-shmobile: armadillo800eva: add support LCDC0
> > >       ARM: mach-shmobile: armadillo800eva: add support ST1232
> > >       ARM: mach-shmobile: armadillo800eva: add support gpio_key
> > >       ARM: mach-shmobile: armadillo800eva: add support sh_eth
> > 
> > I have tested all of the patches above, except
> > "ARM: mach-shmobile: armadillo800eva: add support ST1232",
> > against 3.4-rc2. For those six patches:
> > 
> > 	Tested-by: Simon Horman <horms@verge.net.au>
> > 
> > I have also booted a kernel with "ARM: mach-shmobile: armadillo800eva: add
> > support ST1232", however I am unable to exercise this code as I am having
> > trouble bringing up an Android user-space. Tips on how the code might
> > be exercised would be greatly. appreciated.
> 
> I'm not sure about Android user-space, but I tested ST1232 by
> below tmenu on normal Linux user-space.
> 
> https://github.com/morimoto/smenu
> 
> # tmenu /dev/input/eventX

Thanks.

When I boot my board I get two devices in /dev/input/.
event0 and event1.

event1 seems to correspond to the keysc, and events are reported :)
I am not havinging any luck using tmenu with either event0 or event1
to monitor touchscreen events.

