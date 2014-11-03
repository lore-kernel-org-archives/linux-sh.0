From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 03 Nov 2014 10:21:17 +0000
Subject: Re: [PATCH 04/12] ARM: shmobile: r8a7791: Add Audio DMAC peri peri devices to DT
Message-Id: <CAMuHMdUbu6dbqV+w7Oe5ByiniBME_R-m0YSxLPoeUhdbBxfCRw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 31, 2014 at 9:01 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -357,6 +357,13 @@
>                 dma-channels = <13>;
>         };
>
> +       audmapp: audio-dma-pp@ec740000 {

generic "dma-controller" instead of "audio-dma-pp"?

> +               compatible = "renesas,rcar-audmapp";
> +               #dma-cells = <1>;
> +
> +               reg = <0 0xec740000 0 0x200>;
> +       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
