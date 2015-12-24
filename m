From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 24 Dec 2015 14:58:20 +0000
Subject: Re: [PATCH 1/2] spi: sh-msiof: Add rcar fallback compatibility string
Message-Id: <CAMuHMdXe8Jpz6aTJkLTcNkKpsoV7tDSjUwuaZY7LxfojA9z7cw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450955807-22869-1-git-send-email-ykaneko0929@gmail.com>
	<1450955807-22869-2-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1450955807-22869-2-git-send-email-ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Kaneko-san,

On Thu, Dec 24, 2015 at 12:16 PM, Yoshihiro Kaneko
<ykaneko0929@gmail.com> wrote:
> Add fallback compatibility string for R-Car Gen2 and Gen3.
> This is in keeping with the fallback scheme being adopted wherever
> appropriate for drivers for Renesas SoCs.
> In Addition, this patch deletes the compat strings for old SoCs.

 "renesas,sh-mobile-msiof" is in use in arch/arm/boot/dts/sh73a0.dtsi, so you
cannot just delete it.

> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/sh-msiof.txt | 11 ++++++++---
>  drivers/spi/spi-sh-msiof.c                         |  5 +++--
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
> index aa005c1..d9d89ee 100644
> --- a/Documentation/devicetree/bindings/spi/sh-msiof.txt
> +++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
> @@ -2,8 +2,8 @@ Renesas MSIOF spi controller
>
>  Required properties:
>  - compatible           : "renesas,msiof-<soctype>" for SoCs,
> -                        "renesas,sh-msiof" for SuperH, or
> -                        "renesas,sh-mobile-msiof" for SH Mobile series.

 "renesas,sh-mobile-msiof" is in use.

> +                        "renesas,rcar-gen2-msiof" for R-Car Gen2 series, or
> +                        "renesas,rcar-gen3-msiof" for R-Car Gen3 series.
>                          Examples with soctypes are:
>                          "renesas,msiof-r8a7790" (R-Car H2)
>                          "renesas,msiof-r8a7791" (R-Car M2-W)

> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index a7934ab..283fb31 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c

> @@ -971,8 +972,8 @@ static const struct sh_msiof_chipdata r8a779x_data = {
>  };
>
>  static const struct of_device_id sh_msiof_match[] = {
> -       { .compatible = "renesas,sh-msiof",        .data = &sh_data },
> -       { .compatible = "renesas,sh-mobile-msiof", .data = &sh_data },

 "renesas,sh-mobile-msiof" is in use.

> +       { .compatible = "renesas,rcar-gen2-msiof", .data = &r8a779x_data },
> +       { .compatible = "renesas,rcar-gen3-msiof", .data = &r8a779x_data },
>         { .compatible = "renesas,msiof-r8a7790",   .data = &r8a779x_data },
>         { .compatible = "renesas,msiof-r8a7791",   .data = &r8a779x_data },
>         { .compatible = "renesas,msiof-r8a7792",   .data = &r8a779x_data },

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
