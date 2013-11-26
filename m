From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 26 Nov 2013 14:36:02 +0000
Subject: Re: [PATCH RFC v2 02/17] clk: shmobile: r8a7779: Add MSTP clock support
Message-Id: <4636149.Zfz60YsUpd@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1385451139-29686-1-git-send-email-horms+renesas@verge.net.au>
 <1385451139-29686-3-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1385451139-29686-3-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

Thank you for the patch.

On Tuesday 26 November 2013 16:32:04 Simon Horman wrote:
> Add MSTP clock support for the r8a7779 SoC
> 
> The only change required appears to be to note a new
> compatibility string in the bindings.
> 
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt index
> 126b17e..f0a4b83 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> @@ -12,6 +12,7 @@ Required Properties:
>    - compatible: Must be one of the following
>      - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate clocks
>      - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks
> +    - "renesas,r8a7779-mstp-clocks" for R8A7779 (R-Car H1) MSTP gate clocks

Alphabetical order ? :-)

>      - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
>    - reg: Base address and length of the memory resource used by the MSTP
>      clocks
-- 
Regards,

Laurent Pinchart

