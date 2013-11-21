From: Simon Horman <horms@verge.net.au>
Date: Thu, 21 Nov 2013 04:04:18 +0000
Subject: Re: [PATCH] ARM: shmobile: Configure r8a7791 PFC on Koelsch via DTS
Message-Id: <20131121040416.GH31130@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131120073659.22718.79556.sendpatchset@w520>
In-Reply-To: <20131120073659.22718.79556.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Nov 20, 2013 at 04:36:59PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Configure the "D" set of data signals for SCIF0 and SCIF1
> on the Koelsch board to setup pinctrl serial console bits.
> 
  Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I will queue this up after removing the trailing blank line that
this patch introduces.  Assuming all goes will I plan to push this and
other updates today or tomorrow.

> ---
> 
>  arch/arm/boot/dts/r8a7791-koelsch-reference.dts |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> --- 0001/arch/arm/boot/dts/r8a7791-koelsch-reference.dts
> +++ work/arch/arm/boot/dts/r8a7791-koelsch-reference.dts	2013-11-20 16:23:06.000000000 +0900
> @@ -30,3 +30,19 @@
>  		#size-cells = <1>;
>  	};
>  };
> +
> +&pfc {
> +	pinctrl-0 = <&scif0_pins &scif1_pins>;
> +	pinctrl-names = "default";
> +
> +	scif0_pins: serial0 {
> +		renesas,groups = "scif0_data_d";
> +		renesas,function = "scif0";
> +	};
> +
> +	scif1_pins: serial1 {
> +		renesas,groups = "scif1_data_d";
> +		renesas,function = "scif1";
> +	};
> +};
> +
> 
