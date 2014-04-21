From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Apr 2014 08:56:41 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: Koelsch DT serial integration prototype
Message-Id: <CAMuHMdXv-Hp5KO09+BHOSRW4YPW+pdvDUNGGPUxPurDmmHO-XA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140421013114.3236.90868.sendpatchset@w520>
In-Reply-To: <20140421013114.3236.90868.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Mon, Apr 21, 2014 at 3:31 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> A simple serial port integration prototype that happens to
> target Koelsch. Written to propose how to move one step closer
> to integrate DT support for serial ports on mach-shmobile.

[...]

> 1) It enables serial ports in the board specific DTS
>   -> Nothing special here, except perhaps the preserved device order

Good, thanks!

> 2) It extends the existing platform device registration code
>   -> When the existing C board code calls to add serial platform devices
>      then we check if DT platform devices exist in the DTB. If so then
>      we disable the serial DT devices and stick with platform devices.

Is there any specific reason why you chose this solution, over the alternative
approach of not registering the platform devices if the corresponding serial
devices are present in DT?

> The combination of 1) and 2) allows us to use the same DTB regardless
> if C board code is compiled in or not. Also migration becomes easy
> and forgiving, if for instance the user only updates the kernel and
> uses the old DTB then the board code will keep on working even though
> serial devices may not be present in the DTS.

Very well!

> --- 0001/arch/arm/mach-shmobile/setup-r8a7791.c
> +++ work/arch/arm/mach-shmobile/setup-r8a7791.c 2014-04-17 16:32:32.000000000 +0900
> @@ -94,7 +94,9 @@ static struct plat_sci_port scif##index#
>  static struct resource scif##index##_resources[] = {                   \
>         DEFINE_RES_MEM(baseaddr, 0x100),                                \
>         DEFINE_RES_IRQ(irq),                                            \
> -}
> +};                                                                     \
> +                                                                       \
> +static struct property scif##index##_property

This is static, as the property's lifecycle dictates it to stay alive...

>  #define R8A7791_SCIF(index, baseaddr, irq)                             \
>         __R8A7791_SCIF(PORT_SCIF, index, baseaddr, irq)
> @@ -121,7 +123,30 @@ R8A7791_SCIFA(12, 0xe6c70000, gic_spi(29
>  R8A7791_SCIFA(13, 0xe6c78000, gic_spi(30)); /* SCIFA4 */
>  R8A7791_SCIFA(14, 0xe6c80000, gic_spi(31)); /* SCIFA5 */
>
> +static void serial_disable_dt(struct resource *res, struct property *prop)
> +{
> +       struct device_node *np;
> +       char str[17];
> +       char *disabled = "disabled";

... while this is a local variable on the stack, with limited lifetime.
So that should be:

        static char disabled[] = "disabled";

> +       snprintf(str, ARRAY_SIZE(str), "/serial@%08x",
> +                (unsigned int)res->start);
> +
> +       np = of_find_node_by_path(str);
> +       if (np) {
> +               if (of_device_is_available(np)) {
> +                       prop->name = "status";
> +                       prop->length = strlen(disabled) + 1;

Or "sizeof(disabled)", after changing to a static array.

> +                       prop->value = disabled;
> +                       of_update_property(np, prop);
> +                       printk("xxx disabled %s\n", str);

pr_info(), drop the "xxx ", capitalize "Disabled".

> +               }
> +               of_node_put(np);
> +       }
> +}
> +
>  #define r8a7791_register_scif(index)                                          \
> +       serial_disable_dt(scif##index##_resources, &scif##index##_property);   \
>         platform_device_register_resndata(&platform_bus, "sh-sci", index,      \
>                                           scif##index##_resources,             \
>                                           ARRAY_SIZE(scif##index##_resources), \

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
