From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 07 Jul 2015 17:26:05 +0000
Subject: Re: [PATCH 2/5] i2c: emev2: add binding documentation
Message-Id: <2376548.GgBSKQ3Rxq@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1436219188-4325-1-git-send-email-wsa@the-dreams.de> <1436219188-4325-3-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1436219188-4325-3-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>

Hi Wolfram,

Thank you for the patch.

On Monday 06 July 2015 23:46:06 Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
>  .../devicetree/bindings/i2c/i2c-emev2.txt          | 22 ++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-emev2.txt
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-emev2.txt
> b/Documentation/devicetree/bindings/i2c/i2c-emev2.txt new file mode 100644
> index 00000000000000..a6740066835056
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/i2c/i2c-emev2.txt
> @@ -0,0 +1,22 @@
> +Device tree configuration for Renesas EMEV2 IIC driver

s/driver/controller/

> +
> +Required properties:
> +- compatible      : "renesas,iic-<soctype>". "renesas,iic-emev2" as
> fallback
> +- reg             : address start and address range size of device
> +- interrupts      : 1 interrupt

I'd write this as "specifier for the IIC controller interrupt".

> +- clocks          : phandle to the IP core SCLK

The datasheet mentions PCLK and IIC_SCLK but doesn't provide details. Do you 
have more information ?

> +- clock-names     : must be "sclk"
> +- #address-cells  : should be <1>
> +- #size-cells     : should be <0>
> +
> +Example:
> +
> +	iic0: i2c@e0070000 {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		compatible = "renesas,iic-emev2";
> +		reg = <0xe0070000 0x28>;
> +		interrupts = <0 32 IRQ_TYPE_EDGE_RISING>;
> +		clocks = <&iic0_sclk>;
> +		clock-names = "sclk";
> +	};

-- 
Regards,

Laurent Pinchart

