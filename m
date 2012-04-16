From: Simon Horman <horms@verge.net.au>
Date: Mon, 16 Apr 2012 05:21:54 +0000
Subject: Re: [PATCH 0/7 v2] ARM: mach-shmobile: add Armadillo800eva board support
Message-Id: <20120416052151.GA8047@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87sjghjmeu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Apr 15, 2012 at 07:10:47PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > > > > Patches [2-4/7] and [6-7/7] applied to the armadillo800eva branch of the
> > > > > renesas.git tree.  Please let me know what the status of patch [5/7] is.
> > > > 
> > > > Hi Rafael,
> > > > 
> > > > I have not been able to successfully test 5/7 yet.
> > > > I'll let you know when that changes.
> > > 
> > > I tested 5/7 patch this morning.
> > > It seems work well on my board.
> > > What's happen on your tmenu/board ?
> > 
> > Nothing :^)
> > 
> > # tmenu /dev/input/event0
> > [ nothing ]
> > 
> > I am using 3.4-rc2 as a base, perhaps a different
> > base would be better?
> 
> Hmm... strange.
> If your .config has CONFIG_TOUCHSCREEN_ST1232,
> but nothing happen, your board seems broken.
> 
> BTW, Did you touch the panel after tmenu ?

Yes.

It seems to me that its more likely that my build is broken
than my board. Would it be possible for you to test the image
at the following link on your board?

http://horms.org/tmp/zImage-g9adc328

md5sum: 6d747f8f4f44a20bdde31a324f844c0b

It is an image of 3.4-rc2 + the following patches + an initrd with
tmenu included. The config is available in /proc/config.gz

9adc328 ASoC: fsi: update for dmaengine prep_slave_sg fallout.
8d6c869 ARM: mach-shmobile: armadillo800eva: add support sh_eth
8afd7b1 ARM: mach-shmobile: armadillo800eva: add support gpio_key
5f0c97e ARM: mach-shmobile: armadillo800eva: add support ST1232
9699241 ARM: mach-shmobile: armadillo800eva: add support LCDC0
5cb5735 ARM: mach-shmobile: armadillo800eva: add defconfig
092928a ARM: mach-shmobile: add armadillo800eva board support.
c8ad89c ARM: mach-shmobile: pfc-r8a7740: add gpio_irq support

