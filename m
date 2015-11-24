From: Rob Herring <robh@kernel.org>
Date: Tue, 24 Nov 2015 20:16:55 +0000
Subject: Re: [PATCH] dmaengine: usb-dmac: Document SoC specific bindings
Message-Id: <20151124201655.GA23437@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1448331641-21758-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1448331641-21758-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

On Tue, Nov 24, 2015 at 11:20:41AM +0900, Simon Horman wrote:
> In general Renesas hardware is not documented to the extent where the
> relationship between IP blocks on different SoCs can be assumed although
> they may appear to operate the same way. Furthermore the documentation
> typically does not specify a version for individual IP blocks. For these
> reasons a convention of using the SoC name in place of a version and
> providing SoC-specific compat strings has been adopted.
> 
> Although not universally liked this convention is used in the bindings for
> most drivers for Renesas hardware. The purpose of this patch is to
> update the Renesas USB DMA Controller driver to follow this convention.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> ---
> * r8a7792 (R-Car V2H) is omitted as my reading of the documentation
>   is that Renesas USB-DMAC does not exist on that SoC
> * r8a7795 (R-Car H2) is omitted as its unclear to me on the compatibility
>   of USB-DMAC that SoC
> 
> * Once this has been merged I intend to provide follow-up patches
>   to use these new compat strings in the relevant dtsi files.
> ---
>  Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
> index 040f365954cc..3bb624e10615 100644
> --- a/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
> +++ b/Documentation/devicetree/bindings/dma/renesas,usb-dmac.txt
> @@ -1,7 +1,12 @@
>  * Renesas USB DMA Controller Device Tree bindings
>  
>  Required Properties:
> -- compatible: must contain "renesas,usb-dmac"
> +- compatible: "renesas,usb-dmac-<soctype>", "renesas,usb-dmac" as fallback.
> +	      Examples with soctypes are:
> +		- "renesas,usb-dmac-r8a7790" (R-Car H2)
> +		- "renesas,usb-dmac-r8a7791" (R-Car M2-W)
> +		- "renesas,usb-dmac-r8a7793" (R-Car M2-N)
> +		- "renesas,usb-dmac-r8a7794" (R-Car E2)

Weren't you changing the order of SoC and block names on new bindings? 
Either way:

Acked-by: Rob Herring <robh@kernel.org>

Rob

>  - reg: base address and length of the registers block for the DMAC
>  - interrupts: interrupt specifiers for the DMAC, one for each entry in
>    interrupt-names.
> @@ -15,7 +20,7 @@ Required Properties:
>  Example: R8A7790 (R-Car H2) USB-DMACs
>  
>  	usb_dmac0: dma-controller@e65a0000 {
> -		compatible = "renesas,usb-dmac";
> +		compatible = "renesas,usb-dmac-r8a7790", "renesas,usb-dmac";
>  		reg = <0 0xe65a0000 0 0x100>;
>  		interrupts = <0 109 IRQ_TYPE_LEVEL_HIGH
>  			      0 109 IRQ_TYPE_LEVEL_HIGH>;
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
