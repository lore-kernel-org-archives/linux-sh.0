From: Rob Herring <robh@kernel.org>
Date: Thu, 12 Nov 2015 23:28:05 +0000
Subject: Re: [PATCH] dmaengine: rcar-dmac: Document SoC specific bindings
Message-Id: <20151112232805.GA5562@rob-hp-laptop>
List-Id: <linux-sh.vger.kernel.org>
References: <1447293239-8554-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1447293239-8554-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

On Thu, Nov 12, 2015 at 10:53:59AM +0900, Simon Horman wrote:
> In general Renesas hardware is not documented to the extent where the
> relationship between IP blocks on different SoCs can be assumed although
> they may appear to operate the same way. Furthermore the documentation
> typically does not specify a version for individual IP blocks. For these
> reasons a convention of using the SoC name in place of a version and
> providing SoC-specific compat strings has been adopted.

Everyone learns this the hard way. :)

> Although not universally liked this convention is used in the bindings for
> most drivers for Renesas hardware. The purpose of this patch is to
> update the Renesas R-Car DMA Controller driver to follow this convention.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> Once this has been merged I intend to provide follow-up patches
> to use these new compat strings in the relevant dtsi files.
> 
> diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> index 09daeef1ff22..5b902ac8d97e 100644
> --- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> +++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
> @@ -14,7 +14,14 @@ not described in these device tree bindings.
>  
>  Required Properties:
>  
> -- compatible: must contain "renesas,rcar-dmac"
> +- compatible: "renesas,dmac-<soctype>", "renesas,rcar-dmac" as fallback.

Somehow Renesas has ended up being backwards from everyone else that 
does <vendor>,<chip>-<block>. Oh well...

Acked-by: Rob Herring <robh@kernel.org>

Rob
