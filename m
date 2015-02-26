From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 26 Feb 2015 16:46:49 +0000
Subject: Re: [PATCH v4 1/9] clk: shmobile: Add r8a7778 SoC to MSTP bindings
Message-Id: <4096874.FFN3fcikEk@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1424968934-30577-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1424968934-30577-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

Thank you for the patch.

On Thursday 26 February 2015 17:42:06 Ulrich Hecht wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt index
> 0a80fa7..e163092 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> @@ -13,6 +13,7 @@ Required Properties:
>      - "renesas,r7s72100-mstp-clocks" for R7S72100 (RZ) MSTP gate clocks
>      - "renesas,r8a73a4-mstp-clocks" for R8A73A4 (R-Mobile APE6) MSTP gate
> clocks - "renesas,r8a7740-mstp-clocks" for R8A7740 (R-Mobile A1) MSTP gate
> clocks +    - "renesas,r8a7778-mstp-clocks" for R8A7778 (R-Car M1) MSTP
> gate clocks - "renesas,r8a7779-mstp-clocks" for R8A7779 (R-Car H1) MSTP
> gate clocks - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP
> gate clocks - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP
> gate clocks

-- 
Regards,

Laurent Pinchart

