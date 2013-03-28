From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 28 Mar 2013 09:58:42 +0000
Subject: Re: [PATCH 1/3] sh-pfc: r8a7779: Replace hardcoded pin numbers with GP_PIN macro
Message-Id: <1744814.4NaACCecDb@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1364411253-12170-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1364411253-12170-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Thursday 28 March 2013 14:16:15 Magnus Damm wrote:
> On Thu, Mar 28, 2013 at 4:07 AM, Laurent Pinchart wrote:
> > Pins are numbered in the r8a7779 documentation using a bank number and a
> > pin number in the bank. As the pinctrl pin number space is linear, this
> > is flattened by multiplying the bank number by 32 and adding the pin
> > number. The resulting pin number has no direct relationship with the
> > documentation, making it error-prone.
> > 
> > Add and use a GP_PIN macro to convert from the documentation pin number
> > space to the linear pinctrl space.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 270  +++++++++++++++--------------
> >  1 file changed, 142 insertions(+),
> >  128 deletions(-)
> 
> Hi Laurent,
> 
> Thanks for your work on this. I think this series looks great, but I
> 
> have one minor question:
> > diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> > b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c index e448ff1..29d4b21 100644
> > --- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> > @@ -1469,12 +1469,16 @@ static struct sh_pfc_pin pinmux_pins[] = {
> >         PINMUX_GPIO_GP_ALL(),
> >  };
> > 
> > +#define GP_PIN(bank, pin)      (((bank) * 32) + (pin))
> 
> You seem to have two copies of this macro, why is that?

The copy in arch/arm/mach-shmobile/include/mach/ can't be accessed from 
drivers/pinctrl/sh-pfc/. The other option would be to create a per-SoC file in 
include/linux/pinctrl/ just to hold that macro, but I thought it wasn't worth 
it. When boards will be moved to DT the copy in arch/arm/mach-
shmobile/include/mach/ will disappear anyway.

-- 
Regards,

Laurent Pinchart

