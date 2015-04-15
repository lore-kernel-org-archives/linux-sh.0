From: Simon Horman <horms@verge.net.au>
Date: Wed, 15 Apr 2015 00:35:57 +0000
Subject: Re: [PATCH] thermal: rcar: Fix typo in r8a73a4 SoC name
Message-Id: <20150415003550.GA4998@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1426704161-26617-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1426704161-26617-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org

On Wed, Mar 18, 2015 at 07:42:41PM +0100, Geert Uytterhoeven wrote:
> r8a73a4 is R-Mobile APE6, not AP6.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/thermal/rcar-thermal.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> index 43404b1979332628..332e625f6ed01cb4 100644
> --- a/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/rcar-thermal.txt
> @@ -4,7 +4,7 @@ Required properties:
>  - compatible		: "renesas,thermal-<soctype>", "renesas,rcar-thermal"
>  			  as fallback.
>  			  Examples with soctypes are:
> -			    - "renesas,thermal-r8a73a4" (R-Mobile AP6)
> +			    - "renesas,thermal-r8a73a4" (R-Mobile APE6)
>  			    - "renesas,thermal-r8a7779" (R-Car H1)
>  			    - "renesas,thermal-r8a7790" (R-Car H2)
>  			    - "renesas,thermal-r8a7791" (R-Car M2-W)
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
