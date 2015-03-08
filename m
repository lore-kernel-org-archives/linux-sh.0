From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 08 Mar 2015 10:12:00 +0000
Subject: Re: [PATCH 07/11] clk: shmobile: r8a7793: document DIV6 clock bindings
Message-Id: <CAMuHMdVhdFJQYWxDTO=z7ynk5M5p=s2AbUnGKPQSQyEzhayFXg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-8-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-8-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 6, 2015 at 6:09 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> @@ -11,6 +11,7 @@ Required Properties:
>      - "renesas,r8a7740-div6-clock" for R8A7740 (R-Mobile A1) DIV6 clocks
>      - "renesas,r8a7790-div6-clock" for R8A7790 (R-Car H2) DIV6 clocks
>      - "renesas,r8a7791-div6-clock" for R8A7791 (R-Car M2) DIV6 clocks

Please rename "M2" to "M2-W".

> +    - "renesas,r8a7793-div6-clock" for R8A7793 (R-Car M2N) DIV6 clocks

"M2-N"

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
