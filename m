From: Simon Horman <horms@verge.net.au>
Date: Fri, 01 May 2015 00:44:19 +0000
Subject: Re: [PATCH v2 06/15] pinctrl: sh-pfc: Add renesas,pfc-r8a7793 to binding documentation
Message-Id: <20150501004419.GE13754@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1430403544-26742-1-git-send-email-ulrich.hecht+renesas@gmail.com>
 <1430403544-26742-7-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1430403544-26742-7-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: geert@linux-m68k.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart+renesas@ideasonboard.com, kuninori.morimoto.gx@renesas.com, linus.walleij@linaro.org, devicetree@vger.kernel.org

On Thu, Apr 30, 2015 at 04:18:55PM +0200, Ulrich Hecht wrote:
> Also renames "R-Car M2" to "R-Car M2-W" to avoid confusion.
> 
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> Cc: devicetree@vger.kernel.org

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
> index bfe72ec..6bcf851 100644
> --- a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
> @@ -16,7 +16,8 @@ Required Properties:
>      - "renesas,pfc-r8a7778": for R8A7778 (R-Mobile M1) compatible pin-controller.
>      - "renesas,pfc-r8a7779": for R8A7779 (R-Car H1) compatible pin-controller.
>      - "renesas,pfc-r8a7790": for R8A7790 (R-Car H2) compatible pin-controller.
> -    - "renesas,pfc-r8a7791": for R8A7791 (R-Car M2) compatible pin-controller.
> +    - "renesas,pfc-r8a7791": for R8A7791 (R-Car M2-W) compatible pin-controller.
> +    - "renesas,pfc-r8a7793": for R8A7793 (R-Car M2-N) compatible pin-controller.
>      - "renesas,pfc-sh73a0": for SH73A0 (SH-Mobile AG5) compatible pin-controller.
>  
>    - reg: Base address and length of each memory resource used by the pin
> -- 
> 2.3.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
