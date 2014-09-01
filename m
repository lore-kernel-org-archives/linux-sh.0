From: Mike Turquette <mturquette@linaro.org>
Date: Mon, 01 Sep 2014 22:08:08 +0000
Subject: Re: [PATCH v2 4/6] ARM: shmobile: r8a7794: document MSTP clock support
Message-Id: <20140901220808.5251.7346@quantum>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Quoting Ulrich Hecht (2014-08-29 11:15:08)
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Applied.

Regards,
Mike

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
