From: Simon Horman <horms@verge.net.au>
Date: Sun, 06 Jul 2014 14:30:15 +0000
Subject: Re: [PATCH v6] ARM: shmobile: genmai reference dts: Add RSPI node
Message-Id: <20140706143014.GG3750@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1404388965-4853-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1404388965-4853-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

On Thu, Jul 03, 2014 at 02:02:45PM +0200, Geert Uytterhoeven wrote:
> Add SPI device for RSPI on Genmai.
> 
> On this board, only rspi4 is in use. Its bus contains a single device
> (a wm8978 audio codec), for which no bindings are defined yet.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, I will queue this up.

> ---
> v6:
>   - Rebased on top of renesas-devel-v3.16-rc3-20140701,
>   - Dropped pinctrl settings, as the pinctrl driver is not yet integrated.
> v5:
>   - Rebased on top of renesas-devel-v3.14-rc1-20140204
> v4:
>   - No changes
> v3:
>   - No changes
> v2:
>   - Use generic "codec" instead of specific "wm8978" node name.
> ---
>  arch/arm/boot/dts/r7s72100-genmai.dts |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r7s72100-genmai.dts b/arch/arm/boot/dts/r7s72100-genmai.dts
> index 56849b55e1c2..20705467f4c9 100644
> --- a/arch/arm/boot/dts/r7s72100-genmai.dts
> +++ b/arch/arm/boot/dts/r7s72100-genmai.dts
> @@ -57,3 +57,13 @@
>  &scif2 {
>  	status = "okay";
>  };
> +
> +&spi4 {
> +	status = "okay";
> +
> +	codec: codec@0 {
> +		compatible = "wlf,wm8978";
> +		reg = <0>;
> +		spi-max-frequency = <5000000>;
> +	};
> +};
> -- 
> 1.7.9.5
> 
