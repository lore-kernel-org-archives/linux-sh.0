From: Mark Rutland <mark.rutland@arm.com>
Date: Wed, 25 May 2016 10:33:50 +0000
Subject: Re: [PATCH v3 12/12] sh: add device tree source for J2 FPGA on Mimas v2  board
Message-Id: <20160525103349.GH1337@leverpostej>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1464148904.git.dalias@libc.org>
 <3d6f6fd6d674942a6446b0a14d9877017c53eb2f.1464148904.git.dalias@libc.org>
In-Reply-To: <3d6f6fd6d674942a6446b0a14d9877017c53eb2f.1464148904.git.dalias-8zAoT0mYgF4@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rich Felker <dalias-8zAoT0mYgF4@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Yoshinori Sato <ysato-Rn4VEauK+AKRv+LV9MX5uooqe+aC9MnS@public.gmane.org>

On Wed, May 25, 2016 at 05:43:03AM +0000, Rich Felker wrote:
> Signed-off-by: Rich Felker <dalias@libc.org>
> ---
>  arch/sh/boot/dts/j2_mimas_v2.dts | 87 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100755 arch/sh/boot/dts/j2_mimas_v2.dts
> 
> diff --git a/arch/sh/boot/dts/j2_mimas_v2.dts b/arch/sh/boot/dts/j2_mimas_v2.dts
> new file mode 100755
> index 0000000..4a66cda
> --- /dev/null
> +++ b/arch/sh/boot/dts/j2_mimas_v2.dts
> @@ -0,0 +1,87 @@
> +/dts-v1/;
> +
> +/ {
> +	compatible = "jcore,j2-soc";
> +	model = "J2 FPGA SoC on Mimas v2 board";
> +
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +
> +	interrupt-parent = <&aic>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu@0 {
> +			device_type = "cpu";
> +			compatible = "jcore,j2";
> +			reg = < 0 >;
> +			clock-frequency = < 50000000 >;

Nit: please remove the spacing around the '<' and '>' here. If nothing
else, it's inconsistent with the rest of this file.

> +		};
> +	};
> +
> +	memory@10000000 {
> +		device_type = "memory";
> +		reg = < 0x10000000 0x4000000 >;
> +	};

Likewise.

> +
> +	chosen {
> +		stdout-path = "/soc@abcd0000/serial@100";
> +	};

Please use a label for the serial node, have an alias, and describe the
pre-configured rate per the stdout-path binding, e.g.


	aliases {
		serial0 = &uart0;
	};
	
	chosen {
		stdout-path = "serial0:19200n8";
	};

	...

	soc@abcd0000 {
		...
		uart0: serial@100 {
			...
		};
	};

Note that using stdout-path is preferable to current-speed or other
UART-specific bindings.

Thanks,
Mark.

> +
> +	soc@abcd0000 {
> +		compatible = "simple-bus";
> +		ranges = <0 0xabcd0000 0x100000>;
> +
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		aic: interrupt-controller@200 {
> +			compatible = "jcore,aic1";
> +			reg = < 0x200 0x10 >;
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +		};
> +
> +		cache-controller@c0 {
> +			compatible = "jcore,cache";
> +			reg = < 0xc0 4 >;
> +		};
> +
> +		timer@200 {
> +			compatible = "jcore,pit";
> +			reg = < 0x200 0x30 >;
> +			interrupts = < 0x48 >;
> +		};
> +
> +		spi@40 {
> +			compatible = "jcore,spi2";
> +
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			spi-max-frequency = <12500000>;
> +
> +			reg = < 0x40 0x8 >;
> +
> +			sdcard@0 {
> +				compatible = "mmc-spi-slot";
> +				reg = <0>;
> +				spi-max-frequency = <12500000>;
> +				voltage-ranges = <3200 3400>;
> +				mode = <0>;
> +			};
> +		};
> +
> +		serial@100 {
> +			clock-frequency = <125000000>;
> +			compatible = "xlnx,xps-uartlite-1.00.a";
> +			current-speed = <19200>;
> +			device_type = "serial";
> +			interrupts = < 0x12 >;
> +			port-number = <0>;
> +			reg = < 0x100 0x10 >;
> +		};
> +	};
> +};
> -- 
> 2.8.1
> 
