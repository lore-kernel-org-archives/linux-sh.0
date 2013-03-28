From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 28 Mar 2013 11:03:12 +0000
Subject: Re: [PATCH 1/3] sh-pfc: r8a7779: Replace hardcoded pin numbers with GP_PIN macro
Message-Id: <6123119.8fBHpfpakU@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1364411253-12170-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1364411253-12170-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Thursday 28 March 2013 19:51:48 Magnus Damm wrote:
> On Thu, Mar 28, 2013 at 6:58 PM, Laurent Pinchart wrote:
> > On Thursday 28 March 2013 14:16:15 Magnus Damm wrote:
> >> On Thu, Mar 28, 2013 at 4:07 AM, Laurent Pinchart wrote:
> >> > Pins are numbered in the r8a7779 documentation using a bank number and
> >> > a pin number in the bank. As the pinctrl pin number space is linear,
> >> > this is flattened by multiplying the bank number by 32 and adding the
> >> > pin number. The resulting pin number has no direct relationship with
> >> > the documentation, making it error-prone.
> >> > 
> >> > Add and use a GP_PIN macro to convert from the documentation pin number
> >> > space to the linear pinctrl space.
> >> > 
> >> > Signed-off-by: Laurent Pinchart
> >> > <laurent.pinchart+renesas@ideasonboard.com>
> >> > ---
> >> > 
> >> >  drivers/pinctrl/sh-pfc/pfc-r8a7779.c | 270 ++++++++++++++-------------
> >> >  1 file changed, 142 insertions(+), 128 deletions(-)
> >> 
> >> Hi Laurent,
> >> 
> >> Thanks for your work on this. I think this series looks great, but I have
> >> one minor question:
> >>
> >> > diff --git a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> >> > b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c index e448ff1..29d4b21 100644
> >> > --- a/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> >> > +++ b/drivers/pinctrl/sh-pfc/pfc-r8a7779.c
> >> > @@ -1469,12 +1469,16 @@ static struct sh_pfc_pin pinmux_pins[] = {
> >> > 
> >> >         PINMUX_GPIO_GP_ALL(),
> >> >  
> >> >  };
> >> > 
> >> > +#define GP_PIN(bank, pin)      (((bank) * 32) + (pin))
> >> 
> >> You seem to have two copies of this macro, why is that?
> > 
> > The copy in arch/arm/mach-shmobile/include/mach/ can't be accessed from
> > drivers/pinctrl/sh-pfc/. The other option would be to create a per-SoC
> > file in include/linux/pinctrl/ just to hold that macro, but I thought it
> > wasn't worth it. When boards will be moved to DT the copy in
> > arch/arm/mach-shmobile/include/mach/ will disappear anyway.
> 
> Right, I understand. One option is to put in a mach-shmobile specific header
> and share it across our SoCs that need it. It is however a bit ugly. But
> this GP_PIN() macro will most likely be used on SoCs that have banked GPIOs,
> right?

That's right. Please note, however, that some SoCs might have banks with a 
different number of pins per bank, so we might need different macros depending 
on the SoC.

> Based on that, how about putting the GP_PIN() macro in
> include/linux/platform_data/gpio-rcar.h? I realize that that is a different
> separate driver, but those GPIOs are actually backed by that driver. And it
> happens to be that the platforms that need to make use of GP_PIN() also make
> use of the gpio-rcar driver.

Hmmm... I'm not too keen on that, as the GP_PIN() macro isn't really related 
to platform data. On the other hand we wouldn't be the first ones to shove 
unrelated code in include/linux/platform-data/.

Another option would be a new include/linux/pinctrl/sh-pfc.h file where we 
could put all similar macros (in which case they would need to be prefixed 
with the SoC name), but I'm really not sure it's worth it.

-- 
Regards,

Laurent Pinchart

