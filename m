From: Mike Turquette <mturquette@linaro.org>
Date: Mon, 01 Sep 2014 22:08:22 +0000
Subject: Re: [PATCH v2 6/6] ARM: shmobile: r8a7794: document CPG clock support
Message-Id: <20140901220822.5251.23626@quantum>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Quoting Ulrich Hecht (2014-08-29 11:15:10)
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Applied.

Regards,
Mike

> ---
>  Documentation/devicetree/bindings/clock/renesas,rcar-gen2-cpg-clocks.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
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
