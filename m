From: Simon Horman <horms@verge.net.au>
Date: Thu, 05 Dec 2013 05:09:08 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: r8a7740: add FSI support via DTSI
Message-Id: <20131205050906.GE12774@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87y541z9o9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y541z9o9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 03, 2013 at 05:28:41PM -0800, Kuninori Morimoto wrote:
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  arch/arm/boot/dts/r8a7740.dtsi |    9 +++++++++
>  1 file changed, 9 insertions(+)

Thanks, I will queue this up.

> 
> diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
> index b1c2ed9..52255bf 100644
> --- a/arch/arm/boot/dts/r8a7740.dtsi
> +++ b/arch/arm/boot/dts/r8a7740.dtsi
> @@ -208,4 +208,13 @@
>  		cap-sdio-irq;
>  		status = "disabled";
>  	};
> +
> +	sh_fsi2: sound@fe1f0000 {
> +		#sound-dai-cells = <1>;
> +		compatible = "renesas,sh_fsi2";
> +		reg = <0xfe1f0000 0x400>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 9 0x4>;
> +		status = "disabled";
> +	};
>  };
> -- 
> 1.7.9.5
> 
