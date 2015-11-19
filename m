From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 19 Nov 2015 11:32:51 +0000
Subject: Re: [PATCH] mmc: sh_mmcif: Document r8a7793 DT bindings
Message-Id: <CAPDyKFqcxQtE=d=kGVgf5KLbCss7r9CuFv0d+GB-dR9Rgvm53Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1445964991-7825-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1445964991-7825-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

On 27 October 2015 at 17:56, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>
> [geert: Rebased]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/renesas,mmcif.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> index cae29eb5733d8a52..ff611fa66871dec9 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> +++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> @@ -11,6 +11,7 @@ Required properties:
>         - "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
>         - "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
>         - "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
> +       - "renesas,mmcif-r8a7793" for the MMCIF found in r8a7793 SoCs
>         - "renesas,mmcif-r8a7794" for the MMCIF found in r8a7794 SoCs
>
>  - clocks: reference to the functional clock
> --
> 1.9.1
>
