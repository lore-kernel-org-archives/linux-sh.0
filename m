From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 03 Nov 2014 09:35:25 +0000
Subject: Re: [PATCH 2/2] clk: shmobile: document DIV6 clock parent bindings
Message-Id: <CAMuHMdWMyTBEw+jRg9+Ku9RvtkB_Cnj9GuU93Mub4rCPhjBMCQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1414767696-23211-1-git-send-email-ulrich.hecht+renesas@gmail.com>
	<1414767696-23211-3-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1414767696-23211-3-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Mike Turquette <mturquette@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Ulrich,

On Fri, Oct 31, 2014 at 4:01 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Adds properties renesas,src-shift and renesas,src-width, and describes
> how to specify the available parent clocks.

Thanks for your patch!

> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  .../bindings/clock/renesas,cpg-div6-clocks.txt     | 28 +++++++++++++++++-----
>  1 file changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> index 952e373..348954b 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> @@ -7,22 +7,38 @@ to 64.
>  Required Properties:
>
>    - compatible: Must be one of the following
> +    - "renesas,r8a73a4-div6-clock" for R8A73A4 (R-Mobile APE6) DIV6 clocks
> +    - "renesas,r8a7740-div6-clock" for R8A7740 (R-Mobile A1) DIV6 clocks
>      - "renesas,r8a7790-div6-clock" for R8A7790 (R-Car H2) DIV6 clocks
>      - "renesas,r8a7791-div6-clock" for R8A7791 (R-Car M2) DIV6 clocks
> +    - "renesas,sh73a0-div6-clock" for SH73A0 (SH-MobileAG5) DIV6 clocks

Missing space between "SH-Mobile" and "AG5".

>      - "renesas,cpg-div6-clock" for generic DIV6 clocks
>    - reg: Base address and length of the memory resource used by the DIV6 clock
> -  - clocks: Reference to the parent clock
> +  - clocks: Reference to the parent clock(s); if there are multiple parent
> +    clocks, one must be specified for each possible parent clock setting
> +    in the clock register. Invalid settings must be specified as "<0>".
> +    Trailing invalid settings may be omitted.

Perhaps it's good to mention "if there are multiple parent clocks, up to
1 << renesas,src-width parent clocks"?

>    - #clock-cells: Must be 0
>    - clock-output-names: The name of the clock as a free-form string
>
> +Optional Properties:
> +
> +  - renesas,src-shift: Bit position of the input clock selector (default:
> +    fixed input clock; requires renesas,src-width)
> +  - renesas,src-width: Bit width of the input clock selector (default: fixed
> +    input clock; requires renesas,src-shift)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
