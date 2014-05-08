From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 08 May 2014 12:59:50 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: r8a7740 dtsi: Add Ethernet support
Message-Id: <536B7FD3.5090506@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1399494750-31996-1-git-send-email-geert+renesas@glider.be> <1399494750-31996-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1399494750-31996-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>
Cc: Bastian Hecht <hechtb+renesas@gmail.com>, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello.

On 05/08/2014 12:32 AM, Geert Uytterhoeven wrote:

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> The "clocks" entry should be uncommented after the conversion to CCF is
> integrated.

>   arch/arm/boot/dts/r8a7740.dtsi |   13 +++++++++++++
>   1 file changed, 13 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
> index 3834b94dc02a..560d8d71cea4 100644
> --- a/arch/arm/boot/dts/r8a7740.dtsi
> +++ b/arch/arm/boot/dts/r8a7740.dtsi
> @@ -122,6 +122,19 @@
>   			      0 149 IRQ_TYPE_LEVEL_HIGH>;
>   	};
>
> +	ether: ethernet@e9a00000 {

    Are you really going to refer to this node somewhere, using its label?

> +		compatible = "renesas,gether-r8a7740";
> +		reg = <0xe9a00000 0x800>,
> +		      <0xe9a01800 0x800>;
> +		interrupt-parent = <&gic>;
> +		interrupts = <0 110 IRQ_TYPE_LEVEL_HIGH>;
> +		/* clocks = <&mstp3_clks R8A7740_CLK_GETHER>; */

    This property is mandatory, according to the bindings.

WBR, Sergei

