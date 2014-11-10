From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Nov 2014 13:07:00 +0000
Subject: Re: [PATCH 4/6] ARM: shmobile: r8a73a4: Common clock framework DT description
Message-Id: <CAMuHMdW2GbfOG6UvqshGuQs4=haNpsdoXpF4xXpMStH7kQq8Hg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415375524-15468-5-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1415375524-15468-5-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Fri, Nov 7, 2014 at 4:52 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> +               /* Gate clocks */
> +               mstp2_clks: mstp2_clks@e6150138 {
> +                       compatible = "renesas,r8a73a4-mstp-clocks", "renesas,cpg-mstp-clocks";
> +                       reg = <0 0xe6150138 0 4>, <0 0xe6150040 0 4>;
> +                       clocks = <&mp_clk>, <&mp_clk>, <&mp_clk>, <&mp_clk>,
> +                                <&mp_clk>, <&mp_clk>, <&cpg_clocks R8A73A4_CLK_HP>;
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
