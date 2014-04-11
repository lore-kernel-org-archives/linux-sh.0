From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Fri, 11 Apr 2014 00:39:13 +0000
Subject: Re: [PATCH][RFC] ARM: shmobile: lager: move res/data into init function
Message-Id: <87wqewog1y.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87txa4thq0.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87txa4thq0.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

Thank you for your review

> > -static const struct resource du_resources[] __initconst = {
> > -       DEFINE_RES_MEM(0xfeb00000, 0x70000),
> > -       DEFINE_RES_MEM_NAMED(0xfeb90000, 0x1c, "lvds.0"),
> > -       DEFINE_RES_MEM_NAMED(0xfeb94000, 0x1c, "lvds.1"),
> > -       DEFINE_RES_IRQ(gic_spi(256)),
> > -       DEFINE_RES_IRQ(gic_spi(268)),
> > -       DEFINE_RES_IRQ(gic_spi(269)),
> > -};
> > -
> >  static void __init lager_add_du_device(void)
> >  {
> > +       struct resource du_resources[] = {
> > +               DEFINE_RES_MEM(0xfeb00000, 0x70000),
> > +               DEFINE_RES_MEM_NAMED(0xfeb90000, 0x1c, "lvds.0"),
> > +               DEFINE_RES_MEM_NAMED(0xfeb94000, 0x1c, "lvds.1"),
> > +               DEFINE_RES_IRQ(gic_spi(256)),
> > +               DEFINE_RES_IRQ(gic_spi(268)),
> > +               DEFINE_RES_IRQ(gic_spi(269)),
> > +       };
> 
> Shouldn't the above retain the "static const"?
> Without the static, there will be additonal code to perform the initialization
> on the stack.

"static" is not needed.
Becouse ...

platform_device_register_xxx()
 -> platform_device_register_full()
   -> platform_device_add_resources()
   -> platform_device_add_data()

platform_device_add_resources/data() are using kmemdup().
This means, driver uses alloced and copied resource/data,
not above one.

Best regards
---
Kuninori Morimoto
