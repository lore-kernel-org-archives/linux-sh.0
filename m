From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 27 Aug 2015 00:43:58 +0000
Subject: Re: [PATCH 1/6] arm64: renesas: r8a7795 dtsi: Mark scif2 disabled
Message-Id: <87zj1dd0nq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1440612832-17627-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1440612832-17627-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Geert

> It's enabled by the board-specific .dts.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index f3c30bd51d9a063d..e9ecdf5a136837b3 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -283,6 +283,7 @@
>  			clocks = <&mstp3_clks R8A7795_CLK_SCIF2>;
>  			clock-names = "sci_ick";
>  			power-domains = <&cpg_clocks>;
> +			status = "disabled";
>  		};

It will be fixed in my next v8 patch-set
