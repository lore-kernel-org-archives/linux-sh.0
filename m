From: Simon Horman <horms@verge.net.au>
Date: Mon, 25 May 2015 01:17:10 +0000
Subject: Re: [RFC 1/3] ARM: shmobile: rcar-gen2: Add generic "renesas,rcar-gen2" machine
Message-Id: <20150525011710.GH24690@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1432205413-9584-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1432205413-9584-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Thu, May 21, 2015 at 12:50:11PM +0200, Ulrich Hecht wrote:
> This will do for all Gen2 SoCs that do not need SoC-specific setup.

From my point of view the qualification above implies there is
a problem with this approach.

> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt |  8 ++++++--
>  arch/arm/mach-shmobile/setup-rcar-gen2.c           | 13 +++++++++++++
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
> index c4f19b2..29886ab 100644
> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -27,12 +27,16 @@ SoCs:
>      compatible = "renesas,r8a7793"
>    - R-Car E2 (R8A77940)
>      compatible = "renesas,r8a7794"
> +  - R-Car Gen2 (Generic R-Car Generation 2 SoC)
> +    This applies to Generation 2 R-Car SoCs that do not require SoC-specific
> +    setup code.
> +    compatible = "renesas,rcar-gen2"
>  
>  
>  Boards:
>  
>    - Alt
> -    compatible = "renesas,alt", "renesas,r8a7794"
> +    compatible = "renesas,alt", "renesas,r8a7794", "renesas,rcar-gen2"
>    - APE6-EVM
>      compatible = "renesas,ape6evm", "renesas,r8a73a4"
>    - Atmark Techno Armadillo-800 EVA
> @@ -44,7 +48,7 @@ Boards:
>    - Genmai (RTK772100BC00000BR)
>      compatible = "renesas,genmai", "renesas,r7s72100"
>    - Gose
> -    compatible = "renesas,gose", "renesas,r8a7793"
> +    compatible = "renesas,gose", "renesas,r8a7793", "renesas,rcar-gen2"
>    - Henninger
>      compatible = "renesas,henninger", "renesas,r8a7791"
>    - Koelsch (RTP0RC7791SEB00010S)
> diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
> index 5d13595..0f6b48b 100644
> --- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
> +++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
> @@ -201,3 +201,16 @@ void __init rcar_gen2_reserve(void)
>  					    &rcar_gen2_dma_contiguous, true);
>  #endif
>  }
> +
> +static const char *rcar_gen2_boards_compat_dt[] __initconst = {
> +	"renesas,rcar-gen2",
> +	NULL,
> +};

I would rather not have renesas,rcar-gen2 above and rather have
each SoC that this covers listed above.

> +
> +DT_MACHINE_START(RCAR_GEN2_DT, "Generic R-Car Gen2 (Flattened Device Tree)")
> +	.init_early	= shmobile_init_delay,
> +	.init_time	= rcar_gen2_timer_init,
> +	.init_late	= shmobile_init_late,
> +	.reserve	= rcar_gen2_reserve,
> +	.dt_compat	= rcar_gen2_boards_compat_dt,
> +MACHINE_END
> -- 
> 2.3.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
