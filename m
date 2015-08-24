From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Aug 2015 09:50:19 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7778: tidyup SSI resource region
Message-Id: <CAMuHMdWXCMBoDFAQ2JRTrGW87SpVKBdvjadmuOLEPb6c9jhX8A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87oahx5c3a.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87oahx5c3a.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 24, 2015 at 10:27 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> --- a/arch/arm/boot/dts/r8a7778.dtsi
> +++ b/arch/arm/boot/dts/r8a7778.dtsi
> @@ -239,7 +239,7 @@
>                 #sound-dai-cells = <1>;
>                 compatible = "renesas,rcar_sound-r8a7778", "renesas,rcar_sound-gen1";
>                 reg =   <0xffd90000 0x1000>,    /* SRU */
> -                       <0xffd91000 0x1240>,    /* SSI */
> +                       <0xffd91000 0x270>,     /* SSI */

Why not 0x240?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
