From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Aug 2015 09:30:33 +0000
Subject: Re: [PATCH 11/25 v7][RFC] arm64: renesas: r8a7795: add mstp7 node and enable HSUSB clock
Message-Id: <CAMuHMdXBbrDouU6GMA6FrsZgQhWBtKp_p4H3exm1rMr7RUtMNw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87d1yd7797.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87d1yd7797.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Morimoto-san, Shimoda-san,

On Mon, Aug 24, 2015 at 4:28 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -100,6 +100,16 @@
>                                         renesas,clock-indices = <R8A7795_CLK_SCIF2>;
>                                         clock-output-names = "scif2";
>                                 };
> +
> +                               mstp7_clks: mstp7_clks@e615014c {
> +                                       compatible = "renesas,r8a7795-mstp-clocks",
> +                                                    "renesas,cpg-mstp-clocks";
> +                                       reg = <0 0xe615014c 0 4>, <0 0xe61501c4 0 4>;
> +                                       clocks =  <&s3d4_clk>;

Shouldn't this be the "s3d2" clock?

> +                                       #clock-cells = <1>;
> +                                       renesas,clock-indices = <R8A7795_CLK_HSUSB>;
> +                                       clock-output-names = "hsusb";
> +                               };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
