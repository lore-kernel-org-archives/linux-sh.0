From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sat, 23 May 2015 18:02:51 +0000
Subject: Re: [RFC 1/3] ARM: shmobile: rcar-gen2: Add generic "renesas,rcar-gen2" machine
Message-Id: <1669777.QAc6A4lD2q@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1432205413-9584-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1432205413-9584-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Thursday 21 May 2015 12:50:11 Ulrich Hecht wrote:
> This will do for all Gen2 SoCs that do not need SoC-specific setup.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt |  8 ++++++--
>  arch/arm/mach-shmobile/setup-rcar-gen2.c           | 13 +++++++++++++
>  2 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt
> b/Documentation/devicetree/bindings/arm/shmobile.txt index c4f19b2..29886ab
> 100644
> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -27,12 +27,16 @@ SoCs:
>      compatible = "renesas,r8a7793"
>    - R-Car E2 (R8A77940)
>      compatible = "renesas,r8a7794"
> +  - R-Car Gen2 (Generic R-Car Generation 2 SoC)
> +    This applies to Generation 2 R-Car SoCs that do not require
> SoC-specific
> +    setup code.

I don't think we should mention code in the DT bindings documentation. 
Furthermore, I think we should target support for all Gen2 SoCs, as the only 
difference between the setup-r8a779*.c files is the SMP ops. This will just 
require adding the enable-method DT properties for SMP to all our Gen2 device 
trees.

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
> diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c
> b/arch/arm/mach-shmobile/setup-rcar-gen2.c index 5d13595..0f6b48b 100644
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
> +
> +DT_MACHINE_START(RCAR_GEN2_DT, "Generic R-Car Gen2 (Flattened Device
> Tree)")
> +	.init_early	= shmobile_init_delay,
> +	.init_time	= rcar_gen2_timer_init,
> +	.init_late	= shmobile_init_late,
> +	.reserve	= rcar_gen2_reserve,
> +	.dt_compat	= rcar_gen2_boards_compat_dt,
> +MACHINE_END

-- 
Regards,

Laurent Pinchart
