From: Simon Horman <horms@verge.net.au>
Date: Mon, 24 Feb 2014 00:35:50 +0000
Subject: Re: [PATCH] clk: shmobile: Fix typoe in MSTP clock DT bindings
Message-Id: <20140224003550.GF3898@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1392830004-5706-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1392830004-5706-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>

On Wed, Feb 19, 2014 at 06:13:24PM +0100, Laurent Pinchart wrote:
> The DT bindings document a renesas,indices property, while the code, the
> DT example and the DT sources all use renesas,clock-indices. Fix the
> documentation.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>


Acked-by: Simon Horman <horms@verge.net.au>

BTW, there is a typo (in the word typo) in the subject :^)

> ---
>  Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Mike, this is a v3.14 bug fix. You can find all three Renesas clock bugfixes
> for v3.14 in
> 
> 	git://linuxtv.org/pinchartl/fbdev.git clocks/next/drivers
> 
> I'll wait a day and send a pull request just to make sure no patch gets
> forgotten.
> 
> diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> index a6a352c..5992dce 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> @@ -21,9 +21,9 @@ Required Properties:
>      must appear in the same order as the output clocks.
>    - #clock-cells: Must be 1
>    - clock-output-names: The name of the clocks as free-form strings
> -  - renesas,indices: Indices of the gate clocks into the group (0 to 31)
> +  - renesas,clock-indices: Indices of the gate clocks into the group (0 to 31)
>  
> -The clocks, clock-output-names and renesas,indices properties contain one
> +The clocks, clock-output-names and renesas,clock-indices properties contain one
>  entry per gate clock. The MSTP groups are sparsely populated. Unimplemented
>  gate clocks must not be declared.
>  
> -- 
> Regards,
> 
> Laurent Pinchart
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
