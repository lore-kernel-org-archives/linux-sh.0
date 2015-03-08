From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 08 Mar 2015 09:32:13 +0000
Subject: Re: [PATCH 02/11] ARM: shmobile: Basic r8a7793 SoC support
Message-Id: <CAMuHMdVMtT_FJq7GkxhzotMUn1SE_aqkO9sTXX4teXzqDp34Tw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425661798-10487-3-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1425661798-10487-3-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 6, 2015 at 6:09 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> --- a/arch/arm/mach-shmobile/Kconfig
> +++ b/arch/arm/mach-shmobile/Kconfig
> @@ -75,6 +75,10 @@ config ARCH_R8A7791
>         bool "R-Car M2-W (R8A77910)"
>         select ARCH_RCAR_GEN2
>
> +config ARCH_R8A7793
> +       bool "R-Car M2N (R8A77940)"

The datasheet calls the SoC "M2-N" (with dash).
The part number should probably be "R8A77930" (not sure about
the trailing zero).

> +       select ARCH_RCAR_GEN2

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
