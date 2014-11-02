From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 02 Nov 2014 21:47:46 +0000
Subject: Re: [RFC 3/3] ARM: shmobile: r8a7791: add DMA nodes for IIC
Message-Id: <17049901.fYZShuhnQA@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1414752678-26078-1-git-send-email-wsa@the-dreams.de> <1414752678-26078-4-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1414752678-26078-4-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Geert Uytterhoeven <geert@linux-m68k.org>

Hi Wolfram,

Thank you for the patch.

On Friday 31 October 2014 11:51:18 Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/boot/dts/r8a7791.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index 9a57215f54f7..213b6bda6201 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -371,6 +371,8 @@
>  		reg = <0 0xe60b0000 0 0x425>;
>  		interrupts = <0 173 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&mstp9_clks R8A7791_CLK_IICDVFS>;
> +		dmas = <&dmac0 0x77>, <&dmac0 0x78>;
> +		dma-names = "tx", "rx";
>  		status = "disabled";
>  	};
> 
> @@ -381,6 +383,8 @@
>  		reg = <0 0xe6500000 0 0x425>;
>  		interrupts = <0 174 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&mstp3_clks R8A7791_CLK_IIC0>;
> +		dmas = <&dmac0 0x61>, <&dmac0 0x62>;
> +		dma-names = "tx", "rx";
>  		status = "disabled";
>  	};
> 
> @@ -391,6 +395,8 @@
>  		reg = <0 0xe6510000 0 0x425>;
>  		interrupts = <0 175 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&mstp3_clks R8A7791_CLK_IIC1>;
> +		dmas = <&dmac0 0x65>, <&dmac0 0x66>;
> +		dma-names = "tx", "rx";
>  		status = "disabled";
>  	};

-- 
Regards,

Laurent Pinchart

