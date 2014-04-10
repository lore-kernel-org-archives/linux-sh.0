From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 10 Apr 2014 19:24:03 +0000
Subject: Re: [PATCH][RFC] ARM: shmobile: lager: move res/data into init function
Message-Id: <CAMuHMdXM6B3PutmvZoGF7iZmjjNaQ3K=2BaLV3MANfaDB34ALA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87txa4thq0.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87txa4thq0.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san,

On Tue, Apr 8, 2014 at 9:15 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
> +++ b/arch/arm/mach-shmobile/board-lager.c
> @@ -116,17 +116,17 @@ static const struct rcar_du_platform_data lager_du_pdata __initconst = {
>         .num_encoders = ARRAY_SIZE(lager_du_encoders),
>  };
>
> -static const struct resource du_resources[] __initconst = {
> -       DEFINE_RES_MEM(0xfeb00000, 0x70000),
> -       DEFINE_RES_MEM_NAMED(0xfeb90000, 0x1c, "lvds.0"),
> -       DEFINE_RES_MEM_NAMED(0xfeb94000, 0x1c, "lvds.1"),
> -       DEFINE_RES_IRQ(gic_spi(256)),
> -       DEFINE_RES_IRQ(gic_spi(268)),
> -       DEFINE_RES_IRQ(gic_spi(269)),
> -};
> -
>  static void __init lager_add_du_device(void)
>  {
> +       struct resource du_resources[] = {
> +               DEFINE_RES_MEM(0xfeb00000, 0x70000),
> +               DEFINE_RES_MEM_NAMED(0xfeb90000, 0x1c, "lvds.0"),
> +               DEFINE_RES_MEM_NAMED(0xfeb94000, 0x1c, "lvds.1"),
> +               DEFINE_RES_IRQ(gic_spi(256)),
> +               DEFINE_RES_IRQ(gic_spi(268)),
> +               DEFINE_RES_IRQ(gic_spi(269)),
> +       };

Shouldn't the above retain the "static const"?
Without the static, there will be additonal code to perform the initialization
on the stack.

> +
>         struct platform_device_info info = {
>                 .name = "rcar-du-r8a7790",
>                 .id = -1,

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
