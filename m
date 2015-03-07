From: Simon Horman <horms@verge.net.au>
Date: Sat, 07 Mar 2015 00:07:14 +0000
Subject: Re: [PATCH 08/11] mmc: sh_mmcif: Document r8a7793 DT bindings
Message-Id: <20150307000714.GG19866@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-9-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-9-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 06, 2015 at 06:09:55PM +0100, Ulrich Hecht wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/mmc/renesas,mmcif.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> index 299081f..3b9422b 100644
> --- a/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> +++ b/Documentation/devicetree/bindings/mmc/renesas,mmcif.txt
> @@ -10,6 +10,7 @@ Required properties:
>  	- "renesas,mmcif-r8a7740" for the MMCIF found in r8a7740 SoCs
>  	- "renesas,mmcif-r8a7790" for the MMCIF found in r8a7790 SoCs
>  	- "renesas,mmcif-r8a7791" for the MMCIF found in r8a7791 SoCs
> +	- "renesas,mmcif-r8a7793" for the MMCIF found in r8a7793 SoCs
>  	- "renesas,sh-mmcif" for the generic MMCIF
>  
>  - clocks: reference to the functional clock
> -- 
> 2.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
