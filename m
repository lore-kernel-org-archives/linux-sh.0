From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 23 Jul 2014 12:33:24 +0000
Subject: Re: [PATCH 02/11][RFC] ARM: shmobile: r8a7790: Add Audio DMAC peri peri devices to DT
Message-Id: <53CFAB94.20508@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <871ttcvlpl.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <871ttcvlpl.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 07/23/2014 06:43 AM, Kuninori Morimoto wrote:

> Instantiate the Audio DMAC peri peri controllers
> in the r8a7790 device tree.

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>   arch/arm/boot/dts/r8a7790.dtsi |    7 +++++++
>   1 file changed, 7 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 9f4fb9c..853a5d1 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -333,6 +333,13 @@
>   		dma-channels = <13>;
>   	};
>
> +	audmapp: audio-dma-pp@0xec740000 {

    As per the ePAPR standard, the node name must be "dma-controller". Also, 
please drop "0x" from the unit-address part of the name.

> +		compatible = "renesas,rcar-audmapp";
> +		#dma-cells = <1>;
> +
> +		reg = <0 0xec740000 0 0x200>;
> +	};
> +

WBR, Sergei

