From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Dec 2014 10:10:26 +0000
Subject: Re: [PATCH v2 03/05] ARM: shmobile: sh73a0: Add Multiplatform support
Message-Id: <CAMuHMdUBpEOj9-VfCiwSSjmK+niHKsbtZS7SUv-AW+PeNLXJ2A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141217094234.7039.79623.sendpatchset@w520>
In-Reply-To: <20141217094234.7039.79623.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 17, 2014 at 10:42 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>
> --- 0001/arch/arm/mach-shmobile/Kconfig
> +++ work/arch/arm/mach-shmobile/Kconfig 2014-12-16 19:11:36.000000000 +0900
> @@ -52,6 +52,11 @@ config ARCH_R7S72100
>         bool "RZ/A1H (R7S72100)"
>         select SYS_SUPPORTS_SH_MTU2
>
> +config ARCH_SH73A0
> +       bool "SH-Mobile AG5 (R8A73A00)"
> +       select ARCH_RMOBILE
> +       select RENESAS_INTC_IRQPIN
> +
>  config ARCH_R8A7740
>         bool "R-Mobile A1 (R8A77400)"
>         select ARCH_RMOBILE

Shall we keep this sorted?
That does mean the entries for the old SH73xx are at the end of the
list, though.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
