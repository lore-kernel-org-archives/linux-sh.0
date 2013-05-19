From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 19 May 2013 23:04:18 +0000
Subject: Re: [PATCH 5/9] ARM: shmobile: APE6EVM: add DT pinctrl definitions for a serial interface
Message-Id: <1748847.0N915vQQJ1@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1368802520-16378-6-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1368802520-16378-6-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

Thank you for the patch.

On Friday 17 May 2013 16:55:16 Guennadi Liakhovetski wrote:
> Add DT pinctrl group and function definitions for the serial device, used
> as a serial console on APE6EVM.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/r8a73a4-ape6evm.dts |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> b/arch/arm/boot/dts/r8a73a4-ape6evm.dts index 4fb0102..b5b24eb 100644
> --- a/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> +++ b/arch/arm/boot/dts/r8a73a4-ape6evm.dts
> @@ -52,3 +52,13 @@
>  		};
>  	};
>  };
> +
> +&pfc {
> +	pinctrl-0 = <&scifa0_pins>;
> +	pinctrl-names = "default";
> +
> +	scifa0_pins: scifa0 {
> +		renesas,groups = "scifa0_data";
> +		renesas,function = "scifa0";
> +	};
> +};
-- 
Regards,

Laurent Pinchart

