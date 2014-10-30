From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 30 Oct 2014 10:22:26 +0000
Subject: Re: [PATCH 1/6] clk: shmobile: Deprecate renesas,clock-indices
Message-Id: <1477250.OEPthyD3Lv@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1414592353-24044-1-git-send-email-geert+renesas@glider.be> <1414592353-24044-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1414592353-24044-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mike Turquette <mturquette@linaro.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>, devicetree@vger.kernel.org, linux-sh@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Wednesday 29 October 2014 15:19:08 Geert Uytterhoeven wrote:
> Commit 8e33f91a0b84ae19 ("clk: shmobile: clk-mstp: change to using
> clock-indices") forgot to mark "renesas,clock-indices" deprecated in
> the driver-specific binding documentation.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  .../devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt        | 9 ++++--
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt index
> a5f52238c80d5f9b..26ab9fc499f51113 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> @@ -26,11 +26,12 @@ Required Properties:
>      must appear in the same order as the output clocks.
>    - #clock-cells: Must be 1
>    - clock-output-names: The name of the clocks as free-form strings
> -  - renesas,clock-indices: Indices of the gate clocks into the group (0 to
> 31)
> +  - clock-indices: Indices of the gate clocks into the group (0 to 31)
> +    ("renesas,clock-indices" is deprecated)

Nitpicking here, I would drop the reference to renesas,clock-indices 
completely.

Apart from that, for the whole series,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> -The clocks, clock-output-names and renesas,clock-indices properties contain
> one
> -entry per gate clock. The MSTP groups are sparsely populated. Unimplemented
> -gate clocks must not be declared.
> +The clocks, clock-output-names and clock-indices properties contain one
> entry
> +per gate clock. The MSTP groups are sparsely populated. Unimplemented gate
> +clocks must not be declared.
> 
> 
>  Example

-- 
Regards,

Laurent Pinchart

