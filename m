From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Sat, 26 Jul 2014 08:49:29 +0000
Subject: Re: [PATCH 4/6] mmc: sh_mobile_sdhi: Update sh_mobile_sdhi_of_data for r8a7794
Message-Id: <CAPDyKFpRsrJ7ba5SSK=3RC5ET206e=JptO2oco-q9_uPUrCRcg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1406299250-23975-1-git-send-email-ulrich.hecht+renesas@gmail.com>
	<1406299250-23975-5-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1406299250-23975-5-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, Shinobu Uehara <shinobu.uehara.xc@renesas.com>, linux-mmc <linux-mmc@vger.kernel.org>

On 25 July 2014 16:40, Ulrich Hecht <ulrich.hecht+renesas@gmail.com> wrote:
> From: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
>
> This patch adds DT support for r8a7794.
>
> Signed-off-by: Shinobu Uehara <shinobu.uehara.xc@renesas.com>
> [uli: added bindings documentation]
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Cc: linux-mmc@vger.kernel.org

I guess you prefer this goes together with the rest of the patches in
this set, please go ahead.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 2 ++
>  drivers/mmc/host/sh_mobile_sdhi.c                  | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> index 6a2a116..924e516 100644
> --- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> +++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> @@ -18,6 +18,8 @@ Required properties:
>                 "renesas,sdhi-r8a7778" - SDHI IP on R8A7778 SoC
>                 "renesas,sdhi-r8a7779" - SDHI IP on R8A7779 SoC
>                 "renesas,sdhi-r8a7790" - SDHI IP on R8A7790 SoC
> +               "renesas,sdhi-r8a7791" - SDHI IP on R8A7791 SoC
> +               "renesas,sdhi-r8a7794" - SDHI IP on R8A7794 SoC
>
>  Optional properties:
>  - toshiba,mmc-wrprotect-disable: write-protect detection is unavailable
> diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> index 91058da..7591447 100644
> --- a/drivers/mmc/host/sh_mobile_sdhi.c
> +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> @@ -68,6 +68,7 @@ static const struct of_device_id sh_mobile_sdhi_of_match[] = {
>         { .compatible = "renesas,sdhi-r8a7779", .data = &of_rcar_gen1_compatible, },
>         { .compatible = "renesas,sdhi-r8a7790", .data = &of_rcar_gen2_compatible, },
>         { .compatible = "renesas,sdhi-r8a7791", .data = &of_rcar_gen2_compatible, },
> +       { .compatible = "renesas,sdhi-r8a7794", .data = &of_rcar_gen2_compatible, },
>         {},
>  };
>  MODULE_DEVICE_TABLE(of, sh_mobile_sdhi_of_match);
> --
> 1.8.4.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
