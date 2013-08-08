From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 08 Aug 2013 11:48:20 +0000
Subject: Re: [PATCH v2 7/9] ARM: shmobile: lager: Constify platform data and resources
Message-Id: <23323882.fMnAu4bgof@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1375916192-22647-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375916192-22647-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Sergei,

On Thursday 08 August 2013 15:37:30 Sergei Shtylyov wrote:
> On 08-08-2013 2:56, Laurent Pinchart wrote:
> > Platform data and resources for Lager devices are kmemdup()ed when the
> > corresponding devices are registered and can thus be declared as const.
> > Do so.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >   arch/arm/mach-shmobile/board-lager.c | 14 +++++++-------
> >   1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/arm/mach-shmobile/board-lager.c
> > b/arch/arm/mach-shmobile/board-lager.c index 4872939..76363f9 100644
> > --- a/arch/arm/mach-shmobile/board-lager.c
> > +++ b/arch/arm/mach-shmobile/board-lager.c
> > @@ -55,7 +55,7 @@ static struct gpio_led lager_leds[] = {
> > 
> >   	},
> >   
> >   };
> > 
> > -static __initdata struct gpio_led_platform_data lager_leds_pdata = {
> > +static const __initdata struct gpio_led_platform_data lager_leds_pdata > > {
> 
> Shouldn't it be annotated with '__initconst' now?

Yes it should, like in the other patches. I'll resubmit the series.

> Also, I've heard that the annotation should come last for the data
> definitions, otherwise it won't take effect (is that really true?).

I don't know, but I'll move to __initconst last nonetheless, as that's the 
preferred formatting in the kernel.

-- 
Regards,

Laurent Pinchart

