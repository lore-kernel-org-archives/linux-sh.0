From: Simon Horman <horms@verge.net.au>
Date: Thu, 30 Oct 2014 01:47:08 +0000
Subject: Re: [PATCH 1/2] clk: shmobile: mstp: Update DT bindings to use clock-indices property
Message-Id: <20141030014708.GK22052@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414622133-27247-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1414622133-27247-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Mike Turquette <mturquette@linaro.org>

On Thu, Oct 30, 2014 at 12:35:32AM +0200, Laurent Pinchart wrote:
> The renesas,clock-indices property got standardized, replace it with
> clock-indices.
> 
> The MSTP clock driver supports both the old and new properties.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

This change is fine by me, but it seems to be very similar to a
change sent by Geert. My comment with regards to that was:

I'd appreciate it if you could pick this up (or at least indicate that
you intend to) so I can pick up the remaining in this series that
make use of the new binding.

Acked-by: Simon Horman <horms+renesas@verge.net.au>

I have no particular preference for which version of this patch is accepted.

> ---
>  .../devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt         | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Mike, can you please take this in your tree for v3.19 ?
> 
> diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> index a5f52238c80d..2e18676bd4b5 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> @@ -26,11 +26,11 @@ Required Properties:
>      must appear in the same order as the output clocks.
>    - #clock-cells: Must be 1
>    - clock-output-names: The name of the clocks as free-form strings
> -  - renesas,clock-indices: Indices of the gate clocks into the group (0 to 31)
> +  - clock-indices: Indices of the gate clocks into the group (0 to 31)
>  
> -The clocks, clock-output-names and renesas,clock-indices properties contain one
> -entry per gate clock. The MSTP groups are sparsely populated. Unimplemented
> -gate clocks must not be declared.
> +The clocks, clock-output-names and clock-indices properties contain one entry
> +per gate clock. The MSTP groups are sparsely populated. Unimplemented gate
> +clocks must not be declared.
>  
>  
>  Example
> -- 
> 2.0.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
