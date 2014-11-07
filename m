From: Simon Horman <horms@verge.net.au>
Date: Fri, 07 Nov 2014 04:17:57 +0000
Subject: Re: [PATCH 3/5] i2c: sh_mobile: Document SoC-specific bindings
Message-Id: <20141107041756.GD2006@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1415274730-310-1-git-send-email-geert+renesas@glider.be>
 <1415274730-310-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415274730-310-4-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, Nov 06, 2014 at 12:52:08PM +0100, Geert Uytterhoeven wrote:
> Explicitly list the various SoC-specific compatible properties.
> This allows checkpatch to validate DTSes.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
> index d2153ce36fa81404..c33e9a32d496ef10 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-sh_mobile.txt
> @@ -2,6 +2,15 @@ Device tree configuration for Renesas IIC (sh_mobile) driver
>  
>  Required properties:
>  - compatible      : "renesas,iic-<soctype>". "renesas,rmobile-iic" as fallback
> +		     Examples with soctypes are:
> +			- "renesas,iic-r8a73a4" (R-Mobile APE6)
> +			- "renesas,iic-r8a7740" (R-Mobile A1)
> +			- "renesas,iic-r8a7790" (R-Car H2)
> +			- "renesas,iic-r8a7791" (R-Car M2-W)
> +			- "renesas,iic-r8a7792" (R-Car V2H)
> +			- "renesas,iic-r8a7793" (R-Car M2-N)
> +			- "renesas,iic-r8a7794" (R-Car E2)
> +			- "renesas,iic-sh73a0" (SH-Mobile AG5)
>  - reg             : address start and address range size of device
>  - interrupts      : interrupt of device
>  - clocks          : clock for device
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
