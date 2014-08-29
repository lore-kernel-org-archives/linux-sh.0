From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Fri, 29 Aug 2014 12:07:21 +0000
Subject: Re: [PATCH v2] mmc: tmio-mmc: Add support for SDHI on new R-Car Gen2 SoCs
Message-Id: <CAPDyKFpPq+BUn4xh-9b39FB2R7ZtZ_4Fq_5uZ-JnNWD=jRL2nA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1409213239-5413-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1409213239-5413-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Chris Ball <chris@printf.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On 28 August 2014 10:07, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>   - r8a7792 (R-Car V2H)
>   - r8a7793 (R-Car M2-N)
>   - r8a7794 (R-Car E2)
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks! Applied for next.

Kind regards
Uffe

> ---
> v2: Drop RFC
> ---
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 3 +++
>  drivers/mmc/host/sh_mobile_sdhi.c                  | 3 +++
>  2 files changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> index fa0f327cde01..400b640fabc7 100644
> --- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> @@ -19,6 +19,9 @@ Required properties:
>                 "renesas,sdhi-r8a7779" - SDHI IP on R8A7779 SoC
>                 "renesas,sdhi-r8a7790" - SDHI IP on R8A7790 SoC
>                 "renesas,sdhi-r8a7791" - SDHI IP on R8A7791 SoC
> +               "renesas,sdhi-r8a7792" - SDHI IP on R8A7792 SoC
> +               "renesas,sdhi-r8a7793" - SDHI IP on R8A7793 SoC
> +               "renesas,sdhi-r8a7794" - SDHI IP on R8A7794 SoC
>
>  Optional properties:
>  - toshiba,mmc-wrprotect-disable: write-protect detection is unavailable
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index d5d493719491..f2585b6c1414 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -72,6 +72,9 @@ static const struct of_device_id sh_mobile_sdhi_of_match[] = {
>         { .compatible = "renesas,sdhi-r8a7779", .data = &of_rcar_gen1_compatible, },
>         { .compatible = "renesas,sdhi-r8a7790", .data = &of_rcar_gen2_compatible, },
>         { .compatible = "renesas,sdhi-r8a7791", .data = &of_rcar_gen2_compatible, },
> +       { .compatible = "renesas,sdhi-r8a7792", .data = &of_rcar_gen2_compatible, },
> +       { .compatible = "renesas,sdhi-r8a7793", .data = &of_rcar_gen2_compatible, },
> +       { .compatible = "renesas,sdhi-r8a7794", .data = &of_rcar_gen2_compatible, },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
> --
> 1.9.1
>
