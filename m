From: Mike Turquette <mturquette@linaro.org>
Date: Tue, 13 May 2014 00:05:13 +0000
Subject: Re: [PATCH v5 01/11] ARM: shmobile: r7s72100: document MSTP clock support
Message-Id: <20140513000513.5943.68810@quantum>
List-Id: <linux-sh.vger.kernel.org>
References: <1398765822-2314-1-git-send-email-wsa@the-dreams.de>
 <1398765822-2314-2-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1398765822-2314-2-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Quoting Wolfram Sang (2014-04-29 03:03:32)
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Mike Turquette <mturquette@linaro.org>

No need to take this through the clk tree. Feel free to send it with the
rest through arm-soc.

Regards,
Mike

> ---
>  Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> index 02a25d99ca61..6c3c0847e4fd 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> @@ -10,6 +10,7 @@ index in the group, from 0 to 31.
>  Required Properties:
>  
>    - compatible: Must be one of the following
> +    - "renesas,r7s72100-mstp-clocks" for R7S72100 (RZ) MSTP gate clocks
>      - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate clocks
>      - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks
>      - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
> -- 
> 1.9.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
