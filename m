From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 27 Feb 2015 08:08:22 +0000
Subject: Re: [PATCH v4 6/9] ARM: shmobile: r8a7778: add sound to DT
Message-Id: <CAMuHMdUcnBjPxciHbrSTc78thsmst4r7a4D5pdQ7+2Jx_mQmLQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1424968934-30577-7-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1424968934-30577-7-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 26, 2015 at 5:42 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> --- a/arch/arm/boot/dts/r8a7778.dtsi
> +++ b/arch/arm/boot/dts/r8a7778.dtsi
> @@ -227,6 +227,61 @@
>                 status = "disabled";
>         };
>
> +       rcar_sound: sound@ffd90000 {
> +               #sound-dai-cells = <1>;
> +               compatible = "renesas,rcar_sound-r8a7778", "renesas,rcar_sound-gen1", "renesas,rcar_sound";

Please drop the "renesas,rcar_sound" compatible value, as it was never
processed nor documented.

Cfr. e.g. commit f49cd2b3d2caf075d7 ("ARM: shmobile: r8a7791 dtsi:
Drop "renesas,rcar_sound" compatible value").

Sorry for not noticing before.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
