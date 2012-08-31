From: Simon Horman <horms@verge.net.au>
Date: Fri, 31 Aug 2012 00:23:06 +0000
Subject: Re: [PATCH 0/8] ARM: shmobile: r8a7779/marzen/kzm9g patches for v3.7
Message-Id: <20120831002305.GK7721@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87mx1fdbgl.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mx1fdbgl.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 30, 2012 at 04:48:43PM -0700, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> Thank you for checking my patches
> 
> > * v3.6-rc3
> > * usb-next
> > * exynos_v6_thermal_tree
> > * My marzen branch
> > * Patches 1-7 of this series
> > 
> > And the R-Car Thermal driver selected in the kernel .config I see the following:
> > 
> > # make
> >   CC      drivers/thermal/rcar_thermal.o
> > drivers/thermal/rcar_thermal.c: In function 'rcar_thermal_probe':
> > drivers/thermal/rcar_thermal.c:214:10: warning: passing argument 3 of 'thermal_zone_device_register' makes integer from pointer without a cast include/linux/thermal.h:166:29: note: expected 'int' but argument is of type 'struct rcar_thermal_priv *'
> > drivers/thermal/rcar_thermal.c:214:10: error: too few arguments to function 'thermal_zone_device_register'
> > include/linux/thermal.h:166:29: note: declared here
> > make[2]: *** [drivers/thermal/rcar_thermal.o] Error 1
> > make[1]: *** [drivers/thermal] Error 2
> > make: *** [drivers] Error 2
> 
> Someone had sent fixup patch for this issue to ML, but it seems still not applied.

Thanks, I think that as this is a driver problem not a board problem it
should be ok to push the board patch now. I will do so via my marzen branch.
