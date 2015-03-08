From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 08 Mar 2015 10:16:24 +0000
Subject: Re: [PATCH 10/11] clk: shmobile: Add r8a7793 SoC to MSTP bindings
Message-Id: <CAMuHMdVh0duxZe54OLJz3do5gfvOQJmoc1Ryb=eRiY6ruc9X9A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-11-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-11-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 6, 2015 at 6:09 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> @@ -16,6 +16,7 @@ Required Properties:
>      - "renesas,r8a7779-mstp-clocks" for R8A7779 (R-Car H1) MSTP gate clocks
>      - "renesas,r8a7790-mstp-clocks" for R8A7790 (R-Car H2) MSTP gate clocks
>      - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks

Please rename "M2" to "M2-W".

> +    - "renesas,r8a7793-mstp-clocks" for R8A7793 (R-Car M2N) MSTP gate clocks

"M2-N"

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
