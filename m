From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 02 May 2014 18:21:47 +0000
Subject: Re: [PATCH v5 12/15] ARM: shmobile: r8a7778: Switch to new style TMU device
Message-Id: <29769434.fenvyKNn4c@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1398251722-31667-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398251722-31667-13-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Friday 02 May 2014 05:51:07 Geert Uytterhoeven wrote:
> Hi Laurent,
> 
> On Wed, Apr 23, 2014 at 1:15 PM, Laurent Pinchart wrote:
> > --- a/arch/arm/mach-shmobile/setup-r8a7778.c
> > +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
> > @@ -71,33 +71,20 @@ R8A7778_SCIF(5, 0xffe45000, gic_iid(0x6b));
> > 
> >                                           sizeof(scif##index##_platform_da
> >                                           ta))
> >  
> >  /* TMU */
> > 
> > -static struct resource sh_tmu0_resources[] __initdata = {
> > -       DEFINE_RES_MEM(0xffd80008, 12),
> > -       DEFINE_RES_IRQ(gic_iid(0x40)),
> 
> gic_iid(0x40)
> 
> > +static struct sh_timer_config sh_tmu0_platform_data = {
> > +       .channels_mask = 7,
> > 
> >  };
> > 
> > -static struct sh_timer_config sh_tmu0_platform_data __initdata = {
> > -       .name                   = "TMU00",
> > -       .channel_offset         = 0x4,
> > -       .timer_bit              = 0,
> > -       .clockevent_rating      = 200,
> > -};
> > -
> > -static struct resource sh_tmu1_resources[] __initdata = {
> > -       DEFINE_RES_MEM(0xffd80014, 12),
> > -       DEFINE_RES_IRQ(gic_iid(0x41)),
> > -};
> > -
> > -static struct sh_timer_config sh_tmu1_platform_data __initdata = {
> > -       .name                   = "TMU01",
> > -       .channel_offset         = 0x10,
> > -       .timer_bit              = 1,
> > -       .clocksource_rating     = 200,
> > +static struct resource sh_tmu0_resources[] = {
> > +       DEFINE_RES_MEM(0xffd80000, 0x30),
> > +       DEFINE_RES_IRQ(gic_spi(0x40)),
> > +       DEFINE_RES_IRQ(gic_spi(0x41)),
> > +       DEFINE_RES_IRQ(gic_spi(0x42)),
> > 
> >  };
> 
> So these should be gic_iid(x04x), too?

Definitely. I've sent a fixed v6 patch.

-- 
Regards,

Laurent Pinchart

