From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Aug 2014 23:32:08 +0000
Subject: Re: [PATCH 6/8] ARM: shmobile: r8a7794: document MSTP clock support
Message-Id: <20140818233208.GC1623@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1408377107-3822-7-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1408377107-3822-7-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 18, 2014 at 05:51:45PM +0200, Ulrich Hecht wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

Mike, could you consider taking this?
It does not appear to depend on anything.

> ---
>  Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> index 8a92b5f..a03c8c0 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> @@ -14,6 +14,7 @@ Required Properties:
>      - "renesas,r8a7779-mstp-clocks" for R8A7779 (R-Car H1) MSTP gate clocks
>      - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate clocks
>      - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks
> +    - "renesas,r8a7794-mstp-clocks" for R8A7794 (R-Car E2) MSTP gate clocks
>      - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
>    - reg: Base address and length of the I/O mapped registers used by the MSTP
>      clocks. The first register is the clock control register and is mandatory.
> -- 
> 1.8.4.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
