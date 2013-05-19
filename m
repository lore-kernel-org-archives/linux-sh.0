From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 19 May 2013 23:06:33 +0000
Subject: Re: [PATCH 6/9] ARM: shmobile: lager: add DT pinctrl definitions for a serial interface
Message-Id: <5613343.4V0P743FVN@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1368802520-16378-7-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1368802520-16378-7-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Guennadi,

Thank you for the patch.

On Friday 17 May 2013 16:55:17 Guennadi Liakhovetski wrote:
> Add DT pinctrl group and function definitions for the serial device, used
> as a serial console on lager.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
>
> ---
>  arch/arm/boot/dts/r8a7790-lager.dts |   10 ++++++++++
>  1 files changed, 10 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts
> b/arch/arm/boot/dts/r8a7790-lager.dts index 09a84fc..986f274 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -29,3 +29,13 @@
>  		#size-cells = <1>;
>  	};
>  };
> +
> +&pfc {
> +	pinctrl-0 = <&scif0_pins>;
> +	pinctrl-names = "default";
> +
> +	scif0_pins: scif0 {
> +		renesas,groups = "scif0_data";
> +		renesas,function = "scif0";
> +	};
> +};

According to the schematics the debug serial port is on scifa0. scif0 works as 
well, as it shares the rx and tx pins with scifa0.

-- 
Regards,

Laurent Pinchart

