From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 24 Dec 2013 15:45:03 +0000
Subject: Re: [PATCH 6/6] [RFC] arm: shmobile: genmai reference: Add RSPI nodes
Message-Id: <52B9ABFF.90902@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387886210-3634-1-git-send-email-geert+renesas@linux-m68k.org>
 <1387886210-3634-7-git-send-email-geert+renesas@linux-m68k.org>
In-Reply-To: <1387886210-3634-7-git-send-email-geert+renesas@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hello.

On 24-12-2013 15:56, Geert Uytterhoeven wrote:

> Add pinctrl and SPI devices for RSPI on Genmai.

> On this board, only rspi4 is in use. It's bus contains a single device
> (a wm8978 audio codec), for which no bindings are defined yet.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> Cc: devicetree@vger.kernel.org
> ---
>   arch/arm/boot/dts/r7s72100-genmai-reference.dts |   18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)

> diff --git a/arch/arm/boot/dts/r7s72100-genmai-reference.dts b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
> index 114510f8bf09..6d99630627e4 100644
> --- a/arch/arm/boot/dts/r7s72100-genmai-reference.dts
> +++ b/arch/arm/boot/dts/r7s72100-genmai-reference.dts
[...]
> @@ -85,3 +91,13 @@
>   		pagesize = <64>;
>   	};
>   };
> +
> +&spi4 {
> +	status = "okay";
> +
> +	codec: wm8978@0 {

    Do not give chip names to device nodes, please use somewhat generic names 
instead, like "sound-codec@0". That's to comply with ePAPR spec.

> +		compatible = "wlf,wm8978";
> +		reg = <0>;
> +		spi-max-frequency = <5000000>;
> +	};
> +};

WBR, Sergei


