From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 20 Aug 2015 23:48:36 +0000
Subject: Re: [PATCH 07/17 v6][RFC] arm64: renesas: r8a7795: Add initial SoC support
Message-Id: <87io89bk3x.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1yib9gk.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d1yib9gk.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

> +/ {
> +	compatible = "renesas,r8a7795";
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* 1core only at this point */
> +		a57_0: cpu@0 {
> +			compatible = "arm,cortex-a57", "arm,armv8";
> +			reg = <0x0>;
> +			device_type = "cpu";
> +		};
> +	};
> +
> +	extal_clk: extal_clk {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <0>;
> +	};
> +
> +	cpg {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		#clock-cells = <1>;
> +		ranges;

I misunderstood that "cpg" should be under root.
It will goes to under "soc" again in v7.

