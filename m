From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 18 Sep 2015 13:00:02 +0000
Subject: Re: [PATCH/RFC v3 1/5] arm64: dts: r8a7795: add clock for EthernetAVB
Message-Id: <55FC0AD2.5000807@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1442556314-10512-2-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1442556314-10512-2-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 9/18/2015 9:05 AM, Simon Horman wrote:

> From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
>
> These clocks will be used by EthernetAVB
>
> Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> [horms: use s3d2_clk; other minor updates]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

[...]

> diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> index d7e70f57d165..60d64c51b510 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -274,6 +274,17 @@
>   					#clock-cells = <1>;
>   					clock-indices = <R8A7795_CLK_SCIF2>;
>   				};
> +
> +				mstp8_clks: mstp8_clks@e6150990 {
> +					compatible = "renesas,r8a7795-mstp-clocks",
> +						     "renesas,cpg-mstp-clocks";
> +					reg = <0 0xe6150990 0 4>, <0 0xe61509a0 0 4>;
> +					clocks =  <&s3d2_clk>;
> +					#clock-cells = <1>;
> +					clock-indices = <R8A7795_CLK_ETHERAVB>;
> +					clock-output-names = "etheravb";
> +				};
> +

    This empty line is hardly needed.

>   			};
>   		};
>
> @@ -364,4 +375,5 @@
>   			status = "disabled";
>   		};
>   	};
> +

   And this too.

>   };

MBR, Sergei

