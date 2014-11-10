From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2014 13:06:00 +0000
Subject: Re: [PATCH v5 3/6] ARM: shmobile: sh73a0: Common clock framework DT description
Message-Id: <CAMuHMdXAbJMauF3jR=9vS80ThrHxh9MmsL7v44rC5XKQd6qivA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415375369-15209-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1415375369-15209-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Fri, Nov 7, 2014 at 4:49 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> +               /* Gate clocks */
> +               mstp0_clks: mstp0_clks@e6150130 {
> +                       compatible = "renesas,sh73a0-mstp-clocks", "renesas,cpg-mstp-clocks";
> +                       reg = <0xe6150130 4>, <0xe6150030 4>;
> +                       clocks = <&cpg_clocks SH73A0_CLK_HP>;
> +                       #clock-cells = <1>;
> +                       renesas,clock-indices = <

Please use the generic "clock-indices" instead of the deprecated
vendor-specific "renesas,clock-indices".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
