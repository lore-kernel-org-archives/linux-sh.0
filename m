From: Simon Horman <horms@verge.net.au>
Date: Wed, 22 Jul 2015 00:38:52 +0000
Subject: Re: [PATCH v2] gpio: rcar: Add r8a7795 (R-Car H3) support
Message-Id: <20150722003852.GC25644@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1437469730-16460-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1437469730-16460-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 21, 2015 at 11:08:50AM +0200, Ulrich Hecht wrote:
> R-Car Gen3's GPIO blocks are identical to Gen2's in every respect.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
> This still recycles the Gen2 structure, but explains why.  That seems
> better to me than having the same data twice.
> 
> Changes since v1:
> - added comment explaining the use of Gen2 info on Gen3

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> 
> 
>  Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt | 1 +
>  drivers/gpio/gpio-rcar.c                                     | 4 ++++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
> index 38fb86f..f60e2f4 100644
> --- a/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
> +++ b/Documentation/devicetree/bindings/gpio/renesas,gpio-rcar.txt
> @@ -9,6 +9,7 @@ Required Properties:
>      - "renesas,gpio-r8a7791": for R8A7791 (R-Car M2-W) compatible GPIO controller.
>      - "renesas,gpio-r8a7793": for R8A7793 (R-Car M2-N) compatible GPIO controller.
>      - "renesas,gpio-r8a7794": for R8A7794 (R-Car E2) compatible GPIO controller.
> +    - "renesas,gpio-r8a7795": for R8A7795 (R-Car H3) compatible GPIO controller.
>      - "renesas,gpio-rcar": for generic R-Car GPIO controller.
>  
>    - reg: Base address and length of each memory resource used by the GPIO
> diff --git a/drivers/gpio/gpio-rcar.c b/drivers/gpio/gpio-rcar.c
> index 1e14a6c..ed35348 100644
> --- a/drivers/gpio/gpio-rcar.c
> +++ b/drivers/gpio/gpio-rcar.c
> @@ -327,6 +327,10 @@ static const struct of_device_id gpio_rcar_of_table[] = {
>  		.compatible = "renesas,gpio-r8a7794",
>  		.data = &gpio_rcar_info_gen2,
>  	}, {
> +		.compatible = "renesas,gpio-r8a7795",
> +		/* Gen3 GPIO is identical to Gen2. */
> +		.data = &gpio_rcar_info_gen2,
> +	}, {
>  		.compatible = "renesas,gpio-rcar",
>  		.data = &gpio_rcar_info_gen1,
>  	}, {
> -- 
> 2.4.2
> 
