From: Simon Horman <horms@verge.net.au>
Date: Sat, 07 Mar 2015 00:06:23 +0000
Subject: Re: [PATCH 10/11] clk: shmobile: Add r8a7793 SoC to MSTP bindings
Message-Id: <20150307000623.GE19866@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-11-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-11-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 06, 2015 at 06:09:57PM +0100, Ulrich Hecht wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

> ---
>  Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> index 0a80fa7..f5ea999 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> @@ -16,6 +16,7 @@ Required Properties:
>      - "renesas,r8a7779-mstp-clocks" for R8A7779 (R-Car H1) MSTP gate clocks
>      - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate clocks
>      - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks
> +    - "renesas,r8a7793-mstp-clocks" for R8A7793 (R-Car M2N) MSTP gate clocks
>      - "renesas,r8a7794-mstp-clocks" for R8A7794 (R-Car E2) MSTP gate clocks
>      - "renesas,sh73a0-mstp-clocks" for SH73A0 (SH-MobileAG5) MSTP gate clocks
>      - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
> -- 
> 2.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
