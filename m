From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 07 May 2014 14:59:51 +0000
Subject: Re: [PATCH 6/6] clk: shmobile: Add r8a7740, sh73a0 SoCs to MSTP bindings
Message-Id: <CAMuHMdXOgWdA3hO2oX3+KENURvmB2d+Btq-KDoTN7wP1pMJA=g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1399386233-11928-1-git-send-email-ulrich.hecht+renesas@gmail.com>
	<1399386233-11928-7-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1399386233-11928-7-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ulrich Hecht <ulrich.hecht@gmail.com>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Ulrich,

Thanks for your patch!

CC devicetree + one comment below

On Tue, May 6, 2014 at 4:23 PM, Ulrich Hecht <ulrich.hecht@gmail.com> wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> ---
>  Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> index 5992dce..8514088 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> @@ -10,8 +10,10 @@ index in the group, from 0 to 31.
>  Required Properties:
>
>    - compatible: Must be one of the following
> +    - "renesas,r8a7740-mstp-clocks" for R8A7740 MSTP gate clocks

Also known as "R-Mobile A1"

>      - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate clocks
>      - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks
> +    - "renesas,sh73a0-mstp-clocks" for SH73A0 (SH-MobileAG5) MSTP gate clocks
>      - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
>    - reg: Base address and length of the I/O mapped registers used by the MSTP
>      clocks. The first register is the clock control register and is mandatory.
> --
> 1.8.4.5

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
