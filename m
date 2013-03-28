From: Simon Horman <horms@verge.net.au>
Date: Thu, 28 Mar 2013 00:24:08 +0000
Subject: Re: [PATCH/RFC 00/12] Split PFC and GPIO for R8A7779
Message-Id: <20130328002408.GD20736@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1362941928-18115-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362941928-18115-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Mar 27, 2013 at 07:17:23PM +0100, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Wednesday 27 March 2013 19:47:34 Simon Horman wrote:
> > On Sun, Mar 10, 2013 at 07:58:36PM +0100, Laurent Pinchart wrote:
> > > Hello,
> > > 
> > > This patch set replaces the GPIO handling code in the PFC driver with the
> > > Renesas R-Car (R8A7779) GPIO driver submitted by Magnus Damm.
> > > 
> > > Patch 01/12 adds the R-Car GPIO driver. I've picked the patch from the
> > > linux-sh mailing as-is. Review for this patch should be directed to the
> > > mailing list in the "[PATCH] gpio: Renesas R-Car GPIO driver" thread.
> > > Patch
> > > 02/12 further extends the GPIO driver to add pinctrl support.
> > > 
> > > Patch 03/12 adds a GPIO LEDs device to the Marzen board. This isn't
> > > strictly required by this patch series but is useful for test purposes.
> > > 
> > > Patches 04/12 to 07/12 make GPIOs support optional in the PFC driver and
> > > fix the pin configuration code to support an external GPIO driver.
> > > 
> > > Patches 08/12 to 10/12 remove function GPIOs from the R-Car platform and
> > > remove the now unused GPIO enumeration.
> > > 
> > > Finally patches 11/12 and 12/12 register GPIO devices for the R-Car
> > > platform and remove GPIO data from the R-Car SoC data.
> > > 
> > > The PFC GPIO code isn't removed as all platforms will need to be converted
> > > first. This is a first step towards that goal.
> > > 
> > > Laurent Pinchart (11):
> > >   gpio-rcar: Add pinctrl support
> > >   ARM: shmobile: marzen: Add GPIO LEDs
> > >   sh-pfc: Make function GPIOs support optional
> > >   sh-pfc: Make GPIO support optional
> > >   sh-pfc: Skip gpiochip registration when no GPIO resource is found
> > >   sh-pfc: Configure pins as GPIOs at request time when handled
> > >   
> > >     externally
> > >   
> > >   sh-pfc: r8a7779: Remove function GPIOs
> > >   sh-pfc: r8a7779: Don't use GPIO enum entries
> > >   ARM: shmobile: r8a7779: Remove all GPIOs
> > >   ARM: shmobile: r8a7779: Register GPIO devices
> > >   sh-pfc: r8a7779: Remove GPIO data
> > > 
> > > Magnus Damm (1):
> > >   gpio: Renesas R-Car GPIO driver
> > >  
> > >  arch/arm/mach-shmobile/board-marzen.c         |  32 ++
> > >  arch/arm/mach-shmobile/include/mach/r8a7779.h | 317 -------------------
> > >  arch/arm/mach-shmobile/setup-r8a7779.c        |  58 +++-
> > >  drivers/gpio/Kconfig                          |   6 +
> > >  drivers/gpio/Makefile                         |   1 +
> > >  drivers/gpio/gpio-rcar.c                      | 429 +++++++++++++++++++++
> > >  drivers/pinctrl/sh-pfc/core.c                 |  37 +--
> > >  drivers/pinctrl/sh-pfc/gpio.c                 |  45 +--
> > >  drivers/pinctrl/sh-pfc/pfc-r8a7779.c          | 419  ++++----------------
> > >  drivers/pinctrl/sh-pfc/pinctrl.c              |  11 +
> > >  include/linux/platform_data/gpio-rcar.h       |  30 ++
> > >  11 files changed, 672 insertions(+), 713 deletions(-)
> > >  create mode 100644 drivers/gpio/gpio-rcar.c
> > >  create mode 100644 include/linux/platform_data/gpio-rcar.h
> > 
> > Thanks Laurent,
> > 
> > I have cherry picked a revised version of this series from
> > your git tree into the pinmux branch of the renesas tree.
> > 
> > For reference The details of the tree are:
> > 
> > git://linuxtv.org/pinchartl/fbdev.git pinmux/3.9/gpio
> > Head commit: b00b260969c3c1fd357233c9c1c6bf6a6980d921
> 
> Thank you. When do you plan to merge that in a branch you will submit to v3.10 
> ?

I have pushed it to the pinmux branch which I intend to submit to v3.10.
Please let me know if I have missed anything.
