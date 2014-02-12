From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 12 Feb 2014 19:55:39 +0000
Subject: Re: [PATCH 2/5] ARM: shmobile: r8a7790: add dmac0 dmac1 nodes
Message-Id: <52FBDFC9.8030705@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1375892397-5822-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1375892397-5822-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 02/12/2014 08:59 PM, Ben Dooks wrote:

    No signoff but that's again intentional?

> ---
>   arch/arm/boot/dts/r8a7790.dtsi | 89 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 89 insertions(+)

> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 700e0a1..ae65270 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
[...]
> @@ -79,6 +80,94 @@
>   		};
>   	};
>
> +#define CHCR_RX_32BIT	SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_32BIT)
> +#define CHCR_TX_32BIT	SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_32BIT)
> +#define CHCR_RX_256BIT	SHDMA_ARM_CHCR_RX(SHDMA_ARM_SZ_256BIT)
> +#define CHCR_TX_256BIT	SHDMA_ARM_CHCR_TX(SHDMA_ARM_SZ_256BIT)
> +
> +	dma0: dma-mux@0 {
> +		compatible = "renesas,shdma-mux";
> +		#dma-cells = <1>;
> +		dma-channels = <20>;
> +                dma-requests = <256>;
> +                #address-cells = <2>;
> +                #size-cells = <2>;
> +                ranges;

    The above 4 lines are indented with spaces instead of tabs.

WBR, Sergei

