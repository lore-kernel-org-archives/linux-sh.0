From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 03 Nov 2014 17:24:18 +0000
Subject: Re: [PATCH v6 2/2] clk: shmobile: document DIV6 clock parent bindings
Message-Id: <CAMuHMdVAXFXjkim6OtvUDxCSrMQqYzc6KmE+pHUfrCfyGOZyVg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415030496-26054-1-git-send-email-ulrich.hecht+renesas@gmail.com>
	<1415030496-26054-3-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1415030496-26054-3-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: Simon Horman <horms@verge.net.au>, Mike Turquette <mturquette@linaro.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>

On Mon, Nov 3, 2014 at 5:01 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> @@ -7,11 +7,17 @@ to 64.
>  Required Properties:
>
>    - compatible: Must be one of the following
> +    - "renesas,r8a73a4-div6-clock" for R8A73A4 (R-Mobile APE6) DIV6 clocks
> +    - "renesas,r8a7740-div6-clock" for R8A7740 (R-Mobile A1) DIV6 clocks
>      - "renesas,r8a7790-div6-clock" for R8A7790 (R-Car H2) DIV6 clocks
>      - "renesas,r8a7791-div6-clock" for R8A7791 (R-Car M2) DIV6 clocks
> +    - "renesas,sh73a0-div6-clock" for SH73A0 (SH-Mobile AG5) DIV6 clocks
>      - "renesas,cpg-div6-clock" for generic DIV6 clocks
>    - reg: Base address and length of the memory resource used by the DIV6 clock
> -  - clocks: Reference to the parent clock
> +  - clocks: Reference to the parent clock(s); if there are multiple parent
> +    clocks, one must be specified for each possible parent clock setting
> +    in the clock register. Invalid settings must be specified as "<0>".
> +    Trailing invalid settings may be omitted.

Is there a possibility that omitting trailing invalid settings will cause 4
or less entries for a clock with 8 parents? That would change its class,
and the corresponding src_width and src_shift.

So I'm inclined to say the number of parent clocks must be one of 1, 4, or 8,
i.e. no omissions, to remove this ambiguity.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
