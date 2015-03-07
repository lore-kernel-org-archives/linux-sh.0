From: Simon Horman <horms@verge.net.au>
Date: Sat, 07 Mar 2015 00:07:21 +0000
Subject: Re: [PATCH 07/11] clk: shmobile: r8a7793: document DIV6 clock bindings
Message-Id: <20150307000720.GH19866@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-8-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-8-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 06, 2015 at 06:09:54PM +0100, Ulrich Hecht wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> index 054f65f..6bada02 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> @@ -11,6 +11,7 @@ Required Properties:
>      - "renesas,r8a7740-div6-clock" for R8A7740 (R-Mobile A1) DIV6 clocks
>      - "renesas,r8a7790-div6-clock" for R8A7790 (R-Car H2) DIV6 clocks
>      - "renesas,r8a7791-div6-clock" for R8A7791 (R-Car M2) DIV6 clocks
> +    - "renesas,r8a7793-div6-clock" for R8A7793 (R-Car M2N) DIV6 clocks
>      - "renesas,sh73a0-div6-clock" for SH73A0 (SH-Mobile AG5) DIV6 clocks
>      - "renesas,cpg-div6-clock" for generic DIV6 clocks
>    - reg: Base address and length of the memory resource used by the DIV6 clock
> -- 
> 2.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
