From: Simon Horman <horms@verge.net.au>
Date: Fri, 19 Jul 2013 02:10:45 +0000
Subject: Re: [PATCH v2 00/27] sh-pfc: Support pins with no associated GPIO port
Message-Id: <20130719021045.GE4403@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1373933479-17727-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1373933479-17727-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

sure, that sounds reasonable.

I will put the patches in a new sh-pfc/pins-with-no-gpio-port branch
and include this in devel later today. It should be included
in the renesas-devel-20130719 tag.

On Thu, Jul 18, 2013 at 03:24:24AM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> I've received a positive test feedback for this patch series. Could you please 
> include it in your -devel tags to get wider test coverage ? I'll then wait a 
> couple of weeks and, if no problem is found, send a pull request to Linus to 
> get the series merged through the pinctrl tree.
> 
> On Tuesday 16 July 2013 02:10:52 Laurent Pinchart wrote:
> > Hello,
> > 
> > Here's the second version of a patch series that cleans up and refactors the
> > sh-pfc driver to add support for pins with no associated GPIO port.
> > 
> > Most configurable pins in SuperH and SH Mobile devices can be used as a
> > GPIO. However, some of them have selectable functions but are not
> > associated with a GPIO. Those pins must be defined in the pinmux pins array
> > but not registered in the GPIOs ranges.
> > 
> > The series first cleans up the sh-pfc driver by removing unused features (01
> > to 13) and then gradually refactors the code (14 to 21) to add pin numbers
> > to the sh_pfc_pin structure (22 to 24). It finally computes pin ranges
> > automatically (26) and adds support for pins without a GPIO port (27).
> > 
> > The patches have been compiled for all supported SoCs and tested on the
> > KZM9G board (SH73A0) with a hack to add I2C4 pins that have no GPIO port.
> > I'm lacking hardware to test R8A7778 which would be a good test candidate.
> > 
> > The patches are based on v3.11-rc1.
> > 
> > Changes since v1:
> > 
> > - Split patch 01/19 into per-SoC patches smaller than the vger limit
> > 
> > Laurent Pinchart (27):
> >   sh-pfc: sh7720: Remove unused input_pu range
> >   sh-pfc: sh7722: Remove unused input_pd and input_pu ranges
> >   sh-pfc: sh7723: Remove unused input_pu range
> >   sh-pfc: sh7724: Remove unused input_pu range
> >   sh-pfc: sh7757: Remove unused input_pu range
> >   sh-pfc: sh7785: Remove unused input_pu range
> >   sh-pfc: sh7786: Remove unused input_pu range
> >   sh-pfc: shx3: Remove unused input_pu range
> >   sh-pfc: Remove unused input_pd and input_pu ranges
> >   sh-pfc: Remove unused PORT_DATA_* macros
> >   sh-pfc: Remove unused macro and enum entries
> >   sh-pfc: Remove unneeded const keywords
> >   sh-pfc: Remove unused GPIO_PORT_ALL macro
> >   sh-pfc: Don't overallocate memory for the GPIO chip pins array
> >   sh-pfc: Replace pinmux_enum_id typedef with u16
> >   sh-pfc: Rename gpio arguments to be consistent with the rest of the
> >     code
> >   sh-pfc: Consolidate PFC SoC data macros
> >   sh-pfc: Consolidate pin definition macros
> >   sh-pfc: sh7734: Use the common GP port style macros
> >   sh-pfc: shx3: Remove shx3_ prefix from static symbols
> >   sh-pfc: Don't duplicate argument to PINMUX_GPIO macro
> >   sh-pfc: Add port numbers to the CPU_ALL_PORT macro
> >   sh-pfc: Pass the pin number down to the port function macro
> >   sh-pfc: Add pin number to struct sh_pfc_pin
> >   sh-pfc: Rename struct sh_pfc nr_pins field to nr_gpio_pins
> >   sh-pfc: Compute pin ranges automatically
> >   sh-pfc: Support pins not associated with a GPIO port
> > 
> >  drivers/pinctrl/sh-pfc/core.c        |   99 ++-
> >  drivers/pinctrl/sh-pfc/core.h        |   10 +-
> >  drivers/pinctrl/sh-pfc/gpio.c        |   45 +-
> >  drivers/pinctrl/sh-pfc/pfc-r8a73a4.c |  157 ++---
> >  drivers/pinctrl/sh-pfc/pfc-r8a7740.c |   47 +-
> >  drivers/pinctrl/sh-pfc/pfc-r8a7778.c |   55 +-
> >  drivers/pinctrl/sh-pfc/pfc-r8a7779.c |   63 +-
> >  drivers/pinctrl/sh-pfc/pfc-r8a7790.c |   59 +-
> >  drivers/pinctrl/sh-pfc/pfc-sh7203.c  |  202 ++++---
> >  drivers/pinctrl/sh-pfc/pfc-sh7264.c  |  246 ++++----
> >  drivers/pinctrl/sh-pfc/pfc-sh7269.c  |  285 +++++----
> >  drivers/pinctrl/sh-pfc/pfc-sh7372.c  |   53 +-
> >  drivers/pinctrl/sh-pfc/pfc-sh73a0.c  |  104 ++--
> >  drivers/pinctrl/sh-pfc/pfc-sh7720.c  |  701 +++++++++++-----------
> >  drivers/pinctrl/sh-pfc/pfc-sh7722.c  |  747 +++++++++++------------
> >  drivers/pinctrl/sh-pfc/pfc-sh7723.c  |  381 ++++++------
> >  drivers/pinctrl/sh-pfc/pfc-sh7724.c  | 1093 ++++++++++++++-----------------
> >  drivers/pinctrl/sh-pfc/pfc-sh7734.c  |   60 +-
> >  drivers/pinctrl/sh-pfc/pfc-sh7757.c  |  709 +++++++++++-----------
> >  drivers/pinctrl/sh-pfc/pfc-sh7785.c  |  700 +++++++++++-----------
> >  drivers/pinctrl/sh-pfc/pfc-sh7786.c  |  383 ++++++------
> >  drivers/pinctrl/sh-pfc/pfc-shx3.c    |  423 +++++++------
> >  drivers/pinctrl/sh-pfc/pinctrl.c     |   49 +-
> >  drivers/pinctrl/sh-pfc/sh_pfc.h      |  277 +++++----
> >  24 files changed, 3275 insertions(+), 3673 deletions(-)
> 
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
