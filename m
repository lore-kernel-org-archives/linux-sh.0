From: Simon Horman <horms@verge.net.au>
Date: Tue, 05 Mar 2013 05:31:04 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7779: add Thermal support on DT
Message-Id: <20130305053102.GB22698@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87mwujpnub.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mwujpnub.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 04, 2013 at 12:32:16AM -0800, Kuninori Morimoto wrote:
> 76cc1887496fe80138c6b07c37d7f81e4cf27cde
> (thermal: rcar: add Device Tree support)
> supported rcar_thermal DT probing.
> 
> rcar thermal driver doesn't support IRQ on r8a7779 chip
> since it is using old design IRQ.
> R-Car/R-Mobile next generation chips are using new design IRQ,
> and rcar thermal driver is supporting these.
> 
> This patch adds rcar_thermal DT support for r8a7779 without IRQ.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
> >> Simon
> 
> This patch needs rzhang/next branch + simon/next branch
> 
> http://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git :: next
> 
>  arch/arm/boot/dts/r8a7779.dtsi |    5 +++++
>  1 file changed, 5 insertions(+)

Thanks, applied to the soc5 branch of the renesas tree
and thus included in its next branch and queued up for v3.10.

> 
> diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
> index 0016302..60f06f9 100644
> --- a/arch/arm/boot/dts/r8a7779.dtsi
> +++ b/arch/arm/boot/dts/r8a7779.dtsi
> @@ -83,4 +83,9 @@
>  		interrupt-parent = <&gic>;
>  		interrupts = <0 81 0x4>;
>  	};
> +
> +	thermal@ffc48000 {
> +		compatible = "renesas,rcar-thermal";
> +		reg = <0xffc48000 0x38>;
> +	};
>  };
> -- 
> 1.7.9.5
> 
