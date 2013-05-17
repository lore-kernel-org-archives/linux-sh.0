From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 17 May 2013 19:05:59 +0000
Subject: Re: [PATCH 8/9] ARM: shmobile: APE6EVM: switch to using platform_add_devices()
Message-Id: <alpine.DEB.2.00.1305172103470.3673@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <1368802520-16378-9-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1368802520-16378-9-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei

On Fri, 17 May 2013, Sergei Shtylyov wrote:

> Hello.
> 
> On 05/17/2013 06:55 PM, Guennadi Liakhovetski wrote:
> 
> > Switch from platform_device_register_resndata() to platform_add_devices()
> > to make adding new devices easier.
> > 
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> > ---
> >   arch/arm/mach-shmobile/board-ape6evm.c |   26 +++++++++++++++++++++-----
> >   1 files changed, 21 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/board-ape6evm.c
> > b/arch/arm/mach-shmobile/board-ape6evm.c
> > index 5eb0caa..9c69643 100644
> > --- a/arch/arm/mach-shmobile/board-ape6evm.c
> > +++ b/arch/arm/mach-shmobile/board-ape6evm.c
> [...]
> > @@ -64,6 +74,13 @@ static const struct pinctrl_map ape6evm_pinctrl_map[] = {
> >   				  "irqc_irq40", "irqc"),
> >   };
> >   +/*
> > + * board devices
> > + */
> > +static struct platform_device *ape6evm_devices[] __initdata = {
> > +	&lan9220_device,
> > +};
> > +
> >   static void __init ape6evm_add_standard_devices(void)
> >   {
> >   @@ -91,9 +108,8 @@ static void __init ape6evm_add_standard_devices(void)
> >     	regulator_register_fixed(0, dummy_supplies,
> > ARRAY_SIZE(dummy_supplies));
> >   -	platform_device_register_resndata(&platform_bus, "smsc911x", -1,
> > -					  lan9220_res,
> > ARRAY_SIZE(lan9220_res),
> > -					  &lan9220_data,
> > sizeof(lan9220_data));
> > +	platform_add_devices(ape6evm_devices,
> > +			     ARRAY_SIZE(ape6evm_devices));
> 
>    We have been discouraged from using platform_device_register() and its ilk
> by Greg KH and Arnd, so
> 
> platform_device_register_resndata() might have been there on purpose.

Sure, I was surprised as well. Could you point me to a thread? I just 
thought - it's ok for one device, but repeating 
platform_device_register_*() multiple times for each device wouldn't look 
very nice. But I'll switch back to this, if that's really the current 
preference.

Thanks
Guennadi

> 
> 
> WBR, Sergei
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
