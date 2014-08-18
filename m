From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Aug 2014 23:45:42 +0000
Subject: Re: [PATCH 8/8] ARM: shmobile: r8a7794: document CPG clock support
Message-Id: <20140818234541.GI1623@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1408377107-3822-9-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1408377107-3822-9-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 18, 2014 at 05:51:47PM +0200, Ulrich Hecht wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Simon Horman <horms@verge.net.au>

Mike, please consider taking this patch.

Ulrich, this and the other bindings patches seem to be loose dependencies for
"[PATCH 4/8] ARM: shmobile: Initial r8a7794 and Alt device tree". If you
repost these patches please consider either:

1. Posting them as stand-alone patches as they have different maintainers
   to the shmobile patches. And making reference to the dependency in
   the cover-letter of the shmobile patches or;
2. Re-ordering the patchset

FWIW, I prefer 1.

> diff --git a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
> index 7b41c2f..e6ad35b 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt
> @@ -8,6 +8,7 @@ Required Properties:
>    - compatible: Must be one of
>      - "renesas,r8a7790-cpg-clocks" for the r8a7790 CPG
>      - "renesas,r8a7791-cpg-clocks" for the r8a7791 CPG
> +    - "renesas,r8a7794-cpg-clocks" for the r8a7794 CPG
>      - "renesas,rcar-gen2-cpg-clocks" for the generic R-Car Gen2 CPG
>  
>    - reg: Base address and length of the memory resource used by the CPG
> -- 
> 1.8.4.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
