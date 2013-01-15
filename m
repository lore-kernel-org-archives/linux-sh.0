From: Simon Horman <horms@verge.net.au>
Date: Tue, 15 Jan 2013 01:10:19 +0000
Subject: Re: [PATCH v2 1/8] sh-pfc: Add OF support
Message-Id: <20130115011019.GA13304@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1357693395-1653-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1357693395-1653-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <Pine.LNX.4.64.1301121745320.14443@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1301121745320.14443@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Phil Edworthy <phil.edworthy@renesas.com>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, devicetree-discuss@lists.ozlabs.org

On Sat, Jan 12, 2013 at 06:18:54PM +0100, Guennadi Liakhovetski wrote:
> Hi Laurent
> 
> On Wed, 9 Jan 2013, Laurent Pinchart wrote:
> 
> > Support device instantiation through the device tree. The compatible
> > property is used to select the SoC pinmux information.
> > 
> > Set the gpio_chip device field to the PFC device to enable automatic
> > GPIO OF support.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > Cc: devicetree-discuss@lists.ozlabs.org
> 
> This whole pinctrl mega-series is a very welcome improvement to the 
> sh-/r-mobile GPIO framework, and is very well done IMHO! But, 
> unfortunately, as discussed with you privately yesterday, there is still a 
> problem with pinctrl DT support on sh73a0, which will, probably, enforce 
> an update to one or several of patches from this lot. To explain to other 
> readers, on sh73a0 pin numbers are not contiguous, they are sparse. 
> When pins are referred to from C code, macro names are used, which are 
> then correctly decoded to respective positions in pin descriptor tables. 
> Whereas with DT, pins are referred to from .dts files using their physical 
> numbers, which then refer to either wrong or missing entries in those 
> tables.
> 
> I do not know where this problem should be solved best - either in 
> descriptor tables, or in DT handling code, so, I don't know which patches 
> would be affected. Don't think you'll want to keep the one-to-one 
> index-to-pin mapping by also making pin-descriptor arrays sparse, so, so 
> far I only see one possibility to fix this - by using the .enum_id field 
> from struct sh_pfc_pin instead of just the index - both in  C and in DT 
> case, and those .enum_id values will have to provide physical pin numbers 
> instead of plane indices. That way you'd have to update at least 
> drivers/pinctrl/sh-pfc/pfc-sh73a0.c and the sh_pfc_map_gpios() function in 
> drivers/pinctrl/sh-pfc/pinctrl.c.
> 
> Anyway, I'm sure you'll find a suitable solution of this problem and for 
> now I'll let Simon decide which patches he wants to apply and which ones 
> he'd prefer to hold back;-)

Actually, I'd appreciate some guidance from Laurent on this.
It seems that the problems you raise go quite far back into the mega-series.

I was intending to send pull requests for the following branches soon.
But I am now concerned that at least the sh73a0 patches may need reworking.

pfc2: (based on a merge of sh-soc2 and pfc)
sh-pfc: Add shx3 pinmux support
sh-pfc: Add sh7786 pinmux support
sh-pfc: Add sh7785 pinmux support
sh-pfc: Add sh7757 pinmux support
sh-pfc: Add sh7734 pinmux support
sh-pfc: Add sh7724 pinmux support
sh-pfc: Add sh7723 pinmux support
sh-pfc: Add sh7722 pinmux support
sh-pfc: Add sh7720 pinmux support
sh-pfc: Add sh7269 pinmux support
sh-pfc: Add sh7264 pinmux support
sh-pfc: Add sh7203 pinmux support
sh-pfc: Add sh73a0 pinmux support
sh-pfc: Add sh7372 pinmux support
sh-pfc: Add r8a7779 pinmux support
sh-pfc: Add r8a7740 pinmux support
sh-pfc: Support pinmux info in driver data instead of platform data
sh-pfc: Move driver from drivers/sh/ to drivers/pinctrl/
sh-pfc: Remove unused resource and num_resources platform data fields
sh-pfc: Remove platform device registration

sh-soc2: (based on pfc)
sh: shx3: Register PFC platform device
sh: sh7786: Register PFC platform device
sh: sh7785: Register PFC platform device
sh: sh7757: Register PFC platform device
sh: sh7734: Register PFC platform device
sh: sh7724: Register PFC platform device
sh: sh7723: Register PFC platform device
sh: sh7722: Register PFC platform device
sh: sh7720: Register PFC platform device
sh: sh7269: Register PFC platform device
sh: sh7264: Register PFC platform device
sh: sh7203: Register PFC platform device
sh: Add PFC platform device registration helper function


soc: (based on sh-soc)
ARM: shmobile: sh73a0: Add pin control resources
ARM: shmobile: sh7372: Add pin control resources
ARM: shmobile: r8a7740: Add pin control resources
ARM: shmobile: sh73a0: Register PFC platform device
ARM: shmobile: sh7372: Register PFC platform device
ARM: shmobile: r8a7779: Register PFC platform device
ARM: shmobile: r8a7740: Register PFC platform device
ARM: shmobile: Select PINCTRL
ARM: shmobile: add function declarations for sh7372 DT helper functions
ARM: sh7372: fix cache clean / invalidate order
ARM: sh7372: add clock lookup entries for DT-based devices
ARM: mach-shmobile: sh73a0 external IRQ wake update
ARM: shmobile: sh73a0: fixup div4_clks bitmap
ARM: shmobile: r8a7740: add TMU timer support
ARM: shmobile: Remove duplicate inclusion of dma-mapping.h in setup-r8a7740.c

pfc: (based on sh-soc)
sh-pfc: Support passing resources through platform device
sh-pfc: Split platform device and platform driver registration
sh-pfc: Use sh_pfc_ namespace prefix through the whole driver
sh-pfc: Sort headers alphabetically
sh-pfc: Remove check for impossible error condition
sh-pfc: Let the compiler decide whether to inline functions
sh-pfc: Use devm_ioremap_nocache()
sh-pfc: Use devm_kzalloc()
sh-pfc: Move platform device and driver to the core
sh-pfc: Merge PFC core and gpio
sh-pfc: Merge PFC core and pinctrl
sh-pfc: Move private definitions and declarations to private header
sh-pfc: Split platform data from the sh_pfc structure
sh-pfc: Remove all use of __devinit/__devexit

sh-soc:
sh: shx3: Fix last GPIO index
sh: sh7786: Fix last GPIO index
sh: sh7786: Fix port E, G and J GPIOs
sh: sh7757: Fix GPIO_FN_ET0_MDIO and GPIO_FN_ET1_MDIO GPIO entries
sh: sh7723: Rename GPIO_FN_SIUOSPD to GPIO_FN_SIUAOSPD
sh: sh7269: Rename CRX0CRX1(CRX2) marks to match GPIO names
sh: sh7264: Rename CRX0CRX1 mark to match GPIO names
