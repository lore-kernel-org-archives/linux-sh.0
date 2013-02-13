From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 13 Feb 2013 18:18:33 +0000
Subject: Re: [PATCH 2/3] drm: Renesas R-Car Display Unit DRM driver
Message-Id: <1952026.K0AL5gJOGS@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1359596703-17556-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1359596703-17556-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20130213122820.GA19512@verge.net.au>
In-Reply-To: <20130213122820.GA19512@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>, linux-sh@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, magnus.damm@gmail.com

Hi Simon,

On Wednesday 13 February 2013 21:28:20 Simon Horman wrote:
> On Thu, Jan 31, 2013 at 02:45:02AM +0100, Laurent Pinchart wrote:
> > The R-Car Display Unit (DU) DRM driver supports both superposition
> > processors and all eight planes in RGB and YUV formats without alpha
> > blending.
> > 
> > Only VGA and LVDS encoders and connectors are currently supported.
> 
> As discussed elsewhere I have applied this series to topic/r-car-du-drm
> in the renesas tree.
> 
> Subsequently, thanks to the wonder that is kbuild,
> I have noticed the following build error when using this series
> in conjunction with "ARM: shmobile: r8a7779: Remove DU function GPIOs".
> 
> Clearly this will not be a problem if this series is applied before
> the patch above. But presumably it will be a problem down the road.
> And actually it is currently a (ignorable) problem in topic/all+next.
> 
> In any case, I was wondering if Laurent could cook up an add-on patch
> to resolve this problem. At the very least it would provide a
> reference for how to solve the problem later on and as a bonus clean
> up topic/all+next.

The DU board code I've submitted for the Marzen board doesn't use the pinctrl 
API yet, as I wanted the DU DRM driver to be usable without waiting for the 
next pinctrl series to be ready. I will fix this later, either in the DU DRM 
driver patch series or in the pinctrl patch series, depending on which one is 
ready first.

In the meantime, please keep the branches separate.

> error:
> arch/arm/mach-shmobile/board-marzen.c:107:15: error: 'MMC_CAP_SD_HIGHSPEED'
> undeclared here (not in a function) arch/arm/mach-shmobile/board-marzen.c:
> In function 'marzen_init':
> arch/arm/mach-shmobile/board-marzen.c:401:15: error: 'GPIO_FN_DU0_DR7'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:401:15: note: each undeclared
> identifier is reported only once for each function it appears in
> arch/arm/mach-shmobile/board-marzen.c:402:15: error: 'GPIO_FN_DU0_DR6'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:403:15: error: 'GPIO_FN_DU0_DR5'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:404:15: error: 'GPIO_FN_DU0_DR4'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:405:15: error: 'GPIO_FN_DU0_DR3'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:406:15: error: 'GPIO_FN_DU0_DR2'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:407:15: error: 'GPIO_FN_DU0_DR1'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:408:15: error: 'GPIO_FN_DU0_DR0'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:409:15: error: 'GPIO_FN_DU0_DG7'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:410:15: error: 'GPIO_FN_DU0_DG6'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:411:15: error: 'GPIO_FN_DU0_DG5'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:412:15: error: 'GPIO_FN_DU0_DG4'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:413:15: error: 'GPIO_FN_DU0_DG3'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:414:15: error: 'GPIO_FN_DU0_DG2'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:415:15: error: 'GPIO_FN_DU0_DG1'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:416:15: error: 'GPIO_FN_DU0_DG0'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:417:15: error: 'GPIO_FN_DU0_DB7'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:418:15: error: 'GPIO_FN_DU0_DB6'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:419:15: error: 'GPIO_FN_DU0_DB5'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:420:15: error: 'GPIO_FN_DU0_DB4'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:421:15: error: 'GPIO_FN_DU0_DB3'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:422:15: error: 'GPIO_FN_DU0_DB2'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:423:15: error: 'GPIO_FN_DU0_DB1'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:424:15: error: 'GPIO_FN_DU0_DB0'
> undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:425:15: error:
> 'GPIO_FN_DU0_EXVSYNC_DU0_VSYNC' undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:426:15: error:
> 'GPIO_FN_DU0_EXHSYNC_DU0_HSYNC' undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:427:15: error:
> 'GPIO_FN_DU0_DOTCLKOUT0' undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:428:15: error:
> 'GPIO_FN_DU0_DOTCLKOUT1' undeclared (first use in this function)
> arch/arm/mach-shmobile/board-marzen.c:429:15: error: 'GPIO_FN_DU0_DISP'
> undeclared (first use in this function)

-- 
Regards,

Laurent Pinchart

