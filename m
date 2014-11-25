From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 25 Nov 2014 09:47:30 +0000
Subject: Re: [PATCH v2 2/6] clk: shmobile: Add r8a73a4 SoC to MSTP bindings
Message-Id: <23617478.HoWsKhnPQ3@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1416500496-21024-3-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1416500496-21024-3-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Thursday 20 November 2014 17:21:32 Ulrich Hecht wrote:

A commit message would be nice.

> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt index
> a5f5223..e566fb7 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> @@ -11,6 +11,7 @@ Required Properties:
> 
>    - compatible: Must be one of the following
>      - "renesas,r7s72100-mstp-clocks" for R7S72100 (RZ) MSTP gate clocks
> +    - "renesas,r8a73a4-mstp-clocks" for R8A73A4 (R-Mobile APE6) MSTP gate
> clocks - "renesas,r8a7740-mstp-clocks" for R8A7740 (R-Mobile A1) MSTP gate
> clocks - "renesas,r8a7779-mstp-clocks" for R8A7779 (R-Car H1) MSTP gate
> clocks - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate
> clocks

-- 
Regards,

Laurent Pinchart

