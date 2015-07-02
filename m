From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 02 Jul 2015 06:49:59 +0000
Subject: Re: [PATCH] ARM: shmobile: tidyup Renesas generic MSTP gate clocks compatible name
Message-Id: <CAMuHMdWDSTp_wz2iALHdKhjFnOjUts525tRgi0J07uzjsMNn1A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87a8vfm9zb.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87a8vfm9zb.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Jul 2, 2015 at 7:01 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> --- a/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> @@ -18,7 +18,7 @@ Required Properties:
>      - "renesas,r8a7791-mstp-clocks" for R8A7791 (R-Car M2) MSTP gate clocks
>      - "renesas,r8a7794-mstp-clocks" for R8A7794 (R-Car E2) MSTP gate clocks
>      - "renesas,sh73a0-mstp-clocks" for SH73A0 (SH-MobileAG5) MSTP gate clocks
> -    - "renesas,cpg-mstp-clock" for generic MSTP gate clocks
> +    - "renesas,cpg-mstp-clocks" for generic MSTP gate clocks

Already fixed in upstream commit 17df1fb2e502371b ("clk: shmobile: mstp:
Document mandatory compatible fallback").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
