From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 06 Aug 2015 00:34:05 +0000
Subject: Re: [RFT 1/2] i2c: rcar: add support for r8a7795 (R-Car H3)
Message-Id: <4463128.lAKghhIhbx@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1438780706-20945-1-git-send-email-wsa@the-dreams.de> <1438780706-20945-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1438780706-20945-2-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>

Hi Wolfram,

Thank you for the patch.

On Wednesday 05 August 2015 15:18:25 Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Enable the I2C core for this SoC. I add a new type because this version
> has new features (e.g. DMA) which will be added somewhen later.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-rcar.txt | 1 +
>  drivers/i2c/busses/i2c-rcar.c                      | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt index
> 16b3e07aa98fdd..ea406eb20fa5ad 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-rcar.txt
> @@ -10,6 +10,7 @@ Required properties:
>  	"renesas,i2c-r8a7792"
>  	"renesas,i2c-r8a7793"
>  	"renesas,i2c-r8a7794"
> +	"renesas,i2c-r8a7795"
>  - reg: physical base address of the controller and length of memory mapped
>    region.
>  - interrupts: interrupt specifier.
> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index d8361dada58455..3e125654bb288a 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -103,6 +103,7 @@
>  enum rcar_i2c_type {
>  	I2C_RCAR_GEN1,
>  	I2C_RCAR_GEN2,
> +	I2C_RCAR_GEN3,
>  };
> 
>  struct rcar_i2c_priv {
> @@ -178,6 +179,7 @@ static int rcar_i2c_clock_calculate(struct rcar_i2c_priv
> *priv, cdf_width = 2;
>  		break;
>  	case I2C_RCAR_GEN2:
> +	case I2C_RCAR_GEN3:
>  		cdf_width = 3;
>  		break;
>  	default:
> @@ -625,6 +627,7 @@ static const struct of_device_id rcar_i2c_dt_ids[] = {
>  	{ .compatible = "renesas,i2c-r8a7792", .data = (void *)I2C_RCAR_GEN2 },
>  	{ .compatible = "renesas,i2c-r8a7793", .data = (void *)I2C_RCAR_GEN2 },
>  	{ .compatible = "renesas,i2c-r8a7794", .data = (void *)I2C_RCAR_GEN2 },
> +	{ .compatible = "renesas,i2c-r8a7795", .data = (void *)I2C_RCAR_GEN3 },

If H3 is compatible with Gen2, can't you just use I2C_RCAR_GEN2 here ? You can 
always add I2C_RCAR_GEN3 later if you find differences.

>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, rcar_i2c_dt_ids);

-- 
Regards,

Laurent Pinchart

