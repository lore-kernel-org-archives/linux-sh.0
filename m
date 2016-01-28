From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 28 Jan 2016 20:38:15 +0000
Subject: Re: [PATCH 2/3] ARM: shmobile: r8a7791: add MSTP10 support on DTSI
Message-Id: <56AA7C37.7030506@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387998730-6012-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387998730-6012-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 06/12/2014 08:44 AM, Kuninori Morimoto wrote:

    Sorry for digging out the ancient patch...

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   arch/arm/boot/dts/r8a7791.dtsi            |   33 +++++++++++++++++++++++++++++
>   include/dt-bindings/clock/r8a7791-clock.h |   26 +++++++++++++++++++++++
>   2 files changed, 59 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> index f3b6219..380d058 100644
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -865,6 +865,39 @@
>   				"rcan1", "rcan0", "qspi_mod", "i2c5", "i2c6", "i2c4", "i2c3", "i2c2",
>   				"i2c1", "i2c0";
>   		};
> +		mstp10_clks: mstp10_clks@e6150998 {
> +			compatible = "renesas,r8a7791-mstp-clocks", "renesas,cpg-mstp-clocks";
> +			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
> +			clocks = <&p_clk>,
> +				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,
> +				<&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>, <&p_clk>,

    But don't SSI[0-9] clocks all depend on SSI(all)? Shouldn't the above 10 
entries be
<&mstp10_clks R8A7791_CLK_SSI_ALL> like it was done to SCU(all)?

> +				<&p_clk>,
> +				<&mstp10_clks R8A7791_CLK_SCU_ALL>, <&mstp10_clks R8A7791_CLK_SCU_ALL>,
> +				<&mstp10_clks R8A7791_CLK_SCU_ALL>, <&mstp10_clks R8A7791_CLK_SCU_ALL>,
> +				<&mstp10_clks R8A7791_CLK_SCU_ALL>, <&mstp10_clks R8A7791_CLK_SCU_ALL>,
> +				<&mstp10_clks R8A7791_CLK_SCU_ALL>, <&mstp10_clks R8A7791_CLK_SCU_ALL>,
> +				<&mstp10_clks R8A7791_CLK_SCU_ALL>, <&mstp10_clks R8A7791_CLK_SCU_ALL>,
> +				<&mstp10_clks R8A7791_CLK_SCU_ALL>, <&mstp10_clks R8A7791_CLK_SCU_ALL>;

MBR, Sergei

