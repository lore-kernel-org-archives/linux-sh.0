From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 11 Apr 2014 09:00:08 +0000
Subject: Re: [PATCH][RFC] ARM: shmobile: lager: move res/data into init function
Message-Id: <CAMuHMdXdoo2x_Ae2Xb3YHRA5FUpdrNVGGBPRWU34cZkFL-h_zw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87txa4thq0.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87txa4thq0.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Fri, Apr 11, 2014 at 2:39 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
>> > -static const struct resource du_resources[] __initconst = {
>> > -       DEFINE_RES_MEM(0xfeb00000, 0x70000),
>> > -       DEFINE_RES_MEM_NAMED(0xfeb90000, 0x1c, "lvds.0"),
>> > -       DEFINE_RES_MEM_NAMED(0xfeb94000, 0x1c, "lvds.1"),
>> > -       DEFINE_RES_IRQ(gic_spi(256)),
>> > -       DEFINE_RES_IRQ(gic_spi(268)),
>> > -       DEFINE_RES_IRQ(gic_spi(269)),
>> > -};
>> > -
>> >  static void __init lager_add_du_device(void)
>> >  {
>> > +       struct resource du_resources[] = {
>> > +               DEFINE_RES_MEM(0xfeb00000, 0x70000),
>> > +               DEFINE_RES_MEM_NAMED(0xfeb90000, 0x1c, "lvds.0"),
>> > +               DEFINE_RES_MEM_NAMED(0xfeb94000, 0x1c, "lvds.1"),
>> > +               DEFINE_RES_IRQ(gic_spi(256)),
>> > +               DEFINE_RES_IRQ(gic_spi(268)),
>> > +               DEFINE_RES_IRQ(gic_spi(269)),
>> > +       };
>>
>> Shouldn't the above retain the "static const"?
>> Without the static, there will be additonal code to perform the initialization
>> on the stack.
>
> "static" is not needed.
> Becouse ...
>
> platform_device_register_xxx()
>  -> platform_device_register_full()
>    -> platform_device_add_resources()
>    -> platform_device_add_data()
>
> platform_device_add_resources/data() are using kmemdup().
> This means, driver uses alloced and copied resource/data,
> not above one.

Sure, it's copied, so the original data doesn't have to persist at that
address.

My comment was more about code/size optimizations: if you declare
du_resources[] as a local (non-static) variable on the stack, the compiler
has to construct it on the stack. For basic data types (e.g. int, long) this
requires not that much code (the variable may end up in a register), but
for more complex structures, the compiler may emit quite some code,
making it more economic to make the variable static.
For functions that are called multiple times (which is not the case here),
there's another reason to use static: the variable on the stack will be
constructed on every function call, over and over again.

Perhaps you can have a look at the generated assembler, to see whether
it's worth it?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
